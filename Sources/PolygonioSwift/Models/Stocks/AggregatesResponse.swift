//
//  AggregatesResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//
import Foundation

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
