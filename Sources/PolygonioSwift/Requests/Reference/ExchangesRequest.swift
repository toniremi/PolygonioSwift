//
//  ExchangesRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import Foundation

public struct ExchangesRequest : ApiRequest {
    typealias Response = ExchangesResponse
    
    let asset_class: AssetClass?
    let locale: Locale?
    
    var path: String {
        return "/v3/reference/exchanges"
    }
    
    var queryItems: [URLQueryItem] {
        var parameters: [URLQueryItem] = []
        
        // Filter for conditions within a given asset class.
        if asset_class != nil {
            parameters.append(URLQueryItem(name: "asset_class", value: asset_class?.rawValue))
        }
        
        // Filter by data type.
        if locale != nil {
            parameters.append(URLQueryItem(name: "locale", value: locale?.rawValue))
        }
        
        return parameters
    }
}
