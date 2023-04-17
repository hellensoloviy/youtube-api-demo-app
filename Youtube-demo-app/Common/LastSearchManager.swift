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
    
    func save(_ keyword: String) {
        UserDefaults.standard.set(keyword, forKey: self.key)
    }
    
    func restore() -> String? {
        UserDefaults.standard.string(forKey: self.key)
    }
}
