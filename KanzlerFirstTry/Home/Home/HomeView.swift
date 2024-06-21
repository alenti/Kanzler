//
//  HomeView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 24.12.2023.
//

import SwiftUI
import FirebaseStorage
import FirebaseFirestore
import SDWebImageSwiftUI

struct HomeView: View {
    @Binding var selectedTab: MainTabView.Tab
    
    @StateObject var storyData = StoryViewModel()
    @StateObject var bannersViewModel = BannersViewModel()
    @StateObject var marketsViewModel = MarketViewModel()
    @StateObject var userViewModel = UserViewModel()
    @EnvironmentObject var userSession: UserSession
    
    @State private var isShowingInterestingList = false
    @State private var isShowingPromotionsList = false
    @State private var isShowingMarketList = false
    @State private var scrollOffset: CGFloat = 0.0
    
    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                ZStack {
                    VStack {
                        Image("Background2")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .edgesIgnoringSafeArea(.all)
                    }
                    
                    VStack(spacing: 0) {
                        CustomNavigationBar(title: "Привет, \(userViewModel.user?.name ?? "")!", isCentered: false)
                        ScrollView {
                            GeometryReader { scrollGeometry in
                                Color.clear
                                    .preference(key: ScrollOffsetPreferenceKey.self, value: scrollGeometry.frame(in: .global).minY)
                            }
                            .frame(height: 0)
                        
                            StoriesView(storyData: storyData)
                                .frame(height: geometry.size.height * 0.12)
                        
                            BonusCardView(selectedTab: $selectedTab)
                                .environmentObject(userViewModel)
                            
                                .padding(.horizontal, geometry.size.width * 0.04)
                                .padding(.bottom, geometry.size.height * 0.05)
                        
                            BlockHeader(headerName: "Интересное", onAllTapped: {
                                isShowingInterestingList = true
                            })
                            .sheet(isPresented: $isShowingInterestingList) {
                                BannersListView(viewModel: bannersViewModel, headerName: "Интересное")
                                    .environmentObject(bannersViewModel)
                            }
                            .padding(.horizontal, geometry.size.width * 0.01)
                            .padding(.bottom, geometry.size.height * 0.018)
                            
                            InterestingSectionView()
                                .environmentObject(bannersViewModel)
                                .padding(.bottom, geometry.size.height * 0.02)
                        
                            BlockHeader(headerName: "Акции", onAllTapped: {
                                isShowingPromotionsList = true
                            })
                            .sheet(isPresented: $isShowingPromotionsList) {
                                BannersListView(viewModel: bannersViewModel, headerName: "Акции")
                                    .environmentObject(bannersViewModel)
                            }
                            .padding(.horizontal, geometry.size.width * 0.01)
                            .padding(.bottom, geometry.size.height * 0.018)
                        
                            PromotionsSectionView()
                                .environmentObject(bannersViewModel)
                                .padding(.bottom, geometry.size.height * 0.03)
                        
                            BlockHeader(headerName: "Адреса магазинов", onAllTapped: {
                                isShowingMarketList = true
                            })
                            .sheet(isPresented: $isShowingMarketList) {
                                MarketListView(viewModel: marketsViewModel, headerName: "Адреса магазинов")
                                    .environmentObject(marketsViewModel)
                            }
                            .padding(.horizontal, geometry.size.width * 0.01)
                            .padding(.bottom, geometry.size.height * 0.018)
                        
                            StoreScrollView()
                                .environmentObject(marketsViewModel)
                                .padding(.bottom, geometry.size.height * 0.01)
                        
                            SocialButtonsView()
                                .padding(.bottom, geometry.size.height * 0.1)
                                .padding(.horizontal, geometry.size.width * 0.02)
                        }
                        .onPreferenceChange(ScrollOffsetPreferenceKey.self) { value in
                            self.scrollOffset = value
                        }
                    }
                }
                .fullScreenCover(isPresented: $storyData.showStory) {
                    StoryOverlayView()
                        .environmentObject(storyData)
                }
            }
            .background(Color(.systemGray6))
        }
        .onAppear {
            if let uid = userSession.userID {
                userViewModel.fetchUserData(uid: uid)
                bannersViewModel.fetchBannersIfNeeded()
                storyData.fetchStoriesIfNeeded()
            }
        }
    }
}

struct ScrollOffsetPreferenceKey: PreferenceKey {
    typealias Value = CGFloat
    static var defaultValue: Value = 0
    static func reduce(value: inout Value, nextValue: () -> Value) {
        value += nextValue()
    }
}

    
    // Заголовок блоков
struct BlockHeader: View {
    var headerName: String
    var onAllTapped: () -> Void  // Замыкание для обработки нажатия
    
    var body: some View {
        GeometryReader { geometry in
            HStack {
                Text(headerName)
                    .font(.custom("Rubik", size: geometry.size.width * 0.045)) // Пример адаптивного размера шрифта
                Spacer()
                
                HStack {
                    Text("Все")
                        .font(.custom("Rubik-Light", size: geometry.size.width * 0.04)) // Пример адаптивного размера шрифта
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .font(Font.system(size: geometry.size.width * 0.04, weight: .light)) // Пример адаптивного размера иконки
                }
                .onTapGesture {
                    onAllTapped()  // Вызов замыкания при нажатии
                }
            }
            .padding(.horizontal, geometry.size.width * 0.05) // Пример адаптивного отступа
        }
    }
}
    
    
// оверлей на сторис
struct StoryOverlayView: View {
    @EnvironmentObject var storyData: StoryViewModel
    
    var body: some View {
        StoryView()
            .ignoresSafeArea()
            .background(Color.black)
            .environmentObject(storyData)
            .ignoresSafeArea()
    }
}
    // Сторис
struct StoriesView: View {
    @ObservedObject var storyData: StoryViewModel
    
    var body: some View {
        ZStack {
            if storyData.isLoading {
                ProgressView()
            } else {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        ForEach($storyData.stories) { $bundle in
                            ProfileStories(bundle: $bundle)
                                .environmentObject(storyData)
                        }
                    }
                    .padding(.horizontal, 15)
                    .padding(.top, 8)
                    .padding(.bottom, 10)
                }
            }
        }
        .onAppear {
            print("StoriesView appeared with stories: \(storyData.stories)")
        }
    }
}
    
struct ProfileStories: View {
    @Binding var bundle: StoryBundle
    @Environment(\.colorScheme) var scheme
    @EnvironmentObject var storyData: StoryViewModel
    
    var body: some View {
        if let url = URL(string: bundle.profileImage) {
            WebImage(url: url)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 60, height: 60)
                .clipShape(Circle())
                .padding(2)
                .background(scheme == .dark ? Color.black : Color.white, in: Circle())
                .padding(3)
                .background(
                    LinearGradient(colors: [.red, .orange, .red, .orange], startPoint: .top, endPoint: .bottom)
                        .clipShape(Circle())
                        .opacity(bundle.isSeen ? 0 : 1)
                )
                .onTapGesture {
                    withAnimation {
                        bundle.isSeen = true
                        storyData.currentStory = bundle.id
                        storyData.showStory = true
                    }
                }
        } else {
            Text("Image not available")
        }
    }
}
    
    
    
    /// QR CODE
struct BonusCardView: View {
    @Binding var selectedTab: MainTabView.Tab
    @EnvironmentObject var userViewModel: UserViewModel
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 1, green: 0.2, blue: 0.2))
                .frame(height: geometry.size.width * 0.47) // Пропорциональная высота относительно ширины
                .overlay(
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Бонусная \nкарта")
                                    .font(.custom("Rubik-SemiBold", size: 20))
                                    .foregroundColor(.white)
                                
                                HStack(alignment: .bottom) {
                                    Text("\(userViewModel.user?.bonusPoints ?? 0)")
                                        .foregroundColor(.white)
                                        .font(.custom("Rubik-SemiBold", size: 40))
                                    
                                    Text("бонусов")
                                        .foregroundColor(.white)
                                        .font(.custom("Rubik-SemiBold", size: 16))
                                        .padding(.bottom, 8)
                                }
                            }
                            .padding(.vertical, 20)
                            
                            Spacer()
                            
                            ZStack {
                                if let qrCodeImage = userViewModel.qrCodeImage {
                                    Image(uiImage: qrCodeImage)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: geometry.size.width * 0.31, height: geometry.size.width * 0.31)
                                        .zIndex(1)
                                } else {
                                    ProgressView()
                                }
                                RoundedRectangle(cornerRadius: 15)
                                    .fill(Color.white)
                                    .frame(width: geometry.size.width * 0.38, height: geometry.size.width * 0.38)
                            }
                        }
                        .padding(.horizontal)
                    }
                )
                .onTapGesture {
                    selectedTab = .qrCode
                }
        }
        .frame(height: 160) // Можно задать фиксированную высоту, если нужно ограничить рост элемента
    }
}


struct InterestingSectionView: View {
    @EnvironmentObject var viewModel: BannersViewModel
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(height: 166)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.interesting) { interesting in
                        BannerView(banner: interesting, width: 280, height: 166)
                            .onTapGesture {
                                // Обработка нажатия на баннер
                            }
                    }
                }
                .padding(.horizontal)
            }
            .scrollTargetLayout()
        }
    }
}

struct PromotionsSectionView: View {
    @EnvironmentObject var viewModel: BannersViewModel
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .frame(height: 166)
        } else {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(viewModel.promotions) { promotion in
                        BannerView(banner: promotion, width: 280, height: 166)
                            .onTapGesture {
                                // Обработка нажатия на баннер
                            }
                    }
                }
                .padding(.horizontal)
            }
            .scrollTargetLayout()
        }
    }
}
    
    // Horizontal ScrollView для магазинов
    
    
struct SocialButtonsView: View {
    // URLs for the social media apps
    let instagramURL = URL(string: "https://www.instagram.com/kanzler.kg/")!
    let whatsappURL = URL(string: "https://wa.me/996777902234")!
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                HStack(spacing: geometry.size.width * 0.03) { // Dynamic spacing based on the width of the view
                    // Instagram Button
                    Button(action: {
                        openURL(instagramURL)
                    }) {
                        socialButtonContent(iconName: "instagram", text: "Instagram")
                    }
                    .frame(width: geometry.size.width * 0.45, height: 55) // Dynamic width
                    .background(Color.white)
                    .cornerRadius(10)
                    
                    // WhatsApp Button
                    Button(action: {
                        openURL(whatsappURL)
                    }) {
                        socialButtonContent(iconName: "whatsapp", text: "Whatsapp")
                    }
                    .frame(width: geometry.size.width * 0.45, height: 55) // Dynamic width
                    .background(Color.white)
                    .cornerRadius(10)
                }
                .frame(maxWidth: .infinity) // Center the HStack
            }
        }
    }
    
    @ViewBuilder
    private func socialButtonContent(iconName: String, text: String) -> some View {
        HStack {
            Image(iconName) // Your custom icon
                .resizable()
                .scaledToFit()
                .frame(width: 33, height: 33) // Icon size, adjust as needed
            Text(text)
                .font(.custom("Rubik-SemiBold", size: 16))
                .foregroundColor(.black)
        }
    }
    
    // Function for opening URLs
    func openURL(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

#Preview {
    HomeView(selectedTab: .constant(.home))
}
