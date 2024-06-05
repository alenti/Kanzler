//
//  UserSession.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 12.04.2024.
//

import Foundation
import SwiftUI
import Firebase

class UserSession: ObservableObject {
    @Published var userID: String?

    init() {
        self.userID = Auth.auth().currentUser?.uid
    }
    
    func signIn() {
        self.userID = Auth.auth().currentUser?.uid
    }
    
    func signOut() {
        do {
            try Auth.auth().signOut()
            self.userID = nil
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}
