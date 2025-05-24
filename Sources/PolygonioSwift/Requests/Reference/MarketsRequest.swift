//
//  MarketsRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/24.
//

import Foundation

public struct MarketsRequest : ApiRequest {
    typealias Response = MarketsResponse
    
    var path: String {
        return "/v2/reference/markets"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
