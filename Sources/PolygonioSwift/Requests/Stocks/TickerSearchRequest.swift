//
//  TickerSearchRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

// This is an adapted request.
// There is no search end point but we can use the tickers endpoint to focus only on search functionality.
// This way we can make a more simplified endpoint only focused on searching a ticker by ticker name or company name.
public struct TickerSearchRequest : ApiRequest {
    typealias Response = TickerSearchResponse
        
    let search: String
    var limit: Int? // how many results per page. Default is 100
    let active: Bool?
    let order: Order?
    let type: TickerTypes?
    
    var path: String {
        return "/v3/reference/tickers"
    }
    
    var queryItems: [URLQueryItem] {
        // add here the parameters if we have a value
        var parameters: [URLQueryItem] = []
        
        // always append the search as there has to be something in this field
        parameters.append(URLQueryItem(name: "search", value: search))
        
        // append order if we have one
        if order != nil {
            parameters.append(URLQueryItem(name: "order", value: order?.rawValue))
        }
        
        // append type if we have one
        if type != nil {
            parameters.append(URLQueryItem(name: "type", value: type?.rawValue))
        }

        // append limit if we have one
        if limit != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "limit", value: String(limit!)))
        }
        
        // append active if we have one
        if active != nil {
            parameters.append(URLQueryItem(name: "active", value: active?.description))
        }
        
        // for now limit the search to stocks only
        parameters.append(URLQueryItem(name: "market", value: "stocks"))
        
        return parameters
    }
}
