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
    @Binding var alert: SystemBarAlert?
    @State private var visible: Bool = false

    var body: some View {
        GeometryReader { geo in
            VStack {
                // Placeholder for testing button
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .onChange(of: alert) { _ in
                if alert != nil {
                    Task {
                        guard let alert = alert, !alert.message.isEmpty else { return }

                        withAnimation(.snappy) {
                            visible = true
                        }
                        try await Task.sleep(nanoseconds: 6_000_000_000)

                        withAnimation(.snappy) {
                            visible = false
                        }
                        try await Task.sleep(nanoseconds: 999_000_000)
                        self.alert = nil
                    }
                }
            }
            .overlay(alignment: .top) {
                if let alert = alert, visible {
                    VStack(spacing: 0) {
                        HStack {
                            Image(systemName: alert.symbol)
                                .foregroundStyle(alert.color)
                                .font(.title)
                            Text(alert.message)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding()
                        .background {
                            RoundedRectangle(cornerRadius: 8)
                                .strokeBorder(lineWidth: 1)
                                .foregroundStyle(alert.color)
                                .background(alert.color.opacity(0.1), in: RoundedRectangle(cornerRadius: 8))
                                .background(RoundedRectangle(cornerRadius: 8).fill(Color.white))
                        }
                        .padding(.horizontal)
                    }
                    .padding(.top, geo.safeAreaInsets.top)
//                    .opacity(visible ? 1 : 0)
//                    .offset(y: visible ? 0 : -300)
                    .transition(.move(edge: .top))
                }
            }
            .ignoresSafeArea()
        }
    }
}

extension View {
    func customAlert(alert: Binding<SystemBarAlert?>) -> some View {
        self.overlay(
            CustomAlert(alert: alert)
        )
    }
}

//#Preview {
//    CustomAlert()
//}
