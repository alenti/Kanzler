//
//  BannersListView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

struct BannersListView: View {
    @ObservedObject var viewModel: BannersViewModel
    var headerName: String
    
    private var banners: [BannerModel] {
        switch headerName {
        case "Акции":
            return viewModel.promotions
        case "Интересное":
            return viewModel.interesting
        default:
            return []
        }
    }
    
    var body: some View {
        VStack(spacing:0) {
                CustomNavigationBar(title: headerName, isCentered: true)
                .padding(.top,10)
                
                ScrollView(.vertical, showsIndicators: false) {
                    VStack(spacing: 15) {
                        ForEach(banners) { promotion in
                            BannerView(banner: promotion)
                                .frame(maxHeight: .infinity)
                                .onTapGesture {
                                    // Обработка нажатия на баннер
                                }
                                .frame(maxWidth:.infinity)
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
#Preview {
    HomeView(selectedTab: .constant(.home))
}
