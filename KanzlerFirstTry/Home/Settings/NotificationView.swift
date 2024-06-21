//
//  NotificationView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 19.06.2024.
//

import SwiftUI

struct NotificationView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                // Background logo
                VStack {
                    Circle()
                        .fill(Color.red.opacity(0.06))
                        .frame(width: geometry.size.width * 0.9, height: geometry.size.width * 0.9)
                        .overlay(
                            Circle()
                                .fill(Color.red.opacity(0.07))
                                .frame(width: geometry.size.width * 0.63, height: geometry.size.width * 0.63)
                        )
                        .overlay(
                            Image("logoFirstView") // Replace this with your logo
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .scaleEffect(0.9)
                        )
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // Center the background logo

                VStack {
                    HStack {
                        Button(action: {
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            Image(systemName: "arrow.left")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding()
                                .background(Circle().fill(Color.red))
                        }
                        Spacer()
                        Text("Уведомления")
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                        Spacer()
                        // Add an empty view to balance the space
                        Image(systemName: "arrow.left")
                            .font(.title)
                            .foregroundColor(.clear)
                            .padding()
                    }
                    .padding(.horizontal)

                    Spacer()
                }
            }
            .background(Color.white.edgesIgnoringSafeArea(.all))
        }
        .navigationBarBackButtonHidden(true)
    }
}

#Preview {
    NotificationView()
}
