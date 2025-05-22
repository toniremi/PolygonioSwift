//
//  Markets.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct MarketStatusRequest : ApiRequest {
    typealias Response = MarketStatusResponse
    
    var path: String {
        return "/v1/marketstatus/now"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct MarketStatusResponse : Decodable {
    
    public var market: String
    public var serverTime: String
    public var exchanges: Exchanges
    public var currencies: Currencies
    
    private enum CodingKeys: String, CodingKey {
        case market = "market"
        case serverTime = "serverTime"
        case exchanges = "exchanges"
        case currencies = "currencies"
    }
    
    public struct Exchanges : Codable {
        public var nyse: String
        public var nasdaq: String
        public var otc: String
        
        private enum CodingKeys: String, CodingKey {
            case nyse = "nyse"
            case nasdaq = "nasdaq"
            case otc = "otc"
        }
    }
    
    public struct Currencies : Codable {
        public var fx: String
        public var crypto: String
        
        private enum CodingKeys: String, CodingKey {
            case fx = "fx"
            case crypto = "crypto"
        }
    }
}
