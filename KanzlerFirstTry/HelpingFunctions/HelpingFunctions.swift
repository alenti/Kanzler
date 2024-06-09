//
//  HelpingFunctions.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 27.05.2024.
//

import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

struct LoadingView: View {
    var body: some View {
        ZStack {
            Color.black.opacity(0.4)
                .edgesIgnoringSafeArea(.all)
            ProgressView("Загрузка...")
                .progressViewStyle(CircularProgressViewStyle())
                .padding()
                .background(Color.white)
                .cornerRadius(10)
        }
    }
}
