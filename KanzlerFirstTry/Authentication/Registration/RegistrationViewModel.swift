//
//  RegistrationViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 27.05.2024.
//

import SwiftUI
import Foundation
import Combine

class RegistrationViewModel: ObservableObject {
    @Published var phoneNumber: String = ""
    @Published var password: String = ""
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

    // Enum для пола
    enum Gender: String {
        case male = "Мужской"
        case female = "Женский"
    }

    // Логика регистрации пользователя
    func registerUser() {
        let birthDate = "\(selection ?? "") \(selection1 ?? "") \(selection2 ?? "")"
        let gender = selectedGender?.rawValue ?? ""

        // Подготовка данных для регистрации
        AuthManager.shared.prepareUserRegistration(
            phoneNumber: phoneNumber,
            password: password,
            name: userName,
            surname: userSurname,
            birthDate: birthDate,
            gender: gender
        )

        // Инициировать отправку СМС-кода
        AuthManager.shared.startAuth(phoneNumber: phoneNumber) { success in
            if success {
                // Переход к экрану подтверждения номера
                self.showNumberConfirmation = true
            } else {
                // Обработка ошибки
            }
        }
    }
}

