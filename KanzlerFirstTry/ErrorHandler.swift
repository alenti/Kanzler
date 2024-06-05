//
//  ErrorHandler.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 03.06.2024.
//
//
//import Combine
//import SwiftUI
//import Firebase
//
//enum AppError: LocalizedError {
//    case userNotFound
//    case wrongPassword
//    case weakPassword
//    case emailAlreadyInUse
//    case invalidEmail
//    case networkError
//    case unknownError
//
//    var errorDescription: String? {
//        switch self {
//        case .userNotFound:
//            return "Пользователь не найден"
//        case .wrongPassword:
//            return "Неверный пароль"
//        case .weakPassword:
//            return "Пароль должен содержать минимум 6 символов"
//        case .emailAlreadyInUse:
//            return "Электронная почта уже используется"
//        case .invalidEmail:
//            return "Недействительная электронная почта"
//        case .networkError:
//            return "Ошибка сети"
//        case .unknownError:
//            return "Неизвестная ошибка"
//        }
//    }
//}
//
//class ErrorHandler: ObservableObject {
//    @Published var alert: SystemBarAlert? = nil
//
//    func handle(error: AppError) {
//        let alert = SystemBarAlert(
//            message: error.localizedDescription,
//            symbol: "exclamationmark.triangle.fill",
//            color: .yellow,
//            isButton: false
//        )
//        DispatchQueue.main.async {
//            self.alert = alert
//        }
//    }
//
//    func handleFirebaseError(_ error: NSError) {
//        if let errorCode = AuthErrorCode.Code(rawValue: error.code) {
//            switch errorCode {
//            case .weakPassword:
//                handle(error: .weakPassword)
//            case .emailAlreadyInUse:
//                handle(error: .emailAlreadyInUse)
//            case .invalidEmail:
//                handle(error: .invalidEmail)
//            case .networkError:
//                handle(error: .networkError)
//            default:
//                handle(error: .unknownError)
//            }
//        } else {
//            handle(error: .unknownError)
//        }
//    }
//}
