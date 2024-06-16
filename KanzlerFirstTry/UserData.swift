//
//  User.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 11.06.2024.
//

import Foundation

class UserData: NSObject {
    var uid: String
    var name: String
    var surname: String
    var phoneNumber: String
    var bonusPoints: Int
    var discount: Int

    init(uid: String, data: [String: Any]) {
        self.uid = uid
        self.name = data["name"] as? String ?? ""
        self.surname = data["surname"] as? String ?? ""
        self.phoneNumber = data["phoneNumber"] as? String ?? ""
        self.bonusPoints = Int(EncryptionHelper.decrypt(data["bonusPoints"] as? String ?? "") ?? "0") ?? 0
        self.discount = Int(EncryptionHelper.decrypt(data["cashbackPercentage"] as? String ?? "") ?? "5") ?? 5
    }

    // Добавление метода для создания объекта UserData с пустыми значениями
    static var placeholder: UserData {
        return UserData(uid: "", data: [:])
    }
}
