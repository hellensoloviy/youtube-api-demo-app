//
//  SearchEndpoint.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import Foundation

enum SearchEndpoint {
    case searchVideo(keyword: String = "")  // per page?
}

extension SearchEndpoint: Endpoint {
    var path: String {
        switch self {
        case .searchVideo:
            return "/search"
        }
    }

    var queryItems: [URLQueryItem]? {
        switch self {
        case .searchVideo(let name):
            return [.init(name: "q", value: name)]

        }
    }
    
    var method: RequestMethod {
        switch self {
        case .searchVideo:
            return .get
        }
    }

    var body: [String: String]? {
        switch self {
        case .searchVideo:
            return nil
        }
    }
}
