//
//  ShortcutAction.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 17.04.2023.
//

import Foundation
import UIKit

enum ActionType: String {
  case search = "QuickAction.Search"
}

enum Action: Equatable {
  case search

  init?(shortcutItem: UIApplicationShortcutItem) {
    guard let type = ActionType(rawValue: shortcutItem.type) else {
      return nil
    }

    switch type {
    case .search:
      self = .search
    }
  }
}


class ShortcutActionService: ObservableObject {
  static let shared = ShortcutActionService()

    @Published var action: Action? {
        willSet {
            self.objectWillChange.send()
        }
    }
}
