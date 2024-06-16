//
//  UserViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 13.06.2024.
//

import Combine
import Firebase

class UserViewModel: ObservableObject {
    @Published var user: UserData?
    @Published var isLoading = false
    @Published var errorMessage: String?

    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    private let cache = NSCache<NSString, UserData>()

    // Метод для загрузки данных пользователя
    func fetchUserData(uid: String) {
        // Проверка наличия данных в кэше
        if let cachedUser = cache.object(forKey: uid as NSString) {
            self.user = cachedUser
            return
        }

        isLoading = true
        errorMessage = nil

        db.collection("users").document(uid).getDocument { [weak self] document, error in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.isLoading = false
                if let document = document, document.exists {
                    let data = document.data() ?? [:]
                    let userData = UserData(uid: uid, data: data)
                    self.user = userData
                    // Сохранение данных в кэш
                    self.cache.setObject(userData, forKey: uid as NSString)
                } else {
                    self.errorMessage = "Failed to fetch user data"
                }
            }
        }
    }
}
