//
//  ContentView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 17.11.2023.
//

import SwiftUI
import FirebaseAuth
import FirebaseAppCheck

struct ContentView: View {
    @EnvironmentObject var userSession: UserSession

    var body: some View {
        if userSession.userID != nil {
            MainTabView()
                .transition(.slide)
        } else {
            SignIn()
                .transition(.slide)
        }
    }
}

#Preview {
    ContentView()
}
