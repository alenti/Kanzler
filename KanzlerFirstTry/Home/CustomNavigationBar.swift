//
//  CustomNavigationBar.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 11.04.2024.
//

import SwiftUI


struct CustomNavigationBar: View {
    var title: String
    var isCentered: Bool

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                Color(.systemGray6) // Светло-серый сплошной фон
                    .edgesIgnoringSafeArea(.top)
                if isCentered {
                    Text(title)
                        .font(.custom("RubikOne-Regular", size: 25))
                        .frame(maxWidth: .infinity , alignment: .center)
                } else {
                    Text(title)
                        .font(.custom("RubikOne-Regular", size: 20))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.horizontal,25)
                }
            }
            .frame(height: 40)

            // Кастомный Divider
            Rectangle()
                .fill(Color(.systemGray2))
                .frame(height: 2)
                .edgesIgnoringSafeArea(.horizontal)
        }
        .frame(alignment: .top)
    }
}

#Preview {
    CustomNavigationBar(title: "QR код",isCentered: false)
}
