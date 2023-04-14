//
//  SearchResultModel.swift
//  Youtube-demo-app
//
//  Created by Hellen Soloviy on 14.04.2023.
//

import Foundation

// TODO: - See correct model to get
// https://developers.google.com/youtube/v3/docs/search/list?apix_params=%7B%22part%22%3A%5B%22Sekiro%22%5D%7D#usage
//
class PageInfoModel: Codable {
    var totalResults: Int
    var resultsPerPage: Int
    
    enum CodingKeys: String, CodingKey {
        case totalResults, resultsPerPage
    }
}

class VideoModel: Codable {
    var dateAdded: String
    var channelId: String
    var title: String
    var description: String
    
    var thumbnails: VideoThumbnailsModel? // medium ?
    
    enum CodingKeys: String, CodingKey {
        case channelId, title, description, thumbnails
        case dateAdded = "publishedAt"
    }
}

class VideoThumbnailsModel: Codable {
    class ThambnailDetailsModel: Codable {
        var url: String
            
        enum CodingKeys: String, CodingKey {
            case url
        }
    }
    
    var medium: ThambnailDetailsModel?
    var high: ThambnailDetailsModel?

        
    enum CodingKeys: String, CodingKey {
        case medium, high
    }
}

class VideoSnippetModel: Codable {
    
    var kind: String
    var snippet: VideoModel?
    
    enum CodingKeys: String, CodingKey {
        case kind
        case snippet
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        snippet = try container.decode(VideoModel.self, forKey: .snippet)
        kind = try container.decode(String.self, forKey: .kind)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(self.snippet, forKey: .snippet)
        try container.encode(self.kind, forKey: .kind)
    }
    
}

class SearchResultModel: Codable {

    var kind: String
    var nextPageToken: String?
    var regionCode: String
    
    var pageInfo: PageInfoModel
    var items: [VideoSnippetModel]?
        
    enum CodingKeys: String, CodingKey {
        case kind
        case nextPageToken
        case regionCode
        case pageInfo
        case items
    }
    
}


/*
 
 Example for https://www.googleapis.com/youtube/v3/search?key=AIzaSyDkV_Cq-ES_E-4bM8RdJ3nqVGUdsaIWHN8&part=snippet&maxResults=2&q=Sekiro
 
 
 {
     "kind": "youtube#searchListResponse",
     "etag": "9qxU38-6YPeIP2VOIuQmToNE5bk",
     "nextPageToken": "CAIQAA",
     "regionCode": "UA",
     "pageInfo": {
         "totalResults": 1000000,
         "resultsPerPage": 2
     },
     "items": [
         {
             "kind": "youtube#searchResult",
             "etag": "cEKk1wiyQOgEQ2o_ZMQM9lPMO_s",
             "id": {
                 "kind": "youtube#playlist",
                 "playlistId": "PLejGw9J2xE9WijzPT7rYLBs5uXkUjTXdW"
             },
             "snippet": {
                 "publishedAt": "2019-03-20T10:07:12Z",
                 "channelId": "UCdKuE7a2QZeHPhDntXVZ91w",
                 "title": "Sekiro: Shadows Die Twice Прохождение",
                 "description": "",
                 "thumbnails": {
                     "default": {
                         "url": "https://i.ytimg.com/vi/CcrqnG_cdiU/default.jpg",
                         "width": 120,
                         "height": 90
                     },
                     "medium": {
                         "url": "https://i.ytimg.com/vi/CcrqnG_cdiU/mqdefault.jpg",
                         "width": 320,
                         "height": 180
                     },
                     "high": {
                         "url": "https://i.ytimg.com/vi/CcrqnG_cdiU/hqdefault.jpg",
                         "width": 480,
                         "height": 360
                     }
                 },
                 "channelTitle": "Kuplinov ► Play",
                 "liveBroadcastContent": "none",
                 "publishTime": "2019-03-20T10:07:12Z"
             }
         },
         {
             "kind": "youtube#searchResult",
             "etag": "fRQM56XBzboc5u21iA0OCm7CBCk",
             "id": {
                 "kind": "youtube#video",
                 "videoId": "4iu3STaybQY"
             },
             "snippet": {
                 "publishedAt": "2019-03-25T12:31:25Z",
                 "channelId": "UCq7JZ8ATgQWeu6sDM1czjhg",
                 "title": "Обзор игры Sekiro: Shadows Die Twice",
                 "description": "https://twice.rocketbank.ru/ — закажи бесплатную карту и выиграй коллекционку Sekiro: Shadows Die Twice! • Комментарии и ...",
                 "thumbnails": {
                     "default": {
                         "url": "https://i.ytimg.com/vi/4iu3STaybQY/default.jpg",
                         "width": 120,
                         "height": 90
                     },
                     "medium": {
                         "url": "https://i.ytimg.com/vi/4iu3STaybQY/mqdefault.jpg",
                         "width": 320,
                         "height": 180
                     },
                     "high": {
                         "url": "https://i.ytimg.com/vi/4iu3STaybQY/hqdefault.jpg",
                         "width": 480,
                         "height": 360
                     }
                 },
                 "channelTitle": "StopGame",
                 "liveBroadcastContent": "none",
                 "publishTime": "2019-03-25T12:31:25Z"
             }
         }
     ]
 }
 
 */
