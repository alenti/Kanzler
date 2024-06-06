//
//  SignIn.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 25.11.2023.
//

import SwiftUI
import FirebaseAuth

struct SignIn: View {
    @State private var userphone = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var showNumberConfirmation = false
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Image("backgroundFirstView")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .edgesIgnoringSafeArea(.all)
                
                VStack {
                    VStack {
                        HStack {
                            Spacer()
                            Button(action: {
                                // Handle info button action
                            }) {
                                Image(systemName: "info.circle")
                                    .font(.system(size: geometry.size.width * 0.06))
                                    .foregroundColor(.black)
                                    .padding()
                            }
                        }
                        
                        Image("logoFirstView")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.2)
                    }
                    .padding(.bottom, geometry.size.height * 0.1)
                    
                    VStack(alignment: .leading) {
                        VStack {
                            TextField("+996 000 00 00 00", text: $userphone)
                                .padding()
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.red, lineWidth: 3)
                                        .fill(Color(red: 0.98, green: 0.95, blue: 0.95))
                                        .shadow(
                                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                                )
                                .padding(.horizontal, geometry.size.width * 0.07)
                                .multilineTextAlignment(.center)
                                .keyboardType(.phonePad)
                        }
                        .padding(.bottom, geometry.size.height * 0.02)
                    }
                    .padding(.top, geometry.safeAreaInsets.top)
                    
                    
                    VStack {
                        Button(action: {
                            startPhoneNumberVerification()
                        }) {
                            Text("Войти")
                                .font(.custom("RubikOne-Regular", size: geometry.size.width * 0.045))
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width * 0.8)
                                .padding()
                        }
                        .background(Color(red: 1, green: 0.20, blue: 0.20))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                    }
                    
                    Spacer()
                    
                    VStack() {
                        Text("Впервые у нас?")
                            .font(.custom("Rubik-Light", size: geometry.size.width * 0.035))
                            .multilineTextAlignment(.center)
                        
                        NavigationLink(destination:Registration().environmentObject(userSession)) {
                            Text("Зарегистрироваться")
                                .font(.custom("Rubik", size: geometry.size.width * 0.04))
                                .foregroundColor(.black)
                                .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.05)
                                .background(
                                    RoundedRectangle(cornerRadius: 15)
                                        .stroke(Color.red, lineWidth: 1)
                                        .background(Color(red: 0.98, green: 0.95, blue: 0.95))
                                )
                                .padding(.horizontal)
                                .multilineTextAlignment(.center)
                        }
                    }
                    .padding(.top, geometry.safeAreaInsets.top * 3)
                    .padding(.bottom, geometry.size.height * 0.03)
                    
                    Spacer()
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
                
                NavigationLink(destination: NumberConfirmation().environmentObject(userSession), isActive: $showNumberConfirmation) {
                    EmptyView()
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
            .alert(isPresented: $showAlert) {
                Alert(title: Text("Ошибка"), message: Text(alertMessage), dismissButton: .default(Text("Ок")))
            }
        }
    }
    
    private func startPhoneNumberVerification() {
        let phoneNumber = userphone
        AuthManager.shared.startAuth(phoneNumber: phoneNumber) { success in
            if success {
                showNumberConfirmation = true
            } else {
                alertMessage = "Ошибка при отправке SMS"
                showAlert = true
            }
        }
    }
}

#Preview {
    SignIn()
}
