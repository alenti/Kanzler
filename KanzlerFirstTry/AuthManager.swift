//
//  AuthManager.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 24.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import UIKit
import CoreImage.CIFilterBuiltins


class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    
    private var verificationId: String?
    private var tempUserData: [String: Any]?

    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            guard let strongSelf = self, let verificationId = verificationId, error == nil else {
                completion(false)
                return
            }
            strongSelf.verificationId = verificationId
            completion(true)
        }
    }

   
    public func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationId = verificationId else {
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: smsCode)
        auth.signIn(with: credential) { [weak self] result, error in
            guard result != nil, error == nil else {
                completion(false)
                return
            }
            // После успешной верификации, регистрируем пользователя
            if let tempUserData = self?.tempUserData {
                self?.registerUser(userData: tempUserData, completion: completion)
            } else {
                completion(true)
            }
        }
    }

    public func prepareUserRegistration(phoneNumber: String, password: String, name: String, surname: String, birthDate: String, gender: String) {
        let email = "\(phoneNumber)@kanzlerapp.com"
        tempUserData = [
            "email": email,
            "password": password,
            "name": name,
            "surname": surname,
            "phoneNumber": phoneNumber,
            "birthDate": birthDate,
            "gender": gender
        ]
    }

    private func registerUser(userData: [String: Any], completion: @escaping (Bool) -> Void) {
        guard let email = userData["email"] as? String, let password = userData["password"] as? String else {
            completion(false)
            return
        }

        auth.createUser(withEmail: email, password: password) { [weak self] authResult, error in
            if let error = error {
                completion(false)
                return
            }

            guard let userId = authResult?.user.uid else {
                completion(false)
                return
            }

            var userData = userData
            userData.removeValue(forKey: "email")
            userData.removeValue(forKey: "password")
            
            self?.saveUserData(userId: userId, userData: userData, completion: completion)
        }
    }

    private func saveUserData(userId: String, userData: [String: Any], completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData(userData) { error in
            if let error = error {
                completion(false)
            } else {
                completion(true)
            }
        }
    }
    
    func generateAndSaveQRCode(userId: String, userData: [String: Any], completion: @escaping (Bool) -> Void) {
        let qrData = "\(userId);\(userData["phoneNumber"] as? String ?? "")"
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData(["qrCode": qrData]) { error in
            completion(error == nil)
        }
    }

    private func generateQRCodeImage(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")

        if let outputImage = filter.outputImage?.transformed(by: CGAffineTransform(scaleX: 10, y: 10)) {
            let context = CIContext()
            if let cgImage = context.createCGImage(outputImage, from: outputImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
}
