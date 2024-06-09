//
//  RegistrationViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 27.05.2024.
//

import Combine
import SwiftUI

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
    @Published var errorHandler = ErrorHandler()

    enum Gender: String {
        case male = "Мужской"
        case female = "Женский"
    }

    func registerUser() {
        guard validateFields() else {
            return
        }

        AuthManager.shared.checkUserExistence(phoneNumber: phoneNumber) { [weak self] exists in
            guard let self = self else { return }
            DispatchQueue.main.async {
                if exists {
                    self.errorHandler.handleCustomError("Пользователь уже зарегистрирован")
                    self.forceViewUpdate() // Force view update
                } else {
                    let birthDate = "\(self.selection ?? "") \(self.selection1 ?? "") \(self.selection2 ?? "")"
                    let gender = self.selectedGender?.rawValue ?? ""

                    AuthManager.shared.prepareUserRegistration(
                        phoneNumber: self.phoneNumber,
                        name: self.userName,
                        surname: self.userSurname,
                        birthDate: birthDate,
                        gender: gender
                    )

                    AuthManager.shared.startAuth(phoneNumber: self.phoneNumber) { success in
                        DispatchQueue.main.async {
                            if success {
                                print("SMS отправлено успешно")
                                self.showNumberConfirmation = true
                            } else {
                                self.errorHandler.handleCustomError("Ошибка отправки SMS")
                                self.forceViewUpdate() // Force view update
                            }
                        }
                    }
                }
            }
        }
    }

    private func validateFields() -> Bool {
        if phoneNumber.isEmpty || userName.isEmpty || userSurname.isEmpty || selection == nil || selection1 == nil || selection2 == nil || selectedGender == nil {
            errorHandler.handleCustomError("Заполните все поля")
            forceViewUpdate() // Force view update
            return false
        }
        if !isAgreeWithTerms || !isConsentToDataProcessing {
            errorHandler.handleCustomError("Вы должны согласиться с условиями")
            forceViewUpdate() // Force view update
            return false
        }
        return true
    }
    
    private func forceViewUpdate() {
        DispatchQueue.main.async {
            self.objectWillChange.send()
        }
    }
}
