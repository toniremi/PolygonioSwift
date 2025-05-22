//
//  TickerNewsRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public struct TickerNewsRequest : ApiRequest {
    typealias Response = TickerNewsResponse
    
    let ticker: String? // if we do not get a ticker then we will get news in general
    var limit: Int? //Limit the size of the response, default is 100 and max is 1000.
    var order: Order?
    var publishedLessEqualThan: String? // to filter news published less than or equal to a date
    var publishedGreaterEqualThan: String? // to filter news published greater than or equal to a date
    
    var path: String {
        return "/v2/reference/news"
    }
    
    var queryItems: [URLQueryItem] {
        
        var parameters: [URLQueryItem] = []
        
        // ticker is optional in case we want news in general
        if ticker != nil {
            parameters.append(URLQueryItem(name: "ticker", value: ticker))
        }
        
        // append limit if we have one
        if limit != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "limit", value: String(limit!)))
        }
        
        // append sort if we have one
        if order != nil {
            parameters.append(URLQueryItem(name: "order", value: order?.rawValue))
        }
        
        // append this in order to search by date
        if publishedLessEqualThan != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "published_utc.lte", value: publishedLessEqualThan))
        }
        
        // append this in order to search by date
        if publishedGreaterEqualThan != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "published_utc.gte", value: publishedGreaterEqualThan))
        }
        
        // always sorted by published date
        parameters.append(URLQueryItem(name: "sort", value: "published_utc"))
        
        return parameters
    }
}
