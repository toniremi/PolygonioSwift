//
//  TickerNews.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct TickerNewsRequest : ApiRequest {
    typealias Response = TickerNewsResponse
    
    let symbol: String
    var perpage: Int // how many results per page. Default is 50
    var page: Int // for pagination if not assigned. Default is 1

    var path: String {
        return "/v1/meta/symbols/\(symbol)/news"
    }
    
    var queryItems: [URLQueryItem] {
        
        var parameters: [URLQueryItem] = []
        
        // make sure perPage is between 0 and 50
        var perPageString = String(perpage)
        // just make sure its not bigger than 50 or smaller than 0
        if (perpage < 0 || perpage > 50) {
            perPageString =  String(50) // max is 50 per page
        }
        // add it to the parameters array
        parameters.append(URLQueryItem(name: "perpage", value: perPageString))
        
        // make sure page is between bigger than 0
        var pageString = String(page)
        // just make sure page is not less than 1
        if (page < 1) {
            pageString = String(1) // page cant be negative
        }
        // add it to the parameters array
        parameters.append(URLQueryItem(name: "page", value: pageString))
        
        return parameters
    }
}

public struct TickerNewsResponse : Decodable {
    
    public var symbols: [String]?
    public var timestamp: String?
    public var title: String?
    public var url: String?
    public var source: String?
    public var summary: String?
    public var image: String
    public var keywords: [String]?

    private enum CodingKeys: String, CodingKey {
        case symbols = "symbols"
        case timestamp = "timestamp"
        case title = "title"
        case url = "url"
        case source = "source"
        case summary = "summary"
        case image = "image"
        case keywords = "keywords"
    }
        
}
