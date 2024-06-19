//
//  MarketListView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 18.06.2024.
//

import SwiftUI

struct MarketListView: View {
    @ObservedObject var viewModel: MarketViewModel
    var headerName: String
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(title: headerName, isCentered: true)
                .padding(.top, 10)
            
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(viewModel.markets) { market in
                        MarketInfoView(store: market,width: 350, height: 150,useAdaptiveWidth: true)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .onTapGesture {
                                if let url = URL(string: market.link) {
                                    UIApplication.shared.open(url)
                                }
                            }
                    }
                }
                .padding(.top)
                .padding(.horizontal)
            }
            .scrollTargetLayout()
        }
        .background(Color(.systemGray6))
        .navigationBarHidden(true) // Скрываем навигационную панель, если она не нужна
    }
}
