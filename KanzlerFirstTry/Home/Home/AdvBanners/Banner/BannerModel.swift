//
//  BannerModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI
import Firebase

struct BannerModel: Identifiable {
    let id: UUID
    let imagePath: String
    let title: String
    let timestamp: Timestamp
    
    init(id: UUID = UUID(), imagePath: String, title: String, timestamp: Timestamp) {
        self.id = id
        self.imagePath = imagePath
        self.title = title
        self.timestamp = timestamp
    }
}
