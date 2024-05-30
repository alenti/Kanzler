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
