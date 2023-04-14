//
//  SearchService.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import Foundation
import Combine

protocol SearchServicable {
    func searchVideo(for keyword: String) -> AnyPublisher<SearchResultModel, RequestError>

}

struct SearchService: NetworkClient, SearchServicable {
    func searchVideo(for keyword: String) -> AnyPublisher<SearchResultModel, RequestError> {
        return sendRequest(endpoint: SearchEndpoint.searchVideo(keyword: keyword), responseModel: SearchResultModel.self)
    }

}
