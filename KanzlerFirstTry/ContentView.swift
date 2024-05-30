//
//  ContentView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 17.11.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @State var userphone = ""
    @State var userpassword = ""
//    @State private var selectedNumber: Int? = nil
//    @State private var isAuthenticated = Auth.auth().currentUser != nil

       var body: some View {
           //MainTabView ()
           // Проверка статуса аутентификации
//           if isAuthenticated {
//               // Пользователь аутентифицирован, показываем HomeView
//               HomeView()
//           } else {
               // Пользователь не аутентифицирован, показываем экран входа
           //    SignIn()
           NumberConfirmation()
//           }
       }
}

#Preview {
    ContentView()
}
