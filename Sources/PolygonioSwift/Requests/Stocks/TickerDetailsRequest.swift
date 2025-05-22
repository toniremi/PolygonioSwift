//
//  TickerDetailsRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public struct TickerDetailsRequest : ApiRequest {
    typealias Response = TickerDetailsResponse
    
    let symbol: String

    var path: String {
        return "/v1/meta/symbols/\(symbol)/company"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
