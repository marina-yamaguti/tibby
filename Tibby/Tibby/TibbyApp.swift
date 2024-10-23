//
//  TibbyApp.swift
//  Tibby
//
//  Created by Mateus Moura Godinho on 26/06/24.
//

import SwiftUI
import SwiftData
import UIKit
import GoogleMobileAds

//App Delegate
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        return true
    }
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        let sceneConfig: UISceneConfiguration = UISceneConfiguration(name: nil, sessionRole: connectingSceneSession.role)
        sceneConfig.delegateClass = SceneDelegate.self
        return sceneConfig
    }
}

//Scene Delegate
class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    @EnvironmentObject var constants: Constants
    
    var window: UIWindow?
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let _ = (scene as? UIWindowScene) else { return }
    }
    
    func sceneDidBecomeActive(_ scene: UIScene) {
        UserDefaults.standard.setValue(true, forKey: "enteredApp")
    }
    
    func sceneDidEnterBackground(_ scene: UIScene) {
        UserDefaults.standard.setValue(Date(), forKey: "exitDate")
    }
}

@main
struct TibbyApp: App {
    
    // To handle app delegate callbacks in an app that uses the SwiftUI lifecycle,
    // you must create an application delegate and attach it to your `App` struct
    // using `UIApplicationDelegateAdaptor`.
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    init() {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
    }
    
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Tibby.self, Accessory.self, User.self, Activity.self, Interaction.self, Food.self, Mission.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    
    var body: some Scene {
        WindowGroup {
            SplashScreen()
            //ImageView(urlString: "https://tibbyappstorage.blob.core.windows.net/tibby-sprites/tibbyPinkDolphinEating2.png")
        }
        .modelContainer(sharedModelContainer)
        .environmentObject(Service(modelContext: sharedModelContainer.mainContext))
        .environmentObject(Constants())
        .environmentObject(HealthManager())
        .environmentObject(DateManager())
    }
}
