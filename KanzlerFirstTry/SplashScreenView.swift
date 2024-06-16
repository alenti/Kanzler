//
//  SplashScreenView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 14.06.2024.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var scale: CGFloat = 1.0
    @State private var circleScale: CGFloat = 0.0
    @State private var opacity: Double = 1.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color.white // Фон splash screen
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.98, green: 0.95, blue: 0.95))
                            .scaleEffect(circleScale)
                            .opacity(opacity)
                            .frame(width: geometry.size.width, height: geometry.size.height)
                        
                        Image("SplashScreen") // Логотип вашего приложения
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 355, height: 400) // Задание начальных размеров
                            .scaleEffect(scale)
                    }
                    .onAppear {
                        withAnimation(.easeInOut(duration: 1.5)) {
                            self.scale = 1.1
                        }
                        withAnimation(.easeInOut(duration: 2.0)) {
                            self.circleScale = 3.0
                            self.opacity = 0.0
                        }
                    }
                }
                .frame(width: geometry.size.width, height: geometry.size.height)
            }
        }
        .ignoresSafeArea(.all)
    }
}


#Preview {
    SplashScreenView()
}
