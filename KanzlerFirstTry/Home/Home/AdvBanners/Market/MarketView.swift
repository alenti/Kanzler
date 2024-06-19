//
//  MarketView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

struct MarketInfoView: View {
    let store: MarketModel
    var width: CGFloat?
    var height: CGFloat?
    var useAdaptiveWidth: Bool
    
    var body: some View {
        VStack(alignment:.center) {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    Text(store.name)
                        .font(.custom("Rubik", size: (width ?? geometry.size.width) * 0.065)) // Адаптивный размер шрифта
                    Text(store.address)
                        .font(.custom("Rubik-Light", size: (width ?? geometry.size.width) * 0.055)) // Адаптивный размер шрифта
                    Text(store.phone)
                        .font(.custom("Rubik-Light", size: (width ?? geometry.size.width) * 0.055)) // Адаптивный размер шрифта
                        .padding(.bottom, -4)
                    
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(height: 1)
                        .padding(.horizontal, (width ?? geometry.size.width) * 0.18)
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(Color(red: 0.2588, green: 1.0, blue: 0.0))
                            .font(.system(size: (width ?? geometry.size.width) * 0.07)) // Адаптивный размер шрифта
                        Text(store.hours)
                            .font(.custom("Rubik-Light", size: (width ?? geometry.size.width) * 0.06)) // Адаптивный размер шрифта
                            .font(.caption)
                    }
                    .padding(.top, -4)
                    Spacer()
                }
            }
            .frame(width: useAdaptiveWidth ? nil : (width ?? 240), height: height ?? 115) // Установка размеров в зависимости от параметра
            .frame(maxWidth: useAdaptiveWidth ? .infinity : nil) // Используем всю ширину, если нужно
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.2588, green: 1.0, blue: 0.0), lineWidth: 2)
            )
        }
        .onTapGesture {
            if let url = URL(string: store.link) {
                UIApplication.shared.open(url)
            }
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(.home))
}

