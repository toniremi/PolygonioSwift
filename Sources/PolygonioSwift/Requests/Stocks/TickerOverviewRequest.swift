//
//  TickerOverviewRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public struct TickerOverviewRequest : ApiRequest {
    typealias Response = TickerOverviewResponse
    
    let symbol: String

    var path: String {
        return "/v3/reference/tickers/\(symbol)"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
