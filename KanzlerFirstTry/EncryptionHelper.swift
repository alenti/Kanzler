//
//  EncryptionHelper.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 11.06.2024.
//

import Foundation
import CryptoKit

struct EncryptionHelper {
    private static let key = SymmetricKey(size: .bits256)

    static func encrypt(_ string: String) -> String? {
        let data = Data(string.utf8)
        do {
            let sealedBox = try AES.GCM.seal(data, using: key)
            return sealedBox.combined?.base64EncodedString()
        } catch {
            print("Error encrypting: \(error)")
            return nil
        }
    }

    static func decrypt(_ base64String: String) -> String? {
        guard let data = Data(base64Encoded: base64String) else { return nil }
        do {
            let sealedBox = try AES.GCM.SealedBox(combined: data)
            let decryptedData = try AES.GCM.open(sealedBox, using: key)
            return String(data: decryptedData, encoding: .utf8)
        } catch {
            print("Error decrypting: \(error)")
            return nil
        }
    }
}
