//
//  BannerModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

struct BannerModel: Identifiable {
    let id: UUID
    let image: String
    let title: String
    
    init(id: UUID = UUID(), image: String, title: String) {
        self.id = id
        self.image = image
        self.title = title
    }
}
