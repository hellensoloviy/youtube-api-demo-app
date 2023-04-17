//
//  LastSearchManager.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 17.04.2023.
//

import Foundation

protocol LastSearchManagerRespondable {
    func restoreSearch()
    func saveSearch(_ keyword: String)
}

struct LastSearchManager {
    private let key = "you-tube-custom-app.demo-lastSerchedItemKey"
    private let notificationName = Notification.Name("you-tube-custom-app.demo-lastSerched-Notification")
    
    func save(_ keyword: String) {
        UserDefaults.standard.set(keyword, forKey: self.key)
    }
    
    func restore() -> String? {
        UserDefaults.standard.string(forKey: self.key)
    }
    
    func getNotificationName() -> Notification.Name {
        return self.notificationName
    }
    
    func sendNotification() {
        NotificationCenter.default.post(Notification(name: self.notificationName))
    }
    
}
