//
//  Endpoint.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import Foundation

enum RequestMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"
}

protocol Endpoint {
    var scheme: String { get }
    var host: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var header: [String: String]? { get }
    var body: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var defaultQueryItem: URLQueryItem { get }
}

extension Endpoint {
    var scheme: String {
        return "https"
    }
    
    var host: String {
        return "www.googleapis.com"
    }
    
    var header: [String: String]? {
        return [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "User-Agent": "Youtube-demo-app-ios"
        ]
    }
    
    var defaultQueryItem: URLQueryItem {
        return URLQueryItem(name: "key", value: "AIzaSyDkV_Cq-ES_E-4bM8RdJ3nqVGUdsaIWHN8")
    }
}
