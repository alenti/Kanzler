//
//  ContentView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 17.11.2023.
//

import SwiftUI
import FirebaseAuth

struct ContentView: View {
    @EnvironmentObject var userSession: UserSession
    @StateObject var userViewModel = UserViewModel()

    var body: some View {
        if userSession.userID != nil {
            MainTabView()
                .environmentObject(userViewModel)
                .transition(.slide)
                .onAppear {
                    if let uid = userSession.userID {
                        userViewModel.fetchUserData(uid: uid)
                    }
                }
        } else {
            SignIn()
                .transition(.slide)
        }
    }
}

#Preview {
    ContentView()
}
