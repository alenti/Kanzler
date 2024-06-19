//
//  MarketViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

class MarketViewModel: ObservableObject {
    @Published var markets: [MarketModel] = [
        MarketModel(name: "Гоголя/Огонбаева", address: "Огонбаева Атая, 222", phone: "+996 777-90-22-33", hours: "09:00 - 18:00", link: "https://go.2gis.com/50kug"),
        MarketModel(name: "Дзержинка/Боконбаева", address: "​Бульвар Эркиндик, 7", phone: "+996 777-90-22-34", hours: "09:00 - 18:00", link: "https://go.2gis.com/z7xld"),
        MarketModel(name: "Киевская/Уметалиева", address: "​Уметалиева, 84", phone: "+996 777-90-22-36", hours: "09:00 - 18:00", link: "https://go.2gis.com/htq5r"),
    ]
}
