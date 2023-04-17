//
//  AppDelegate.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    private let actionService = ShortcutActionService.shared
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        if let shortcutItem = launchOptions?[UIApplication.LaunchOptionsKey.shortcutItem] as? UIApplicationShortcutItem {
              actionService.action = Action(shortcutItem: shortcutItem)
            // Since, the app launch is triggered by QuicAction, block "performActionForShortcutItem:completionHandler" method from being called.
            return false
        }
        
        return true
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        
        if let shortcutItem = options.shortcutItem {
          actionService.action = Action(shortcutItem: shortcutItem)
        }

        let configuration = UISceneConfiguration(name: connectingSceneSession.configuration.name, sessionRole: connectingSceneSession.role)
        configuration.delegateClass = SceneDelegate.self
        return configuration
        
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

}

