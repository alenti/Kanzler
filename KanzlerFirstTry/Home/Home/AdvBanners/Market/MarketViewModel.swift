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
        MarketModel (name: "Дзержинка/Боконбаева", address: "​Бульвар Эркиндик,7", phone: "+996 777-90-22-34", hours: "09:00 - 18:00"),
        MarketModel (name: "Киевская/Уметалиева", address: "​Уметалиева, 84", phone: "+996 777-90-22-36", hours: "09:00 - 18:00"),
    ]
    
}
