//
//  MarketModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

struct MarketModel: Identifiable {
    let id : UUID
    let name: String
    let address: String
    let phone: String
    let hours: String
    
    init(id: UUID = UUID(), name: String, address: String,phone: String, hours: String) {
        self.id = id
        self.name = name
        self.address = address
        self.phone = phone
        self.hours = hours
    }
}
