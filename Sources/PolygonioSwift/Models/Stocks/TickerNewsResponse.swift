//
//  TickerNews.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

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
        public var insights: [Insights]?
        
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
            case insights = "insights"
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
    
    public struct Insights : Codable {
        public var sentiment: String
        public var sentiment_reasoning: String
        public var ticker: String
        
        private enum CodingKeys: String, CodingKey {
            case sentiment = "sentiment"
            case sentiment_reasoning = "sentiment_reasoning"
            case ticker = "ticker"
        }
    }
}
