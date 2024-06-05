//
//  CustomAlert.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 02.06.2024.
//

import SwiftUI

struct SystemBarAlert: Equatable {
    var message: String
    var symbol: String
    var color: Color
    var isButton: Bool
}

struct CustomAlert: View {
//    @State private var alert: Alert = Alert (message: "", symbol: "" , color: . blue, isButton: false)
    @State private var alert: SystemBarAlert = SystemBarAlert (message: "Передавать ошибку", symbol: "exclamationmark. triangle.fill", color: .yellow, isButton: false)
    
    @State private var visible: Bool = false
    var body: some View {
        GeometryReader {geo in
            VStack {
                Button("alert"){
                    alert = SystemBarAlert (message: "Передавать ошибку", symbol: "exclamationmark.triangle.fill", color: .yellow, isButton: false)
                }
            }
            .frame(maxWidth: .infinity,maxHeight:.infinity)
            .onChange(of: alert) {
                Task {
                    guard !alert.message.isEmpty else { return }
                    
                    withAnimation(.snappy){
                        visible = true
                    }
                    try await Task.sleep(nanoseconds: 3000000000)
                    
                    withAnimation(.snappy){
                        visible = false
                    }
                    alert = SystemBarAlert(message: "", symbol: "", color: alert.color, isButton: false)
                }
            }
            .overlay(alignment: . top) {
                VStack(spacing: 0) {
                    HStack{
                        Image(systemName: alert.symbol)
                            .foregroundStyle(alert.color)
                            .font(.title)
                        Text(alert.message)
                    }
                    .frame(maxWidth: .infinity, alignment: . leading)
                    .padding()
                    .background {
                        RoundedRectangle(cornerRadius: 8)
                            .strokeBorder(lineWidth: 1)
                            .foregroundStyle(alert.color)
                            .background(alert.color.opacity(0.1), in : .rect(cornerRadius: 8))
                            .background(.background, in: . rect (cornerRadius: 8 ))
                    }
                    .padding(.horizontal)
                }
                .padding(.top,geo.safeAreaInsets.top)
                .opacity(visible ? 1 : 0)
                .offset(y: visible ? 0 : -300)
            }
            .ignoresSafeArea()
        }
    }
}

#Preview {
    CustomAlert()
}
