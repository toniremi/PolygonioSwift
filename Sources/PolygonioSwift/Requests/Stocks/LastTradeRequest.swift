//
//  LastTradeRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/27.
//

import Foundation

public struct LastTradeRequest: ApiRequest {
    public typealias Response = LastTradeResponse

    // Specify a case-sensitive ticker symbol. For example, AAPL represents Apple Inc.
    let ticker: String

    // The path for the query, incorporating the symbol
    public var path: String {
        return "/v2/last/trade/\(ticker)"
    }

    public var queryItems: [URLQueryItem] {
        return []
    }
}
