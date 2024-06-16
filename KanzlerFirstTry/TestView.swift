//
//  TestView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 09.06.2024.
//

import SwiftUI
import iPhoneNumberField

struct iPhoneNumberFieldWrapper: View {
   // @Binding var text: String
    @State private var scrollOffset: CGFloat = 0.0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack {
                    Image("Background2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .edgesIgnoringSafeArea(.all)
                        .scaleEffect(1.1)
                        .offset(x:geometry.size.width * 0.00, y:geometry.size.height * 0.01 + (scrollOffset * 0.1))
                    
                    //                        Image("Ellipse4")
                    //                            .scaleEffect(0.9)
                    //                            .offset(x: geometry.size.width * -0.37, y: geometry.size.height * 0.06 + (scrollOffset * 0.1))
                    //                            .blur(radius: 1.9)
                }
            }
        }
    }
}
            
            //        VStack {
            //            iPhoneNumberField("+996", text: $text)
            //                .defaultRegion("KG")
            //                .multilineTextAlignment(.leading)
            //                .font(UIFont(size: 21, weight: .medium))
            //                .prefixHidden(false)
            //                .flagHidden(false)
            //                .foregroundColor(Color.black)
            //                .padding()
            //                .background(
            //                    RoundedRectangle(cornerRadius: 15)
            //                        .stroke(Color.red, lineWidth: 3)
            //                        .fill(Color(red: 0.98, green: 0.95, blue: 0.95))
            //                        .shadow(
            //                            color: Color(red: 0, green: 0, blue: 0, opacity: 0.25), radius: 4, y: 4)
            //                )
            //                .padding(.horizontal)
            //                .keyboardType(.phonePad)
            //        }
            //    }

//      .offset((scrollOffset * 0.1))
//                        Image("Ellipse4")
//                            .scaleEffect(0.9)
//                            .offset(x: geometry.size.width * -0.37, y: geometry.size.height * 0.06 + (scrollOffset * 0.1))
//                            .blur(radius: 1.9)
//
//                        Image("Ellipse4")
//                            .scaleEffect(1)
//                            .offset(x: geometry.size.width * 0.37, y: geometry.size.height * 0.06 + (scrollOffset * 0.1))
//                            .blur(radius: 1.9)
//
//                        Image("Ellipse4")
//                            .scaleEffect(1.2)
//                            .offset(x: geometry.size.width * -0.35, y: geometry.size.height * 0.12 + (scrollOffset * 0.15))
//                            .blur(radius: 2)
//
//                        Image("Ellipse4")
//                            .scaleEffect(1.5)
//                            .offset(x: geometry.size.width * 0.37, y: geometry.size.height * 0.20 + (scrollOffset * 0.2))
//                            .blur(radius: 2.3)

#Preview {
    iPhoneNumberFieldWrapper()
}
