//
//  MarketHolidaysRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/24.
//

import Foundation

public struct MarketHolidaysRequest : ApiRequest {
    typealias Response = MarketHolidaysResponse
    
    var path: String {
        return "/v1/marketstatus/upcoming"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
