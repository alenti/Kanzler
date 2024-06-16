//
//  KanzlerFirstTryApp.swift
//  KanzlerFirstTry
//
//  Created by Notnik_kg on 17.11.2023.
//


import SwiftUI
import Firebase
import FirebaseCore
import AppCheckCore
import FirebaseAppCheck
import FirebaseAppCheckInterop

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]? = nil) -> Bool {
        
        let providerFactory = AppCheckDebugProviderFactory()
        AppCheck.setAppCheckProviderFactory(providerFactory)
        // вернуть на место нормальную проверку App Check
        //        let providerFactory = YourAppCheckProviderFactory()
        //        AppCheck.setAppCheckProviderFactory(providerFactory)
        
        FirebaseApp.configure()
        print("App Check provider factory set")

        // Запрос разрешения на отправку уведомлений
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in
            print("Permission granted: \(granted)")
        }
        application.registerForRemoteNotifications()
        print("Remote notifications registered")

        return true
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        // Обработка регистрации удаленных уведомлений
        Auth.auth().setAPNSToken(deviceToken, type: .unknown)
        print("Remote notifications token registered")
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        // Обработка ошибки регистрации удаленных уведомлений
        print("Failed to register for remote notifications: \(error.localizedDescription)")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable: Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        // Обработка полученных уведомлений
        if Auth.auth().canHandleNotification(userInfo) {
            completionHandler(.noData)
            return
        }
        // This notification is not handled by Firebase Authentication.
        // Handle the notification yourself, as appropriate.
    }
}

class YourAppCheckProviderFactory: NSObject, AppCheckProviderFactory {
  func createProvider(with app: FirebaseApp) -> AppCheckProvider? {
    if #available(iOS 14.0, *) {
      return AppAttestProvider(app: app)
    } else {
      return DeviceCheckProvider(app: app)
    }
  }
}

@main
struct KanzlerFirstTryApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var userSession = UserSession()
    
    @State private var showSplashScreen = true
    @State private var splashScreenOpacity = 1.0
    
    var body: some Scene {
        WindowGroup {
            ZStack {
                NavigationView {
                    ContentView()
                        .environmentObject(userSession)
                        .preferredColorScheme(.light)
                }
                
                if showSplashScreen {
                    SplashScreenView()
                        .opacity(splashScreenOpacity)
                        .transition(.opacity)
                        .onAppear {
                            // Добавление задержки перед началом анимации
                            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                withAnimation(.easeInOut(duration: 2.0)) {
                                    splashScreenOpacity = 0.0
                                }
                                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                                    showSplashScreen = false
                                }
                            }
                        }
                }
            }
        }
    }
}

