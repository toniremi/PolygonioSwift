//
//  StockFinancialsRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public struct StockFinancialsRequest : ApiRequest {
    typealias Response = StockFinancialsResponse
    
    var symbol:String
    var limit: Int
    var type: FinancialType?
    
    var path: String {
        return "/v2/reference/financials/\(symbol)"
    }
    
    var queryItems: [URLQueryItem] {
        // add here the parameters if we have a value
        var parameters: [URLQueryItem] = []
        
        // always will have limit otherwise the response is huge
        parameters.append(URLQueryItem(name: "limit", value: String(limit)))
        
        // if a type is passed include it in the query
        if type != nil {
            parameters.append(URLQueryItem(name: "type", value: type?.rawValue))
        }
        
        return parameters
    }
}
