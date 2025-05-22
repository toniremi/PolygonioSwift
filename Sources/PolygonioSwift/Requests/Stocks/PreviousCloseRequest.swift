//
//  PreviousCloseRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public struct PreviousCloseRequest : ApiRequest {
    typealias Response = PreviousCloseResponse
    
    let symbol: String
    let unadjusted: Bool // default is false
    
    var path: String {
        return "/v2/aggs/ticker/\(symbol)/prev"
    }
    
    var queryItems: [URLQueryItem] {
        return [ URLQueryItem(name: "unadjusted", value: unadjusted.description) ]
    }
}
