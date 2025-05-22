//
//  TickersQueryResponse.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

public struct TickersQueryResponse : Decodable {
    
    public var request_id: String
    public var count: Int
    public var status: String
    public var results: [Ticker]
    
    private enum CodingKeys: String, CodingKey {
        case request_id = "request_id"
        case count = "count"
        case status = "status"
        case results = "results"
    }
    
    public struct Ticker : Codable {
        public var ticker: String
        public var name: String
        public var market: String
        public var locale: String
        public var primaryExch: String
        public var type: String
        public var currency: String
        public var active: Bool
        
        public var cik: String?
        public var composite_figi: String?
        public var share_class_figi: String?
        public var last_updated_utc: String
        
        private enum CodingKeys: String, CodingKey {
            case ticker = "ticker"
            case name = "name"
            case market = "market"
            case locale = "locale"
            case primaryExch = "primary_exchange"
            case type = "type"
            case active = "active"
            case currency = "currency_name"
            case cik = "cik"
            case composite_figi = "composite_figi"
            case share_class_figi = "share_class_figi"
            case last_updated_utc = "last_updated_utc"
        }
    }
}
