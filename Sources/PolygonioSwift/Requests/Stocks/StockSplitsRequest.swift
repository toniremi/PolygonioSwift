//
//  StockSplitsRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
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
