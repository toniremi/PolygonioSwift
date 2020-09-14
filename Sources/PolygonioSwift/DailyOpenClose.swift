//
//  Markets.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct DailyOpenCloseRequest : ApiRequest {
    typealias Response = DailyOpenCloseResponse
    
    var symbol: String
    var date: String
    
    var path: String {
        return "/v1/open-close/\(symbol)/\(date)"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct DailyOpenCloseResponse : Decodable {
    
    public var status: String
    public var from: String
    public var symbol: String
    public var open: Decimal
    public var high: Decimal
    public var low: Decimal
    public var close: Decimal
    public var volume: Int
    public var afterHours: Decimal
    public var preMarket: Decimal
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case from = "from"
        case symbol = "symbol"
        case open = "open"
        case high = "high"
        case low = "low"
        case close = "close"
        case volume = "volume"
        case afterHours = "afterHours"
        case preMarket = "preMarket"
    }
}
