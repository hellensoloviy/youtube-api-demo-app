//
//  Identifiable.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import UIKit

protocol Identifiable {
    var identifier: String { get }
}

extension UITableViewCell: Identifiable {
    var identifier: String { "\(type(of: self))" }
}
