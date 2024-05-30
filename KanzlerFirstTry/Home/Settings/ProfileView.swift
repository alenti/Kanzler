//
//  Profile.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 25.01.2024.
//

import SwiftUI

// Основной View профиля пользователя
struct ProfileView: View {
    // Предполагаемые данные для демонстрации
    let user = User(name: "Василий Петров", phoneNumber: "+996 (555) 77-66-55", bonusPoints: 150, discount: 5)
    let menuItems = [
        MenuItem(icon: "clock.arrow.circlepath", title: "История покупок"),
        MenuItem(icon: "gear", title: "Настройки"),
        MenuItem(icon: "bell", title: "Уведомления"),
        MenuItem(icon: "star", title: "Бонусная программа"),
        MenuItem(icon: "questionmark.circle", title: "Поддержка")
    ]
    
    @StateObject var marketsViewModel = MarketViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                CustomNavigationBar(title: "Профиль",isCentered: false)
                ScrollView {
                    VStack(alignment: .leading,spacing: 0) {
                        ProfileHeaderView(user: user)
                            .padding(.top,10)
                        BonusCashbackView(bonusPoints: user.bonusPoints, discount: user.discount)
                        SettingsMenuView(menuItems: menuItems)
                        StoreScrollView()
                            .environmentObject(marketsViewModel)
                            .padding(.vertical)
                        LogoutButton{}
                            .padding(.bottom,30)
                    }
                }
                .background(Color(.systemGray6))
                
                //.edgesIgnoringSafeArea(.top)
            }
        }
    }
}

// Header View с информацией о пользователе
struct ProfileHeaderView: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(user.name)
                .font(.title2).bold()
            Text(user.phoneNumber)
                .foregroundColor(.secondary)
        }
        .padding([.vertical, .horizontal])
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// View для бонусов и скидок
struct BonusCashbackView: View {
    let bonusPoints: Int
    let discount: Int
    
    var body: some View {
        HStack() {
            VStack {
                Text("\(bonusPoints)")
                    .font(.custom("Rubik-SemiBold", size: 30))
                    .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                Text("бонусов")
                    .font(.subheadline)
            }
            .padding(.horizontal,20)
            
            Rectangle()
                .fill(Color(.systemGray2))
                .frame(width: 2)
                .padding(.vertical,15)
            
            VStack {
                Text("\(discount)%")
                    .font(.custom("Rubik-SemiBold", size: 30))
                    .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                Text("скидка")
                    .font(.subheadline)
            }
            .padding(.horizontal,20)
        }
        
        .frame(maxWidth: .infinity,maxHeight: 65)
        .background(Color.white)
        .cornerRadius(10)
        .padding(.horizontal)
        .padding(.top, 10)
        .padding(.bottom, 15)
    }
}

// View для меню настроек
struct SettingsMenuView: View {
    let menuItems: [MenuItem]
    
    var body: some View {
        VStack(spacing: 0) { // Убрать пространство между элементами
            ForEach(menuItems, id: \.title) { item in
                SettingsRow(item: item)
                // Добавление разделителя между пунктами меню, кроме последнего
                if menuItems.last != item {
                    Divider()
                }
            }
            .background(Color.white) // Фон применяется к каждому элементу отдельно
        }
        .cornerRadius(10)
        .padding(.horizontal)
    }
}

// View для строки настроек
struct SettingsRow: View {
    let item: MenuItem
    
    var body: some View {
        NavigationLink(destination: Text(item.title)) {
            HStack {
                Image(systemName: item.icon)
                    .foregroundColor(.black)
                    .font(Font.system(size: 20,weight: .light))
                    //.font(.system(size: 20))
                    
                Text(item.title)
                    .foregroundColor(.black)
                    .font(.custom("Rubik-Light", size: 16))
                
                Spacer()
                Image(systemName: "chevron.right")
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
}

// Horizontal ScrollView для магазинов
struct StoreScrollView: View {
    @EnvironmentObject var viewModel: MarketViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(viewModel.markets) { markets in
                    MarketInfoView(store: markets)
                    
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

struct LogoutButton: View {
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Image(systemName: "person.slash")
                    .foregroundColor(.black)
                    .font(Font.system(size: 20, weight: .light))
                    
                Text("Выход")
                    .foregroundColor(.black)
                    .font(.custom("Rubik-Light", size: 16))
                
                Spacer()
            }
            .padding()
            .frame(maxWidth: .infinity, alignment: .leading)
            .background(Color.white)
            .cornerRadius(10)
            .padding(.horizontal)
        }
    }
}

// Модели данных
struct User {
    let name: String
    let phoneNumber: String
    let bonusPoints: Int
    let discount: Int
}

struct MenuItem: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let title: String
}

//struct StoreInfo: Identifiable {
//    let id = UUID()
//    let name: String
//    let address: String
//    let phone: String
//    let hours: String
//}

#Preview {
    ProfileView()
}
