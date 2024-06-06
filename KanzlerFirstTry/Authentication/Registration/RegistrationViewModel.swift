//
//  RegistrationViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 27.05.2024.
//

import SwiftUI
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var userName: String = ""
    @Published var userSurname: String = ""
    @Published var gender: String = ""
    @Published var selection: String?
    @Published var selection1: String?
    @Published var selection2: String?
    @Published var selectedGender: Gender? = nil
    @Published var isAgreeWithTerms: Bool = false
    @Published var isConsentToDataProcessing: Bool = false
    @Published var wantsSMSNotifications: Bool = false
    @Published var showNumberConfirmation: Bool = false

    enum Gender: String {
        case male = "Мужской"
        case female = "Женский"
    }

    func registerUser() {
        let birthDate = "\(selection ?? "") \(selection1 ?? "") \(selection2 ?? "")"
        let gender = selectedGender?.rawValue ?? ""

        AuthManager.shared.prepareUserRegistration(
            phoneNumber: phoneNumber,
            name: userName,
            surname: userSurname,
            birthDate: birthDate,
            gender: gender
        )

        AuthManager.shared.startAuth(phoneNumber: phoneNumber) { success in
            DispatchQueue.main.async {
                if success {
                    print("SMS отправлено успешно")
                    self.showNumberConfirmation = true
                } else {
                    print("Ошибка отправки SMS")
                }
            }
        }
    }
}

