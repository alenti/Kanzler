//
//  AuthManager.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 24.12.2023.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore

class AuthManager {
    static let shared = AuthManager()
    private let auth = Auth.auth()
    private var verificationId: String?
    public var tempUserData: [String: Any]?

    public func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] verificationId, error in
            if let error = error {
                print("Ошибка отправки SMS: \(error.localizedDescription)")
                completion(false)
                return
            }
            guard let verificationId = verificationId else {
                completion(false)
                return
            }
            self?.verificationId = verificationId
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
            if let error = error {
                print("Ошибка при верификации кода: \(error.localizedDescription)")
                completion(false)
                return
            }
            
            if let user = result?.user {
                self?.checkUserExistence(user: user, completion: completion)
            } else {
                completion(false)
            }
        }
    }
    
    private func checkUserExistence(user: FirebaseAuth.User, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").document(user.uid).getDocument { [weak self] document, error in
            if let document = document, document.exists {
                completion(true)
            } else {
                self?.registerUser(userData: self?.tempUserData ?? [:]) { success in
                    completion(success)
                }
            }
        }
    }

    public func registerUser(userData: [String: Any], completion: @escaping (Bool) -> Void) {
        guard let userId = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        
        var userData = userData
        userData.removeValue(forKey: "email")
        userData.removeValue(forKey: "password")
        
        let db = Firestore.firestore()
        db.collection("users").document(userId).setData(userData) { [weak self] error in
            if let error = error {
                print("Ошибка при сохранении данных пользователя: \(error.localizedDescription)")
                completion(false)
            } else {
                self?.generateAndSaveQRCode(userId: userId, userData: userData, completion: completion)
            }
        }
    }
    
    private func generateAndSaveQRCode(userId: String, userData: [String: Any], completion: @escaping (Bool) -> Void) {
        let qrData = "\(userId);\(userData["phoneNumber"] as? String ?? "")"
        let db = Firestore.firestore()
        db.collection("users").document(userId).updateData(["qrCode": qrData]) { error in
            completion(error == nil)
        }
    }
    
    public func prepareUserRegistration(phoneNumber: String, name: String, surname: String, birthDate: String, gender: String) {
        tempUserData = [
            "phoneNumber": phoneNumber,
            "name": name,
            "surname": surname,
            "birthDate": birthDate,
            "gender": gender
        ]
    }
}
