//
//  BannerView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 26.04.2024.
//

import SwiftUI
import SDWebImageSwiftUI

struct BannerView: View {
    let banner: BannerModel
    var width: CGFloat?
    var height: CGFloat?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            WebImage(url: URL(string: banner.imagePath))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .shadow(color: .red.opacity(0.25), radius: 0, x: 0, y: 0)
                .frame(width: width, height: height)
                .padding(.bottom, 7)
                .padding(.horizontal, 5)

            Text(banner.title)
                .font(.custom("Rubik-LightItalic", size: 16))
                .padding(.horizontal, 7)
        }
    }
}

#Preview {
    HomeView(selectedTab: .constant(.home))
}

