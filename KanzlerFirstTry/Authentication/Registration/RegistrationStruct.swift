//
//  RegistrationFunctions.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 27.05.2024.
//

import SwiftUI

struct RadioButton: View {
    var label: String
    var isChosen: Bool
    var imageName: String
    
    var body: some View {
        GeometryReader { geometry in
            HStack(alignment: .center) {
                Image(systemName: isChosen ? "largecircle.fill.circle" : "circle")
                    .fontWeight(.bold)
                    .foregroundColor(isChosen ? .red : .gray)
                    .font(.system(size: geometry.size.height * 2)) // Адаптивный размер иконки
                Spacer()
                
                Text(label)
                    .font(.custom("Rubik", size: geometry.size.height * 1.6)) // Адаптивный размер шрифта
                    .lineLimit(1)
                    .foregroundColor(.black)
                
                Spacer()
                
                Image(imageName)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: geometry.size.height * 3, height: geometry.size.height * 3) // Адаптивный размер изображения
            }
            .padding(.all, geometry.size.width * 0.03)
            .background(RoundedRectangle(cornerRadius: 10).stroke(Color.red, lineWidth: 1))
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .frame(maxWidth: .infinity) // Занимаем всю доступную ширину
    }
}

struct Checkbox: View {
    @Binding var isChecked: Bool
    var label: String
    
    var body: some View {
        GeometryReader { geometry in
            Button(action: {
                self.isChecked.toggle()
            }) {
                HStack(alignment: .center, spacing: geometry.size.width * 0.01) {
                    Image(systemName: isChecked ? "checkmark.square" : "square")
                        .foregroundColor(isChecked ? .red : .gray)
                        .font(.system(size: geometry.size.width * 0.08)) // Адаптивный размер иконки
                    
                    Text(label)
                        //.fixedSize(horizontal: false, vertical: true)
                        .multilineTextAlignment(.leading)
                       .fixedSize(horizontal: false, vertical: true)
                        .lineLimit(2)
                        .foregroundColor(.black)
                        .font(.custom("Rubik-Light", size: geometry.size.width * 0.035)) // Адаптивный размер шрифта
                    
                    Spacer()
                }
                .padding(geometry.size.width * 0.035)
            }
        }
    }
}

struct CustomTextField: View {
    var placeholder: String
    @Binding var text: String
    var isSecure: Bool = false
    var isNumberOnly: Bool = false

    var body: some View {
        ZStack(alignment: .leading) {
            if text.isEmpty {
                Text(placeholder)
                    .font(.custom("Rubik-light", size: 19))
                    .foregroundColor(.gray)
                    .padding(.horizontal, 25)
            }
            if isSecure {
                SecureField("", text: $text)
                    .font(.custom("Rubik-light", size: 19))
                    .foregroundColor(.black)
                    .padding(.horizontal, 25)
                    .cornerRadius(5)
            } else {
                TextField("", text: $text)
                    .font(.custom("Rubik-light", size: 19))
                    .foregroundColor(.black)
                    .padding(.horizontal, 25)
                    .cornerRadius(5)
                    .keyboardType(isNumberOnly ? .phonePad : .default)
//                    .onChange(of: text) { newValue in
//                        if isNumberOnly {
//                            let filtered = newValue.filter { "0123456789+".contains($0) }
//                            if filtered != newValue {
//                                text = filtered
//                            }
//                        }
//                    }
            }
        }
        .padding(.bottom, 38)
        .background(
            Rectangle()
                .frame(height: 1)
                .foregroundColor(.gray)
                .padding(.horizontal, 25)
        )
    }
}

#Preview {
    Registration()
}


#Preview {
    Registration()
}
