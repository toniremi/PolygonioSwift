//
//  Aggregates.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

public struct AggregatesRequest : ApiRequest {
    typealias Response = AggregatesResponse
    
    // path variables
    let ticker: String
    let multiplier: Int
    let timespan: TimeSpan
    let from: String // date format YYYY-MM-DD or Timestamp in milliseconds
    let to: String
    
    // query item variabels
    let unadjusted: Bool // default is false
    let sort: Sorting // default is ascending
    
    // the path for the query
    var path : String {
        return "/v2/aggs/ticker/\(ticker)/range/\(multiplier)/\(timespan)/\(from)/\(to)"
    }
    
    // the query parameters
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "unadjusted", value: unadjusted.description),
            URLQueryItem(name: "sort", value: sort.rawValue),
        ]
    }
}

public struct AggregatesResponse : Decodable {
    
    public var ticker: String
    public var status: String
    public var adjusted: Bool
    public var queryCount: Int
    public var resultsCount: Int
    public var results: [Candle]
    public var requestid: String
    public var count: Int

    private enum CodingKeys: String, CodingKey {
        case ticker = "ticker"
        case status = "status"
        case adjusted = "adjusted"
        case queryCount = "queryCount"
        case resultsCount = "resultsCount"
        case results = "results"
        case requestid = "request_id"
        case count = "count"
    }
    
    public struct Candle : Codable {
        public var volume: Int
        public var VWAP: Decimal //VWAP (Volume Weighted Average Price)
        public var open: Decimal
        public var close: Decimal
        public var high: Decimal
        public var low: Decimal
        public var timestamp: Int
        public var n: Int?
        
        private enum CodingKeys: String, CodingKey {
            case volume = "v"
            case VWAP = "vw"
            case open = "o"
            case close = "c"
            case high = "h"
            case low = "l"
            case timestamp = "t"
            case n = "n"
        }
    }
}

