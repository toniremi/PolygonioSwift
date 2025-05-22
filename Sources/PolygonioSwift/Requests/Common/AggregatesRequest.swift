//
//  Aggregates.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

public struct AggregatesRequest : ApiRequest {
    typealias Response = AggregatesResponse
    
    // path variables
    let ticker: String
    let multiplier: Int
    let timespan: TimeSpan
    let from: String // date format YYYY-MM-DD or Timestamp in milliseconds
    let to: String
    
    // query item variabels
    let unadjusted: Bool // default is false
    let sort: Sorting // default is ascending
    
    // the path for the query
    var path : String {
        return "/v2/aggs/ticker/\(ticker)/range/\(multiplier)/\(timespan)/\(from)/\(to)"
    }
    
    // the query parameters
    var queryItems: [URLQueryItem] {
        return [
            URLQueryItem(name: "unadjusted", value: unadjusted.description),
            URLQueryItem(name: "sort", value: sort.rawValue),
        ]
    }
}
