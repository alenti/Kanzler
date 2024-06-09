//
//  Registration.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 25.11.2023.
//

import SwiftUI

struct Registration: View {
    @Environment(\.presentationMode) var presentationMode
    @StateObject var viewModel = RegistrationViewModel()
    @EnvironmentObject var userSession: UserSession
    @FocusState private var isKeyboardShowing: Bool
    
    
    
    let dayNumbers = (1...31).map { String($0) }
    let yearNumbers = (1923...2023).reversed().map { String($0) }
    let monthsNumber = [
        "Январь", "Февраль", "Март", "Апрель", "Май", "Июнь",
        "Июль", "Август", "Сентябрь", "Октябрь", "Ноябрь", "Декабрь"
    ]
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ScrollView {
                    VStack {
                        CustomTextField(placeholder: "", text: $viewModel.phoneNumber, isPhone: true)
                            .padding(.top, geometry.safeAreaInsets.top * 0.2)
                            .focused($isKeyboardShowing)
                        CustomTextField(placeholder: "Имя*", text: $viewModel.userName)
                            .focused($isKeyboardShowing)
                        CustomTextField(placeholder: "Фамилия*", text: $viewModel.userSurname)
                            .focused($isKeyboardShowing)
                        
                        HStack {
                            Text("День рождения")
                                .font(.custom("Rubik-light", size: geometry.size.width * 0.045))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.horizontal, geometry.size.width * 0.06)
                        
                        HStack {
                            DropDown(hint: "День", options: dayNumbers, anchor: .bottom, selection: $viewModel.selection)
                                
                            DropDown(hint: "Месяц", options: monthsNumber, anchor: .bottom, selection: $viewModel.selection1)
                                
                            DropDown(hint: "Год", options: yearNumbers, anchor: .bottom, selection: $viewModel.selection2)
                                
                        }
                        .padding(.horizontal, geometry.size.width * 0.06)
                        .padding(.bottom, geometry.size.height * 0.01)
                        .zIndex(10.0)
                        
                        HStack {
                            Text("Твой пол")
                                .font(.custom("Rubik-light", size: geometry.size.width * 0.045))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        .padding(.top, geometry.size.width * 0.09)
                        .padding(.horizontal, geometry.size.width * 0.06)
                        
                        HStack(alignment: .center) {
                            RadioButton(label: "Мужской", isChosen: viewModel.selectedGender == .male, imageName: "Man")
                                .onTapGesture {
                                    viewModel.selectedGender = .male
                                    UIApplication.shared.hideKeyboard()
                                }
                                .frame(maxWidth: .infinity)
                            
                            RadioButton(label: "Женский", isChosen: viewModel.selectedGender == .female, imageName: "Woman")
                                .onTapGesture {
                                    viewModel.selectedGender = .female
                                    UIApplication.shared.hideKeyboard()
                                }
                                .frame(maxWidth: .infinity)
                        }
                        .padding(.horizontal, geometry.size.width * 0.06)
                        .padding(.bottom, geometry.size.width * 0.01)
                        .frame(maxWidth: .infinity, alignment: .center)
                        
                        VStack(spacing: geometry.size.width * 0.09) {
                            Checkbox(isChecked: $viewModel.isAgreeWithTerms, label: "Соглашаюсь с правилами программы лояльности*")
                            Checkbox(isChecked: $viewModel.isConsentToDataProcessing, label: "Даю согласие на обработку персональных данных*")
                            Checkbox(isChecked: $viewModel.wantsSMSNotifications, label: "Я хочу получать SMS-рассылку")
                        }
                        .padding(.vertical, geometry.size.width * 0.05)
                        .padding(.horizontal, geometry.size.width * 0.03)
                        .padding(.bottom, 17)
                        
                        Button(action: {
                            viewModel.registerUser()
                        }) {
                            Text("Далее")
                                .foregroundColor(.white)
                                .frame(width: geometry.size.width - 80)
                                .padding()
                                .background(Color(red: 1, green: 0.20, blue: 0.20))
                                .clipShape(RoundedRectangle(cornerRadius: 15))
                                .shadow(color: .black.opacity(0.25), radius: 2, x: 0, y: 4)
                                .padding(.top, 10)
                        }
                        
                        NavigationLink(destination:NumberConfirmation().environmentObject(userSession), isActive: $viewModel.showNumberConfirmation) {
                            EmptyView()
                        }
                        .padding(.bottom, 25)
                    }
                    .padding(.top, geometry.safeAreaInsets.top * 2.2)
                }
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.backward")
                            .fontWeight(.semibold)
                            .foregroundColor(.black)
                    }
                    .padding(.leading)
                    .padding(.top, geometry.safeAreaInsets.top * 1.4)
                    
                    
                    
                    Spacer()
                }
                .overlay(
                    Text("Регистрация")
                        .font(.custom("RubikOne-Regular", size: geometry.size.width * 0.045))
                        .foregroundColor(.black),
                    alignment: .bottom
                    //.padding(.vertical, geometry.size.height * 0.03)
                )
                //.padding(.vertical, geometry.size.height * 0.03)
            }
            .ignoresSafeArea()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationBarBackButtonHidden(true)
            .contentShape(Rectangle())
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
            .customAlert(alert: $viewModel.errorHandler.alert)
        }
        .toolbar {
            ToolbarItem(placement: .keyboard) {
                Button("Свернуть") {
                    isKeyboardShowing = false
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}

#Preview {
    Registration()
}
