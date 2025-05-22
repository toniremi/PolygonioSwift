//
//  DailyOpenCloseRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
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
