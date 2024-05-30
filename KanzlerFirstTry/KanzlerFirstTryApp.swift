//
//  KanzlerFirstTryApp.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 17.11.2023.
//

import SwiftUI
import Firebase


class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
      FirebaseApp.configure()

//      application.registerForRemoteNotifications()
      
    return true
  }
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//           // Обработка регистрации удаленных уведомлений
//       }
//
//       func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//           // Обработка ошибки регистрации удаленных уведомлений
//       }

}
    
@main
struct KanzlerFirstTryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userSession = UserSession()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ContentView()
                    .environmentObject(userSession)
                    .preferredColorScheme(.light)
            }
        }
    }
}
