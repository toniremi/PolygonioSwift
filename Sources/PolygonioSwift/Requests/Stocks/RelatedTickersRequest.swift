//
//  RelatedTickersRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/27.
//

import Foundation

public struct RelatedTickersRequest : ApiRequest {
    typealias Response = RelatedTickersResponse
    
    let ticker: String
    
    var path: String {
        return "/v1/related-companies/\(ticker)"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}
