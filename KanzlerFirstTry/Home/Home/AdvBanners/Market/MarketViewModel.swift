//
//  MarketViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

class MarketViewModel: ObservableObject {
    @Published var markets: [MarketModel] = [
        MarketModel (name: "Гоголя/Оронбаева", address: "Огонбаева Атая,222", phone: "+996 777-90-22-33", hours: "09:00 - 18:00"),
        MarketModel (name: "Гоголя/Оронбаева", address: "Огонбаева Атая,222", phone: "+996 777-90-22-33", hours: "09:00 - 18:00"),
        MarketModel (name: "Гоголя/Оронбаева", address: "Огонбаева Атая,222", phone: "+996 777-90-22-33", hours: "09:00 - 18:00"),
    ]
    
}
