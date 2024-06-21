//
//  QR-CODE.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 25.01.2024.
//

import SwiftUI

struct QR_CODE: View {
    @EnvironmentObject var userViewModel: UserViewModel

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("QRcodeBackground")
                    .resizable()
                    .ignoresSafeArea()
                    .frame(width: geometry.size.width, height: geometry.size.height)
                
                VStack(spacing: 0) {
                    CustomNavigationBar(title: "QR-code", isCentered: true)
                    
                    VStack {
                        RoundedRectangle(cornerRadius: 20)
                            .fill(Color(.systemGray5))
                            .shadow(radius: 5)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.65)
                            .blur(radius: 0.5)
                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                            .overlay(
                                VStack {
                                    HStack {
                                        VStack(alignment: .center) {
                                            Text("\(userViewModel.user?.discount ?? 0)%")
                                                .font(.custom("Rubik-SemiBold", size: geometry.size.width * 0.085))
                                                .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                                            Text("Кэшбэк")
                                        }
                                        Spacer()
                                        VStack(alignment: .center) {
                                            Text("\(userViewModel.user?.bonusPoints ?? 0)")
                                                .font(.custom("Rubik-SemiBold", size: geometry.size.width * 0.085))
                                                .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                                            Text("Бонусов")
                                                .font(.custom("Rubik", size: geometry.size.width * 0.04))
                                        }
                                    }
                                    .padding(.horizontal, geometry.size.width * 0.15)
                                    
                                    ZStack {
                                        if let qrCodeImage = userViewModel.qrCodeImage {
                                            Image(uiImage: qrCodeImage)
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: geometry.size.width * 0.55, height: geometry.size.width * 0.55)
                                                .zIndex(1)
                                        } else {
                                            ProgressView()
                                        }
                                        RoundedRectangle(cornerRadius: 15)
                                            .fill(Color.white)
                                            .frame(width: geometry.size.width * 0.65, height: geometry.size.width * 0.65)
                                    }
                                    
                                    Text("Покажите этот код при оплате\nдля списания или начисления\nбонусов")
                                        .fixedSize(horizontal: false, vertical: true)
                                        .font(.custom("Rubik-Light", size: geometry.size.width * 0.035))
                                        .multilineTextAlignment(.center)
                                        .padding(.all, 0)
                                    
                                    Button(action: {
                                        // resendCode()
                                    }) {
                                        Text("Правила начисления")
                                            .foregroundColor(Color(red: 1, green: 0.20, blue: 0.20))
                                            .underline(true)
                                    }
                                    .padding(.vertical, 7)
                                }
                            )
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
        }
    }
}

#Preview {
    QR_CODE()
}
