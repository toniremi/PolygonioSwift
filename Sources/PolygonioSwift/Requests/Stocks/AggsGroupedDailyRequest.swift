//
//  AggsGroupedDailyRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/06/04.
//

import Foundation

public struct AggsGroupedDailyRequest : ApiRequest {
    typealias Response = AggsGroupedDailyResponse
    
    // path variables
    let date: String // date format YYYY-MM-DD or Timestamp in milliseconds

    // query item variabels
    let adjusted: Bool // default is true

    
    // the path for the query
    var path : String {
        return "/v2/aggs/grouped/locale/us/market/stocks/\(date)"
    }
    
    // the query parameters
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "adjusted", value: adjusted.description),
        ]
    }
}
