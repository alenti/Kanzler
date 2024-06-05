//
//  OTP.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 29.05.2024.
//
//
//import SwiftUI
//
//struct OTP: View {
//    @State var otpText:String = ""
//    @FocusState private var isKeyboardShowing: Bool
//    
//    var body: some View {
//        VStack {
//            HStack (spacing : 0) {
//                /// Text Boxes
//                ForEach (0..<6, id: \.self) {index in
//                    OTPTextBox(index)
//                }
//            }
//            .background(content: {
//                TextField("", text:  $otpText.limit(6))
//                    .keyboardType(.numberPad)
//                    .textContentType(.oneTimeCode)
//                //Hide it Out
//                    .frame(width: 1,height: 1)
//                    .opacity(0.001)
//                    .blendMode(.screen)
//                    .focused($isKeyboardShowing)
//            })
//            .contentShape(Rectangle())
//            // Opening Keyboard When Tapped
//            .onTapGesture {
//                isKeyboardShowing.toggle()
//            }
//            
//            .padding(.bottom,20)
//            .padding(.top,10)
//            
//            Button {
//                
//            } label: {
//                Text ("Verify")
//                    .fontWeight(.bold)
//                    .foregroundColor(.white)
//                    .padding (.vertical, 12)
//                    .frame (maxWidth: .infinity)
//                    .background{
//                        RoundedRectangle(cornerRadius: 6, style: . continuous)
//                            .fill(.blue)
//                    }
//                
//            }
//            .disableWithOpacity(otpText.count < 6)
//            
//        }
//        .padding(.all)
//        .frame(maxHeight: .infinity,alignment: .top)
//        .toolbar{
//            ToolbarItem(placement: .keyboard) {
//                Button("Done") {
//                    isKeyboardShowing.toggle()
//                }
//                .frame(maxWidth:.infinity , alignment:  .trailing)
//            }
//        }
//    }
//    
//    // Text Box
//    @ViewBuilder
//    func OTPTextBox (_ index: Int) -> some View {
//        ZStack {
//            if otpText.count > index {
//                //Finding Char At Index
//                let startIndex = otpText.startIndex
//                let charIndex = otpText.index (startIndex, offsetBy: index)
//                let charToString = String(otpText[charIndex])
//                Text(charToString)
//            } else {
//              Text (" ")
//            }
//        }
//        .frame (width: 45 , height: 45)
//        .background {
//            //Highlighting Currunt Active Box
//            let status = (isKeyboardShowing && otpText.count == index)
//            RoundedRectangle(cornerRadius: 6 , style: .continuous)
//                .stroke(status ? .black : .gray, lineWidth: status ? 1 : 0.5)
//            //Animation
//                .animation(.easeInOut(duration: 0.2), value: status)
//        }
//        .frame(maxWidth: .infinity)
//    }
//}
//
//extension View {
//    func disableWithOpacity (_ condtion: Bool) -> some View {
//        self
//            .disabled(condtion)
//            .opacity(condtion ? 0.6 : 1)
//    }
//}
//
//extension Binding where Value == String {
//    func limit(_ length: Int)->Self {
//        if self.wrappedValue.count > length {
//            DispatchQueue.main.async {
//                self.wrappedValue = String(self.wrappedValue.prefix(length))
//            }
//        }
//        return self
//    }
//}
//
//#Preview {
//    OTP()
//}
