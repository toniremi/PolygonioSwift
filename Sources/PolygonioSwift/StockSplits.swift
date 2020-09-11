//
//  StockSplits.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct StockSplitsRequest : ApiRequest {
    typealias Response = StockSplitsResponse
    
    var symbol:String
    
    var path: String {
        return "/v2/reference/splits/\(symbol)"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct StockSplitsResponse : Decodable {
    
    public var status: String
    public var count: Int
    public var results: [SplitInfo]
   
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case count = "count"
        case results = "results"
    }
    
    public struct SplitInfo : Codable {
        public var ticker: String?
        public var exDate: String
        public var paymentDate: String
        public var declaredDate: String?
        public var ratio: Decimal
        public var tofactor: Int?
        public var forfactor: Int?
        
        private enum CodingKeys: String, CodingKey {
            case ticker = "ticker"
            case exDate = "exDate"
            case paymentDate = "paymentDate"
            case declaredDate = "declaredDate"
            case ratio = "ratio"
            case tofactor = "tofactor"
            case forfactor = "forfactor"
        }
    }
}
