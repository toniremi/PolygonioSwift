//
//  StockDividendsRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
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
