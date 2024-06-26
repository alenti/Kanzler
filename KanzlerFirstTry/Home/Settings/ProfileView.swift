//
//  Profile.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 25.01.2024.
//
import SwiftUI
import FirebaseAuth

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewModel()
    @StateObject var marketsViewModel = MarketViewModel()
    @EnvironmentObject var userSession: UserSession
    @State private var showLogoutAlert = false

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                VStack(spacing: 0) {
                    CustomNavigationBar(title: "Профиль", isCentered: false)
                    ScrollView {
                        VStack(alignment: .leading, spacing: 0) {
                            if let user = viewModel.user {
                                // Профиль пользователя
                                VStack(alignment: .leading, spacing: 0) {
                                    ProfileHeaderView(user: user)
                                        .padding(.top, 10)
                                    BonusCashbackView(bonusPoints: user.bonusPoints, discount: user.discount)
                                    SettingsMenuView(menuItems: menuItems)
                                    StoreScrollView()
                                        .environmentObject(marketsViewModel)
                                        .padding(.vertical)
                                    LogoutButton {
                                        showLogoutAlert = true
                                    }
                                    .padding(.bottom, 30)
                                }
                            } else if let errorMessage = viewModel.errorMessage {
                                // Отображение сообщения об ошибке
                                Text(errorMessage)
                                    .foregroundColor(.red)
                            } else {
                                // Пустое представление, если данные еще не загружены
                                VStack(alignment: .leading, spacing: 0) {
                                    ProfileHeaderView(user: UserData.placeholder)
                                        .padding(.top, 10)
                                    BonusCashbackView(bonusPoints: 0, discount: 0)
                                    SettingsMenuView(menuItems: menuItems)
                                    StoreScrollView()
                                        .environmentObject(marketsViewModel)
                                        .padding(.vertical)
                                    LogoutButton {
                                        showLogoutAlert = true
                                    }
                                    .padding(.bottom, 30)
                                }
                                .redacted(reason: .placeholder)
                            }
                        }
                    }
                    .background(Color(.systemGray6))
                }
            }
        }
        .alert(isPresented: $showLogoutAlert) {
            Alert(
                title: Text("Вы действительно хотите выйти?"),
                primaryButton: .destructive(Text("Выйти")) {
                    userSession.signOut()
                },
                secondaryButton: .cancel(Text("Остаться"))
            )
        }
        .onAppear {
            if let uid = userSession.userID {
                viewModel.fetchUserData(uid: uid)
            }
        }
    }

    private var menuItems: [MenuItem] {
        [
            MenuItem(icon: "clock.arrow.circlepath", title: "История покупок"),
            MenuItem(icon: "gear", title: "Настройки", action: {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }),
            MenuItem(icon: "bell", title: "Уведомления", destination: AnyView(NotificationView())),
            MenuItem(icon: "star", title: "Бонусная программа"),
            MenuItem(icon: "questionmark.circle", title: "Поддержка")
        ]
    }
}

// Header View с информацией о пользователе
struct ProfileHeaderView: View {
    let user: UserData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("\(user.name) \(user.surname)")
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
        HStack {
            VStack {
                Text("\(bonusPoints)")
                    .font(.custom("Rubik-SemiBold", size: 30))
                    .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                Text("бонусов")
                    .font(.subheadline)
            }
            .padding(.horizontal, 20)
            
            Rectangle()
                .fill(Color(.systemGray2))
                .frame(width: 2)
                .padding(.vertical, 15)
            
            VStack {
                Text("\(discount)%")
                    .font(.custom("Rubik-SemiBold", size: 30))
                    .foregroundColor(Color(red: 1, green: 0.2, blue: 0.2))
                Text("скидка")
                    .font(.subheadline)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: .infinity, maxHeight: 65)
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
        if let destination = item.destination {
            NavigationLink(destination: destination) {
                HStack {
                    Image(systemName: item.icon)
                        .foregroundColor(.black)
                        .font(Font.system(size: 20, weight: .light))
                    Text(item.title)
                        .foregroundColor(.black)
                        .font(.custom("Rubik-Light", size: 16))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }
        } else if let action = item.action {
            Button(action: action) {
                HStack {
                    Image(systemName: item.icon)
                        .foregroundColor(.black)
                        .font(Font.system(size: 20, weight: .light))
                    Text(item.title)
                        .foregroundColor(.black)
                        .font(.custom("Rubik-Light", size: 16))
                    Spacer()
                    Image(systemName: "chevron.right")
                        .foregroundColor(.gray)
                }
                .padding()
            }
        } else {
            HStack {
                Image(systemName: item.icon)
                    .foregroundColor(.black)
                    .font(Font.system(size: 20, weight: .light))
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
                    MarketInfoView(store: markets, width: 240, height: 115, useAdaptiveWidth: false)
                }
            }
            .padding(.horizontal)
            .padding(.leading, 6)
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

struct MenuItem: Identifiable, Hashable {
    let id = UUID()
    let icon: String
    let title: String
    var action: (() -> Void)? = nil
    var destination: AnyView? = nil
    
    static func == (lhs: MenuItem, rhs: MenuItem) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}


#Preview {
    ProfileView()
}
