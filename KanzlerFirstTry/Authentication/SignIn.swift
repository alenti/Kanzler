//
//  SignIn.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 25.11.2023.
//

import SwiftUI

struct SignIn: View {
    
    @State var userphone = ""
    @State var userpassword = ""
    
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
                    //.padding(.top, geometry.size.height * 0.02)
                    .padding(.bottom, geometry.size.height * 0.06)
                    
                    VStack(alignment: .leading) {
                        VStack {
                            TextField("Введите номер", text: $userphone)
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
                                .keyboardType(.numberPad)
                        }
                        .padding(.bottom, geometry.size.height * 0.01)
                        
                        SecureField("Пароль", text: $userpassword)
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
                    }
                    //.padding(.top, geometry.size.height * 0.08)
                    .padding(.top, geometry.safeAreaInsets.top)
                    
                    Text("Пароль должен содержать \nминимум 6 символов")
                        .multilineTextAlignment(.center)
                        .font(.custom("Rubik-Light", size: geometry.size.width * 0.035))
                        .fixedSize(horizontal: false, vertical: true)
                    
                    VStack {
                        Button(action: {
                            ///Добавить вход в приложение ,если пользователь ввел верные данные
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
                        //.padding(.top, geometry.size.height * 0.01)
                        
                        Button(action: {
                            //Добавить действие при нажатии на «Не помню пароль»
                        }) {
                            Text("Не помню пароль")
                                .font(.custom("Rubik", size: geometry.size.width * 0.045))
                                .underline()
                                .multilineTextAlignment(.center)
                                .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                        }
                    }
                    
                    VStack() {
                        Text("Впервые у нас?")
                            .font(.custom("Rubik-Light", size: geometry.size.width * 0.035))
                            .multilineTextAlignment(.center)
                        
                        NavigationLink(destination: Registration()) {
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
                    //.padding(.top, geometry.size.height * 0.05)
                    .padding(.top, geometry.safeAreaInsets.top * 1.7)
                    .padding(.bottom, geometry.size.height * 0.03)
                    
                    Spacer()
                }
                .contentShape(Rectangle()) // Добавляем это для работы onTapGesture по всей области VStack
                .onTapGesture {
                    UIApplication.shared.hideKeyboard()
                }
            }
            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
        }
    }
}

#Preview {
    SignIn()
}
