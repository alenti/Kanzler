//
//  PhoneNumber.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 08.06.2024.
//

import SwiftUI
import iPhoneNumberField

struct PhoneNumber: View {
    @State var text = ""

    var body: some View {
        iPhoneNumberField(text: $text)
            .prefixHidden(false)
            .flagHidden(false)
           // .flagSelectable(true)
            .font(UIFont(size: 30, weight: .bold, design: .rounded))
            .padding()
    }
}

#Preview {
    PhoneNumber()
}
