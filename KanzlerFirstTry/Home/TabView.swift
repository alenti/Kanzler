//
//  TabView.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 23.01.2024.
//

import SwiftUI

struct MainTabView: View {
    
    init() {
          let appearance = UITabBarAppearance()
          appearance.backgroundColor = UIColor.systemGray5 // Используйте нужный оттенок серого

          // Для непрозрачного фона без эффекта прозрачности
          appearance.backgroundEffect = nil
          
          // Применить внешний вид ко всем состояниям TabBar
          UITabBar.appearance().standardAppearance = appearance
          if #available(iOS 15.0, *) {
              UITabBar.appearance().scrollEdgeAppearance = appearance
          }
      }

    
    enum Tab {
        case home, qrCode, profile
    }
    
    @State private var selectedTab: Tab = .home
    
    
    var body: some View {
        TabView(selection: $selectedTab) {
            HomeView(selectedTab: $selectedTab)
                .transition(.slide)
                .tabItem {
                    Label("Главая", systemImage: "house")
//                    Image(systemName: "house")
//                        .imageScale(.large)
//                    Text("Главная")
//                        .font(.headline)
                }
                .tag(Tab.home)
            QR_CODE()
                .transition(.slide)
                .tabItem {
                    Label ("QR",systemImage: "qrcode.viewfinder")
                        .imageScale(.large)
                }
                .tag(Tab.qrCode)
            
            ProfileView()
                .tabItem {
                    Label ("Профиль", systemImage: "person.crop.square")

                }
                .tag(Tab.profile)
        }
        .animation(.easeInOut, value: selectedTab)
        .accentColor(.red)
        //.onAppear {
        // Пример кастомизации при появлении
        //       UITabBar.appearance().barTintColor = .white // Цвет фона TabBar
        // }
        .background(Color.gray.opacity(0.1))
        // .tabViewStyle(.automatic)
        
        
    }
    
}

//struct TabScreenView: View {
//    // enum для Tab, добавление других вкладок по необходимости
//    enum Tab {
//        case home, goals, settings
//    }
//
//    @State private var selectedTab: Tab = .home
//
//    var body: some View {
//        TabView(selection: $selectedTab) {
//            HomeView()
//                .tabItem {
//                    Label("Home", systemImage: "house")
//                }
//                .tag(Tab.home)
//
//            QR_CODE()
//                .tabItem {
//                    Label("Goals", systemImage: "flag")
//                }
//                .tag(Tab.goals)
//
//            Profile()
//                .tabItem {
//                    Label("Settings", systemImage: "gear")
//                }
//                .tag(Tab.settings)
//        }
//    }
//}

//// Расширение должно быть вне объявления структуры TabScreenView
//extension TabScreenView {
//
//    private func tabSelection() -> Binding<Tab> {
//      Binding { //Это блок get
//       self.selectedTab
//      } set: { tappedTab in
//
//    if tappedTab == self.selectedTab {
//        //Пользователь нажал на значок активной вкладки => Переход к корневому представлению/Прокрутка вверх
//
//          if homeNavigationStack.isEmpty {
//           //Пользователь уже находится на главном представлении, прокрутка вверх
//          } else {
//          //Переход к главному представлению путем очистки стека
//           homeNavigationStack = []
//          }
//       }
//
//       //Установка текущей вкладки на вкладку, выбранную пользователем
//       self.selectedTab = tappedTab
//      }
//     }
//}

#Preview {
    MainTabView()
}
