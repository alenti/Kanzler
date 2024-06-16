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
    
    private init() {}

    var tempUserData: [String: Any]?
    
    func checkUserExistence(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        db.collection("users").whereField("phoneNumber", isEqualTo: phoneNumber).getDocuments { snapshot, error in
            if let error = error {
                print("Error checking user existence: \(error)")
                completion(false)
                return
            }
            completion(!(snapshot?.documents.isEmpty ?? true))
        }
    }
    
    func prepareUserRegistration(phoneNumber: String, name: String, surname: String, birthDate: String, gender: String, isAgreeWithTerms: Bool, isConsentToDataProcessing: Bool, wantsSMSNotifications: Bool) {
            tempUserData = [
                //Узнать значения UUID и UID
                "uid": Auth.auth().currentUser?.uid ?? UUID().uuidString, // UUID пользователя
                //
                "phoneNumber": phoneNumber,
                "name": name,
                "surname": surname,
                "birthDate": birthDate,
                "gender": gender,
                "bonusPoints": EncryptionHelper.encrypt("0") ?? "0", // зашифрованные бонусы
                "cashbackPercentage": EncryptionHelper.encrypt("5") ?? "5", // зашифрованный кэшбек
                "isAgreeWithTerms": isAgreeWithTerms,
                "isConsentToDataProcessing": isConsentToDataProcessing,
                "wantsSMSNotifications": wantsSMSNotifications
            ]
        }

    func startAuth(phoneNumber: String, completion: @escaping (Bool) -> Void) {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { verificationID, error in
            if let error = error {
                print("Error during phone number verification: \(error)")
                completion(false)
                return
            }
            UserDefaults.standard.set(verificationID, forKey: "authVerificationID")
            completion(true)
        }
    }

    func verifyCode(smsCode: String, completion: @escaping (Bool) -> Void) {
        guard let verificationID = UserDefaults.standard.string(forKey: "authVerificationID") else {
            completion(false)
            return
        }
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationID, verificationCode: smsCode)
        Auth.auth().signIn(with: credential) { authResult, error in
            if let error = error {
                print("Error verifying code: \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    func resendCode(completion: @escaping (Bool) -> Void) {
            guard let phoneNumber = tempUserData?["phoneNumber"] as? String else {
                completion(false)
                return
            }

            startAuth(phoneNumber: phoneNumber) { success in
                completion(success)
            }
        }

    func registerUser(userData: [String: Any], completion: @escaping (Bool) -> Void) {
        let db = Firestore.firestore()
        guard let uid = Auth.auth().currentUser?.uid else {
            completion(false)
            return
        }
        db.collection("users").document(uid).setData(userData) { error in
            if let error = error {
                print("Error registering user: \(error)")
                completion(false)
                return
            }
            completion(true)
        }
    }
    
    //Дешифрование данные из FireBase
    func fetchUserData(uid: String, completion: @escaping ([String: Any]?) -> Void) {
           let db = Firestore.firestore()
           db.collection("users").document(uid).getDocument { document, error in
               if let document = document, document.exists {
                   var data = document.data()
                   if let encryptedBonusPoints = data?["bonusPoints"] as? String {
                       data?["bonusPoints"] = EncryptionHelper.decrypt(encryptedBonusPoints)
                   }
                   if let encryptedCashbackPercentage = data?["cashbackPercentage"] as? String {
                       data?["cashbackPercentage"] = EncryptionHelper.decrypt(encryptedCashbackPercentage)
                   }
                   completion(data)
               } else {
                   print("Document does not exist or error fetching document: \(String(describing: error))")
                   completion(nil)
               }
           }
       }
}
