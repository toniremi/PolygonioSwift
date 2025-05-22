//
//  TickerSnapshotRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public struct TickerSnapshotRequest : ApiRequest {
    typealias Response = TickerSnapshotResponse
    
    var symbol: String
    
    var path: String {
        return "/v2/snapshot/locale/us/markets/stocks/tickers/\(symbol)"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
