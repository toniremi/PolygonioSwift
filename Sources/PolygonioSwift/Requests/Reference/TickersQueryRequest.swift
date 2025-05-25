//
//  TickersQueryRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public struct TickersQueryRequest : ApiRequest {
    typealias Response = TickersQueryResponse
    

    let ticker: String
    let sort: TickerSorting?
    let order: Order?
    let type: TickerTypes?
    let market: MarketOptions?
    let locale: Locale?
    var limit: Int? // how many results per page. Default is 100
    let active: Bool?
    
    var path: String {
        return "/v3/reference/tickers"
    }
    
    var queryItems: [URLQueryItem] {
        // add here the parameters if we have a value
        var parameters: [URLQueryItem] = []
        
        // always append the ticker as there has to be something in this field.
        // for search we created a dedicated function to better handle search and make it simpler
        parameters.append(URLQueryItem(name: "ticker", value: ticker))
        
        // append sort if we have one
        if sort != nil {
            parameters.append(URLQueryItem(name: "sort", value: sort?.rawValue))
        }
        
        // append sort if we have one
        if order != nil {
            parameters.append(URLQueryItem(name: "order", value: order?.rawValue))
        }
        
        // append type if we have one
        if type != nil {
            parameters.append(URLQueryItem(name: "type", value: type?.rawValue))
        }
        
        // append market if we have one
        if market != nil {
            parameters.append(URLQueryItem(name: "market", value: market?.rawValue))
        }
        
        // append locale if we have one
        if locale != nil {
            parameters.append(URLQueryItem(name: "locale", value: locale?.rawValue))
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
        
        return parameters
    }
}
