//
//  UserViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 13.06.2024.
//

import Combine
import Firebase
import CoreImage.CIFilterBuiltins

class UserViewModel: ObservableObject {
    @Published var user: UserData?
    @Published var isLoading = false
    @Published var errorMessage: String?
    @Published var qrCodeImage: UIImage?
    
    private var db = Firestore.firestore()
    private var cancellables = Set<AnyCancellable>()
    private let cache = NSCache<NSString, UserData>()

    // Метод для загрузки данных пользователя
    func fetchUserData(uid: String) {
        // Проверка наличия данных в кэше
        if let cachedUser = cache.object(forKey: uid as NSString) {
            self.user = cachedUser
            self.generateQRCode(from: uid)
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
                    self.cache.setObject(userData, forKey: uid as NSString)
                    self.generateQRCode(from: uid)
                } else {
                    self.errorMessage = "Failed to fetch user data"
                }
            }
        }
    }

    // Метод для генерации QR-кода из строки
    private func generateQRCode(from string: String) {
        let data = Data(string.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")

        let transform = CGAffineTransform(scaleX: 10, y: 10)
        if let qrImage = filter.outputImage?.transformed(by: transform) {
            let context = CIContext()
            if let cgImage = context.createCGImage(qrImage, from: qrImage.extent) {
                self.qrCodeImage = UIImage(cgImage: cgImage)
            }
        }
    }
}
