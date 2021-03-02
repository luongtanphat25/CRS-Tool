//
//  AppDelegate.swift
//  CRS Tool
//
//  Created by Luong Tan Phat on 2021-02-05.
//

import UIKit
import Firebase
import RealmSwift
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var hasLaunched: Bool!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        Thread.sleep(forTimeInterval: 1)
        
        hasLaunched = UserDefaults.standard.bool(forKey: "hasLaunched")
        
        if hasLaunched {
            hasLaunched = true
        } else {
            UserDefaults.standard.set(true, forKey: "hasLaunched")
        }
        
        return true
    }
    
    func setLaunched() {
        hasLaunched = true
    }

    // MARK: - UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        
    }


}

