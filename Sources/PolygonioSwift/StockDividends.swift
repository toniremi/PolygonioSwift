//
//  StockDividends.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/14/20.
//

import Foundation

public struct StockDividendsRequest : ApiRequest {
    typealias Response = StockDividendsResponse
    
    var symbol:String
    
    var path: String {
        return "/v2/reference/dividends/\(symbol)"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct StockDividendsResponse : Decodable {
    
    public var status: String
    public var count: Int
    public var results: [DividendsInfo]
   
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case count = "count"
        case results = "results"
    }
    
    public struct DividendsInfo : Codable {
        public var ticker: String
        public var exDate: String
        public var paymentDate: String
        public var recordDate: String
        public var amount: Decimal
        
        private enum CodingKeys: String, CodingKey {
            case ticker = "ticker"
            case exDate = "exDate"
            case paymentDate = "paymentDate"
            case recordDate = "recordDate"
            case amount = "amount"
        }
    }
}
