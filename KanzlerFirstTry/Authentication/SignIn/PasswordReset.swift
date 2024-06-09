//
//  PasswordResetView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 05.06.2024.
//

//import SwiftUI

//struct PasswordResetView: View {
//    @Environment(\.presentationMode) var presentationMode
//    @State var userphone = ""
//    @State var userpassword = ""
//    @State private var showNumberConfirmation = false
//    @EnvironmentObject var userSession: UserSession
//    
//    var body: some View {
//        
//        GeometryReader { geometry in
//            ZStack {
//                Image("highlighters")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .rotationEffect(.degrees(-180))
//                    .scaleEffect(1.3)
//                    .frame(maxHeight: .infinity)
//                    .edgesIgnoringSafeArea(.all)
//                    .offset(x:geometry.size.width * -0.29,y:geometry.size.height * -0.01)
//                    .shadow(color: Color(.systemGray), radius: 20, x: 13, y: 6 )
//                
//                Image("liquid_glue")
//                    .resizable()
//                    .aspectRatio(contentMode: .fit)
//                    .rotationEffect(.degrees(-260))
//                    .scaleEffect(1.1)
//                    .frame(maxHeight: .infinity)
//                    .edgesIgnoringSafeArea(.all)
//                    .offset(x:geometry.size.width * 0.3,y:geometry.size.height * 0.425)
//                    .shadow(color: .black, radius: 20, x: 13, y: 6 )
//                
//                VStack {
//                    VStack {
//                        HStack {
//                            Button(action: {
//                                presentationMode.wrappedValue.dismiss()
//                            }) {
//                                Image(systemName: "arrow.backward")
//                                    .fontWeight(.semibold)
//                                    .foregroundColor(.black)
//                            }
//                            .padding(.leading)
//
//                            Spacer()
//                        }
//                        .overlay(
//                            Text("Восстановление пароля")
//                                .font(.custom("RubikOne-Regular", size: geometry.size.width * 0.045))
//                                .foregroundColor(.black),
//                            alignment: .center
//                        )
//                        .padding(.vertical, geometry.size.height * 0.03)
//                        
//                        Image("logoFirstView")
//                            .resizable()
//                            .aspectRatio(contentMode: .fit)
//                            .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.2)
//                    }
//                    .padding(.bottom, geometry.size.height * 0.06)
//                    
//                    VStack(alignment: .leading) {
//                        VStack {
//                            TextField("Введите номер", text: $userphone)
//                                .padding()
//                                .background(
//                                    RoundedRectangle(cornerRadius: 15)
//                                        .stroke(Color.red, lineWidth: 3)
//                                        .fill(Color(red: 0.98, green: 0.95, blue: 0.95))
//                                        .shadow(
//                                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
//                                )
//                                .padding(.horizontal, geometry.size.width * 0.07)
//                                .multilineTextAlignment(.center)
//                               // .keyboardType(.numberPad)
//                        }
//                        .padding(.bottom, geometry.size.height * 0.01)
//                        
//                        SecureField("Новый пароль", text: $userpassword)
//                            .padding()
//                            .background(
//                                RoundedRectangle(cornerRadius: 15)
//                                    .stroke(Color.red, lineWidth: 3)
//                                    .fill(Color(red: 0.98, green: 0.95, blue: 0.95))
//                                    .shadow(
//                                        color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
//                            )
//                            .padding(.horizontal, geometry.size.width * 0.07)
//                            .multilineTextAlignment(.center)
//                    }
//                    .padding(.top, geometry.safeAreaInsets.top)
//                    
//                    Text("Пароль должен содержать \nминимум 6 символов")
//                        .multilineTextAlignment(.center)
//                        .font(.custom("Rubik-Light", size: geometry.size.width * 0.035))
//                        .fixedSize(horizontal: false, vertical: true)
//                    
//                    VStack {
//                                            Button(action: {
//                                                startPasswordReset()
//                                            }) {
//                                                Text("Далее")
//                                                    .font(.custom("RubikOne-Regular", size: geometry.size.width * 0.045))
//                                                    .foregroundColor(.white)
//                                                    .frame(width: geometry.size.width * 0.8)
//                                                    .padding()
//                                            }
//                                            .background(Color(red: 1, green: 0.20, blue: 0.20))
//                                            .clipShape(RoundedRectangle(cornerRadius: 15))
//                                            .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
//                                            
//                                            NavigationLink(destination: NumberConfirmation().environmentObject(userSession), isActive: $showNumberConfirmation) {
//                                                EmptyView()
//                                            }
//                        
//                    }
//                    
//                    Spacer()
//                }
//                .contentShape(Rectangle())
//                .onTapGesture {
//                    UIApplication.shared.hideKeyboard()
//                }
//            }
//            .background(Color(red: 0.98, green: 0.98, blue: 0.98))
//        }
//    }
//    
//    private func startPasswordReset() {
//            AuthManager.shared.prepareUserRegistration(phoneNumber: userphone, name: "", surname: "", birthDate: "", gender: "")
//            AuthManager.shared.startAuth(phoneNumber: userphone) { success in
//                DispatchQueue.main.async {
//                    if success {
//                        self.showNumberConfirmation = true
//                    } else {
//                        // Обработка ошибки
//                    }
//                }
//            }
//        }
//    
//}

//#Preview {
//    PasswordResetView()
//}
