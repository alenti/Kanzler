//
//  QRGenerator.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 12.04.2024.
//

import SwiftUI
import CoreImage.CIFilterBuiltins
import UIKit
import Firebase

class QRGenerator {
    static let shared = QRGenerator()

    private init() {}

    // Функция для загрузки QR-кода пользователя из Firebase
    func loadQRCode(userID: String, completion: @escaping (UIImage?) -> Void) {
        let db = Firestore.firestore()
        let docRef = db.collection("users").document(userID)

        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                if let qrCodeString = document.data()?["qrCode"] as? String {
                    let image = self.generateQRCode(from: qrCodeString)
                    completion(image)
                } else {
                    print("QR Code not found")
                    completion(nil)
                }
            } else {
                print("Document does not exist")
                completion(nil)
            }
        }
    }

    // Функция для генерации QR-кода из строки
    func generateQRCode(from string: String) -> UIImage? {
        let data = Data(string.utf8)
        let filter = CIFilter.qrCodeGenerator()
        filter.setValue(data, forKey: "inputMessage")

        let transform = CGAffineTransform(scaleX: 10, y: 10)
        if let qrImage = filter.outputImage?.transformed(by: transform) {
            let context = CIContext()
            if let cgImage = context.createCGImage(qrImage, from: qrImage.extent) {
                return UIImage(cgImage: cgImage)
            }
        }
        return nil
    }
}

