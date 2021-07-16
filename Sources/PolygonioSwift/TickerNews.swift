//
//  TickerNews.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct TickerNewsRequest : ApiRequest {
    typealias Response = TickerNewsResponse
    
    let ticker: String? // if we do not get a ticker then we will get news in general
    var limit: Int? //Limit the size of the response, default is 100 and max is 1000.
    var order: Order?
    var publishedLessEqualThan: String? // to filter news published less than or equal to a date
    var publishedGreaterEqualThan: String? // to filter news published greater than or equal to a date
    
    var path: String {
        return "/v2/reference/news"
    }
    
    var queryItems: [URLQueryItem] {
        
        var parameters: [URLQueryItem] = []
        
        // ticker is optional in case we want news in general
        if ticker != nil {
            parameters.append(URLQueryItem(name: "ticker", value: ticker))
        }
        
        // append limit if we have one
        if limit != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "limit", value: String(limit!)))
        }
        
        // append sort if we have one
        if order != nil {
            parameters.append(URLQueryItem(name: "order", value: order?.rawValue))
        }
        
        // append this in order to search by date
        if publishedLessEqualThan != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "published_utc.lte", value: publishedLessEqualThan))
        }
        
        // append this in order to search by date
        if publishedGreaterEqualThan != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "published_utc.gte", value: publishedGreaterEqualThan))
        }
        
        // always sorted by published date
        parameters.append(URLQueryItem(name: "sort", value: "published_utc"))
        
        return parameters
    }
}

public struct TickerNewsResponse : Decodable {
    
    public var request_id: String
    public var count: Int
    public var status: String
    public var results: [Result]
    public var next_url: String?
    
    private enum CodingKeys: String, CodingKey {
        case request_id = "request_id"
        case count = "count"
        case status = "status"
        case results = "results"
        case next_url = "next_url"
    }
    
    public struct Result: Codable {
        public var id: String
        public var publisher: Publisher
        public var title: String
        public var author: String
        public var published_utc: String
        public var article_url: String
        public var tickers: [String]
        // optionals
        public var amp_url: String?
        public var image_url: String?
        public var description: String?
        public var keywords: [String]?
        
        private enum CodingKeys: String, CodingKey {
            case id = "id"
            case publisher = "publisher"
            case title = "title"
            case author = "author"
            case published_utc = "published_utc"
            case article_url = "article_url"
            case tickers = "tickers"
            case amp_url = "amp_url"
            case image_url = "image_url"
            case description = "description"
            case keywords = "keywords"
        }
    }
    
    public struct Publisher : Codable {
        public var name: String
        public var homepage_url: String
        public var logo_url: String
        public var favicon_url: String
        
        private enum CodingKeys: String, CodingKey {
            case name = "name"
            case homepage_url = "homepage_url"
            case logo_url = "logo_url"
            case favicon_url = "favicon_url"
        }
    }
}
