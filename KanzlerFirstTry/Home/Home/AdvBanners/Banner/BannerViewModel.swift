//
//  BannerViewModel.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

class BannersViewModel: ObservableObject {
    @Published var promotions: [BannerModel] = [
        BannerModel(image: "Banner6", title: "Подарки от Attache"),
        BannerModel(image: "Banner7", title: "Подарки от Attache"),
    ]
    @Published var interesting: [BannerModel] = [
        BannerModel(image: "Banner7", title: "Подарки от Erich Krause"),
        BannerModel(image: "Banner6", title: "Подарки от Erich Krause"),
    ]
    
}
