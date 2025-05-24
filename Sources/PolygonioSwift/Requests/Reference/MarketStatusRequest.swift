//
//  MarketStatusRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/24.
//
import Foundation

public struct MarketStatusRequest : ApiRequest {
    typealias Response = MarketStatusResponse
    
    var path: String {
        return "/v1/marketstatus/now"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
