//
//  QR-CODE.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 25.01.2024.
//

import SwiftUI

struct QR_CODE: View {
    
    @State private var qrCodeImage: Image?
   // @EnvironmentObject var userSession: UserSession
    
    //let userID: String // ID пользователя из Firebase
    
    var body: some View {
        ZStack {
            Image("QRcodeBackground") // Replace with your image name
                .resizable()
                .ignoresSafeArea()
            VStack(spacing: 0) {
                CustomNavigationBar(title: "QR-code",isCentered: true )
                VStack {
                    
                    RoundedRectangle(cornerRadius: 20)
                        .fill(Color(.systemGray5))
                        .shadow(radius: 5)
                        .frame(width: 310, height: 410)
                        .blur(radius: 0.5)
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    
                        .overlay(
                            VStack {
                                HStack {
                                    VStack(alignment: .center) {
                                        Text("5%")
                                            .font(.custom("Rubik-SemiBold", size: 40))
                                            .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                                        Text("Кэшбэк")
                                    }
                                    Spacer()
                                    VStack(alignment: .center) {
                                        Text("150")
                                            .font(.custom("Rubik-SemiBold", size: 40))
                                            .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                                        Text("Бонусов")
                                            .font(.custom("Rubik", size: 15))
                                        //  .padding(.bottom, -10)
                                    }
                                }
                                .padding(.horizontal,60)
                                //.padding(.top, 10)
                                
                                ZStack {
                                    if let qrCodeImage = qrCodeImage {
                                        //                                    qrCodeImage
                                        //                                        .resizable()
                                        //                                        .scaledToFit()
                                        //                                        .frame(width: 200, height: 200)
                                        //                                        .zIndex(1)
                                    } else {
                                        ProgressView()
                                        //                                    Image("qr-kod") // Фото в качестве фона
                                        //                                        .resizable()
                                        //                                        .scaledToFit()
                                        //                                        .frame(width: 200, height: 200)
                                        //                                        .zIndex(1)
                                    }
                                    RoundedRectangle(cornerRadius: 20) // Создаем RoundedRectangle с закругленными углами
                                        .fill(Color.white) // Заполняем его цветом
                                        .frame(width: 200, height: 200) // Устанавливаем размеры RoundedRectangle
                                }
                                .clipped() // Обр
                                
                                
                                
                                Text("Покажите этот код при оплате\nдля списания или начисления\nбонусов")
                                    .fixedSize(horizontal: false, vertical: true)
                                    .font(.custom("Rubik-Light", size: 15))
                                    .multilineTextAlignment(.center)
                                    .padding(.all,0)
                                
                                Button(action: {
                                    // resendCode()
                                }) {
                                    Text("Правила начисления")
                                        .foregroundColor(Color(red: 1, green: 0.20, blue: 0.20))
                                        .underline(true)
                                }
                                .padding(.vertical,7)
                            }
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
//        .onAppear {
//                    if let userID = userSession.userID {
//                        QRGenerator.shared.loadQRCode(userID: userID) { image in
//                            // Преобразуем UIImage в Image
//                            if let uiImage = image {
//                                self.qrCodeImage = Image(uiImage: uiImage)
//                            }
//                        }
//                    } else {
//                        print("User ID is not available")
//                    }
//                }
    }
}

#Preview {
    QR_CODE()
}
