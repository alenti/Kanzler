//
//  HomeView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 24.12.2023.
//

import SwiftUI

struct HomeView: View {
    
    @Binding var selectedTab: MainTabView.Tab
    
    @StateObject var storyData = StoryViewModel()
    
    @StateObject var bannersViewModel = BannersViewModel()
    
    @StateObject var marketsViewModel = MarketViewModel()
    
        
    @State private var isShowingInterestingList = false
    @State private var isShowingPromotionsList = false
    
    
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack(spacing: 0) {
                    CustomNavigationBar(title: "Привет,Роман",isCentered: false)
                    ScrollView() {
                        StoriesView(storyData: storyData)
                        
                        BonusCardView(selectedTab: $selectedTab)
                            .padding(.horizontal)
                            .padding(.bottom,17)
                        
                        
                        BlockHeader(HeaderName: "Интересное", onAllTapped: {
                            isShowingInterestingList = true
                        })
                        .sheet(isPresented: $isShowingInterestingList) {
                            BannersListView(viewModel: bannersViewModel, headerName: "Интересное")
                        }
                                   
            
                        InterestingSectionView()
                            .environmentObject(bannersViewModel)
                        
                            .padding(.bottom,20)
                        
                        BlockHeader(HeaderName: "Акции",onAllTapped: {
                            isShowingPromotionsList = true
                        })
                        .sheet(isPresented: $isShowingPromotionsList) {
                            BannersListView(viewModel: bannersViewModel, headerName: "Акции")
                        }
                        
                        
                        PromotionsSectionView()
                            .environmentObject(bannersViewModel)
                        
                            .padding(.bottom,20)
                        
                        BlockHeader(HeaderName: "Адреса магазинов",onAllTapped: {})
                        
                        StoreScrollView()
                            .environmentObject(marketsViewModel)
                        
                        
                            .padding(.bottom,10)
                        
                        SocialButtonsView()
                            .padding(.bottom,100)
                    }
                    .background(Color(.systemGray6))
//                    .background(
//                        ZStack {
//                           Color(.systemGray6)
//                            
//                            Image("Polygon 1")
//                                .offset(x:160,y:-320)
//                                .blur(radius: 1)
//                            
//                            Image("Ellipse 4")
//                                .offset(x:-110,y:-120)
//                                .blur(radius: 2)
//                            
//
//                            Image("Ellipse 4")
//                                .offset(x:200,y:200)
//                                .blur(radius: 2)
//
//                        }
//                        .frame(maxWidth: .infinity, maxHeight: .infinity)
//                    )
//                    .edgesIgnoringSafeArea(.all)
                    
                    
                }
                
                
            }
            .fullScreenCover(isPresented: $storyData.showStory) {
                StoryOverlayView()
                    .environmentObject(storyData)
            }
//            .overlay (
//                StoryView()
//                    .environmentObject(storyData)
//            )
        }
    }
}


    
    // Заголовок блоков
    struct BlockHeader: View {
        var HeaderName: String
        var onAllTapped: () -> Void  // Замыкание для обработки нажатия
        
        var body: some View {
            HStack {
                Text(HeaderName)
                    .font(.custom("Rubik-SemiBold", size: 20))
                Spacer()
                
                HStack {
                    Text("Все")
                        .font(.custom("RubikOne-Regular", size: 16))
                    
                    Image(systemName: "chevron.right")
                        .foregroundColor(.black)
                        .font(Font.system(size: 16, weight: .light))
                }
                .onTapGesture {
                    onAllTapped()  // Вызов замыкания при нажатии
                }
            }
            .padding(.horizontal)
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
            // For now, this is just a placeholder view
            ZStack {
                ScrollView(.horizontal,showsIndicators: false) {
                    
                    HStack (spacing: 12) {
                        ForEach($storyData.stories){$bundle in
                            ProfileStories(bundle: $bundle)
                                .environmentObject(storyData)
                            
                        }
                        
                        
                    }
                    .padding(.all,8)
                }
//                .overlay (
//                    StoryView()
//                        .environmentObject(storyData)
//                )
            }
            
        }
    }
    
    struct ProfileStories: View{
        @Binding var bundle: StoryBundle
        @Environment(\.colorScheme) var scheme
        
        @EnvironmentObject var storyData: StoryViewModel
        
        var body: some View{
            Image (bundle.profileImage)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame (width: 60, height: 60)
                .clipShape(Circle())
            
                .padding(2)
                .background(scheme == .dark ? .black : .white , in:
                                Circle())
                .padding(3)
                .background(
                    LinearGradient(colors: [
                        .red,
                        .orange,
                        .red,
                        .orange
                    ],
                                   startPoint: .top,
                                   endPoint: .bottom)
                    .clipShape(Circle())
                    .opacity(bundle.isSeen ? 0 : 1)
                )
                .onTapGesture {
                    
                    withAnimation{
                        bundle.isSeen = true
                        
                        // Saving current Bundle and toggling story...
                        storyData.currentStory = bundle.id
                        storyData.showStory = true
                    }
                }
        }
    }
    
    
    
    /// QR CODE
struct BonusCardView: View {
    @Binding var selectedTab: MainTabView.Tab
    
    var body: some View {
        GeometryReader { geometry in
            RoundedRectangle(cornerRadius: 15)
                .fill(Color(red: 1, green: 0.2, blue: 0.2))
                .frame(height: geometry.size.width * 0.44) // Пропорциональная высота относительно ширины
                .overlay(
                    VStack {
                        HStack {
                            VStack(alignment: .leading, spacing: 15) {
                                Text("Бонусная \nкарта")
                                    .font(.custom("Rubik-SemiBold", size: 20))
                                    .foregroundColor(.white)
                                
                                HStack(alignment: .bottom) {
                                    Text("150")
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
                                Image("qr-kod") // Фото в качестве фона
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geometry.size.width * 0.33, height: geometry.size.width * 0.33) // Изменяем размер в зависимости от ширины
                                    .zIndex(1)
                                RoundedRectangle(cornerRadius: 10) // Создаем RoundedRectangle с закругленными углами
                                    .fill(Color.white) // Заполняем его цветом
                                    .frame(width: geometry.size.width * 0.35, height: geometry.size.width * 0.35) // Немного больше размер QR кода
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
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.interesting) { interesting in
                        BannerView(banner: interesting,width: 280,height: 130)
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

    struct PromotionsSectionView: View {
        @EnvironmentObject var viewModel: BannersViewModel
        
        var body: some View {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(viewModel.promotions) { promotion in
                        BannerView(banner: promotion,width: 280,height: 130)
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

    
    // Horizontal ScrollView для магазинов
    
    
struct SocialButtonsView: View {
    // URLs for the social media apps
    let instagramURL = URL(string: "https://www.instagram.com/kanzler.kg/")!
    let whatsappURL = URL(string: "https://wa.me/996777902234")!
    
    var body: some View {
        GeometryReader { geometry in
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
            .padding(.horizontal, 10) // Adjust padding for the whole HStack if needed
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
