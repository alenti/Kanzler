//
//  MarketView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI

struct MarketInfoView: View {
    let store: MarketModel
    
    var body: some View {
        VStack(alignment:.center) {
            GeometryReader { geometry in
                VStack {
                    Spacer()
                    
                    Text(store.name)
                        .font(.custom("Rubik", size: max(geometry.size.width * 0.04, 16))) // Адаптивный размер шрифта
                    Text(store.address)
                        .font(.custom("Rubik-Light", size: max(geometry.size.width * 0.02, 13))) // Адаптивный размер шрифта
                    Text(store.phone)
                        .font(.custom("Rubik-Light", size: max(geometry.size.width * 0.02, 13))) // Адаптивный размер шрифта
                        .padding(.bottom, -4)
                    
                    Rectangle()
                        .fill(Color(.systemGray2))
                        .frame(height: 1)
                        .padding(.horizontal, geometry.size.width * 0.20)
                    
                    HStack {
                        Image(systemName: "clock")
                            .foregroundColor(Color(red: 0.2588, green: 1.0, blue: 0.0))
                            .font(.system(size: max(geometry.size.width * 0.04, 18))) // Адаптивный размер шрифта
                        Text(store.hours)
                            .font(.custom("Rubik-Light", size: max(geometry.size.width * 0.04, 15))) // Адаптивный размер шрифта
                            .font(.caption)
                    }
                    .padding(.top,-4)
                    Spacer()
                }
            }
            .frame(width: 240, height: 115) // Фиксированный размер блока
            .background(Color.white)
            .cornerRadius(10)
            .overlay(
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(red: 0.2588, green: 1.0, blue: 0.0), lineWidth: 2)
            )
        }
        //.padding()
    }
}

#Preview {
    HomeView(selectedTab: .constant(.home))
}

