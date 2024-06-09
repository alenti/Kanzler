//
//  TestView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 09.06.2024.
//

import SwiftUI
import iPhoneNumberField

struct iPhoneNumberFieldWrapper: View {
    @Binding var text: String

    var body: some View {
        VStack {
            iPhoneNumberField("+996", text: $text)
                .defaultRegion("KG")
                .multilineTextAlignment(.leading)
                .font(UIFont(size: 21, weight: .medium))
                .prefixHidden(false)
                .flagHidden(false)
                .foregroundColor(Color.black)
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 15)
                        .stroke(Color.red, lineWidth: 3)
                        .fill(Color(red: 0.98, green: 0.95, blue: 0.95))
                        .shadow(
                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
                )
                .padding(.horizontal)
                .keyboardType(.phonePad)
        }
    }
}
