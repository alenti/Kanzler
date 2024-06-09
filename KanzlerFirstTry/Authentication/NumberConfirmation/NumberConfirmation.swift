//
//  NumberConfirmation.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 19.12.2023.
//
import SwiftUI
import Firebase

struct NumberConfirmation: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var otpText = ""
    @FocusState private var isKeyboardShowing: Bool
    @EnvironmentObject var userSession: UserSession
    @StateObject private var errorHandler = ErrorHandler()
    
    @State private var isLoading = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    
                    Spacer()
                }
                .overlay(
                    Text("Введите код")
                        .font(.custom("RubikOne-Regular", size: geometry.size.width * 0.045))
                        .foregroundColor(.black),
                    alignment: .center
                )
                .padding(.vertical, geometry.size.height * 0.03)
                
                Image("logoFirstView")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.width * 0.8, height: geometry.size.height * 0.2)
                
                Text("Введите код из SMS-сообщения")
                    .font(.custom("Rubik-light", size: max(geometry.size.width * 0.02, 19)))
                    .multilineTextAlignment(.center)
                    .padding()
                    .lineLimit(1)
                    .padding(.top,geometry.size.height * 0.02)
                
                OTP(otpText: $otpText)
                    .padding(.bottom, geometry.size.height * 0.03)
                ///.padding(.top, geometry.size.height * 0.01)
                
                Spacer()
                
                Button(action: {
                    UIApplication.shared.hideKeyboard()
                    confirmCode()
                }) {
                    Text("Далее")
                        .font(.custom("Rubik", size: geometry.size.width * 0.045))
                        .foregroundColor(.white)
                        .frame(width: geometry.size.width - 80)
                        .padding()
                        .background(Color(red: 1, green: 0.20, blue: 0.20))
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                        .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                }
                .padding()
                .disableWithOpacity(otpText.count < 6)
                
                Button(action: {
                    resendCode()
                }) {
                    Text("Отправить повторно")
                        .foregroundColor(Color(red: 1, green: 0.20, blue: 0.20))
                }
                .padding()
            }
            .navigationBarBackButtonHidden(true)
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
            .customAlert(alert: $errorHandler.alert)
            
            if isLoading {
                LoadingView()
                    .transition(.opacity)
            }
        }
    }
    
    private func confirmCode() {
        let code = otpText
        withAnimation {
                    isLoading = true
                }
        AuthManager.shared.verifyCode(smsCode: code) { success in
            withAnimation {
                            isLoading = false
                        }
            if success {
                if let tempUserData = AuthManager.shared.tempUserData {
                    withAnimation {
                                            isLoading = true
                                        }
                    AuthManager.shared.registerUser(userData: tempUserData) { registerSuccess in
                        DispatchQueue.main.async {
                            withAnimation {
                                                            isLoading = false
                                                        }
                            if registerSuccess {
                                withAnimation {
                                    userSession.signIn()
                                }
                            } else {
                                errorHandler.handleCustomError("Ошибка при регистрации пользователя")
                            }
                        }
                    }
                    
                }
                else {
                    DispatchQueue.main.async {
                        userSession.signIn()
                    }
                }
            }
            
            else {
                errorHandler.handleCustomError("Неверный код из SMS")
            }
        }
    }
    
    private func resendCode() {
        AuthManager.shared.resendCode { success in
            if !success {
                errorHandler.handleCustomError("Ошибка при повторной отправке кода")
            }
        }
    }
}

struct OTP: View {
    @Binding var otpText: String
    @FocusState private var isKeyboardShowing: Bool
    
    var body: some View {
        VStack {
            HStack (spacing : 0) {
                ForEach (0..<6, id: \.self) { index in
                    OTPTextBox(index)
                }
            }
            .background(content: {
                TextField("", text:  $otpText.limit(6))
                    .keyboardType(.numberPad)
                    .textContentType(.oneTimeCode)
                    .frame(width: 1, height: 1)
                    .opacity(0.001)
                    .blendMode(.screen)
                    .focused($isKeyboardShowing)
            })
            .contentShape(Rectangle())
            .onTapGesture {
                isKeyboardShowing.toggle()
            }
            .padding(.bottom, 20)
            .padding(.top, 10)
            
        }
        .padding(.all)
        .frame(maxHeight: .infinity, alignment: .top)
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Свернуть") {
                    isKeyboardShowing.toggle()
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }

    @ViewBuilder
    func OTPTextBox(_ index: Int) -> some View {
        ZStack {
            if otpText.count > index {
                let startIndex = otpText.startIndex
                let charIndex = otpText.index(startIndex, offsetBy: index)
                let charToString = String(otpText[charIndex])
                Text(charToString)
            } else {
                Text(" ")
            }
        }
        .frame(width: 45, height: 45)
        .background {
            let status = (isKeyboardShowing && otpText.count == index)
            RoundedRectangle(cornerRadius: 6, style: .continuous)
                .stroke(status ? .black : .gray, lineWidth: status ? 1 : 0.5)
                .animation(.easeInOut(duration: 0.2), value: status)
        }
        .frame(maxWidth: .infinity)
    }
}

extension View {
    func disableWithOpacity(_ condition: Bool) -> some View {
        self
            .disabled(condition)
            .opacity(condition ? 0.6 : 1)
    }
}

extension Binding where Value == String {
    func limit(_ length: Int) -> Self {
        if self.wrappedValue.count > length {
            DispatchQueue.main.async {
                self.wrappedValue = String(self.wrappedValue.prefix(length))
            }
        }
        return self
    }
}


#Preview {
    NumberConfirmation()
}
