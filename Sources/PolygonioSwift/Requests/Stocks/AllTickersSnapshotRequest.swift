//
//  AllTickersSnapshot.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/16/20.
//

import Foundation

public struct AllTickersSnapshotRequest : ApiRequest {
    typealias Response = AllTickersSnapshotResponse
    
    var path: String {
        return "/v2/snapshot/locale/us/markets/stocks/tickers"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
