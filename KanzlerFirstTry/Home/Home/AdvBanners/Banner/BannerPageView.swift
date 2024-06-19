//
//  BannerPageView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 19.06.2024.
//

import SwiftUI
import Firebase
import SDWebImageSwiftUI

struct BannerPageView: View {
    @Environment(\.presentationMode) var presentationMode
    let title: String
    let imagePath: String
    let description: String
    let timestamp: Timestamp
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .top) {
                ScrollView {
                    VStack(spacing: 0) {
                        WebImage(url: URL(string: imagePath))
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: geometry.size.width, height: geometry.size.height * 0.4)
                            .ignoresSafeArea(edges: .top)
                        
                        VStack(alignment: .leading) {
                            Text(title)
                                .font(.custom("Rubik-Bold", size: geometry.size.width * 0.075))
                                .foregroundColor(Color.black)
                                .padding(.bottom)
                            
                            Text(description) // использование description
                                .font(.custom("Rubik", size: geometry.size.width * 0.04))
                                .multilineTextAlignment(.leading)
                                .lineLimit(nil)
                            
                            Text(timestamp.dateValue(), style: .date) // использование timestamp
                                .font(.footnote)
                                .foregroundColor(.gray)
                                .padding(.top, 5)
                        }
                        .padding()
                        .cornerRadius(20)
                        .padding()
                    }
                }
                .ignoresSafeArea()
                
                HStack {
                    Button(action: {
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Image(systemName: "arrow.left")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().fill(Color.white.opacity(0.7)))
                    }
                    Spacer()
                    Button(action: {
                        // Action for share button
                    }) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.footnote)
                            .foregroundColor(.black)
                            .padding()
                            .background(Circle().fill(Color.white.opacity(0.7)))
                    }
                }
                .padding(.horizontal)
            }
            .navigationBarHidden(true)
        }
    }
}

//#Preview {
//    BannerPageView()
//}
