//
//  File.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 7/2/21.
//

import Foundation

// This is an adapted request.
// There is no search end point but we can use the tickers endpoint to focus only on search functionality.
// This way we can make a more simplified endpoint only focused on searching a ticker by ticker name or company name.
public struct TickerSearchRequest : ApiRequest {
    typealias Response = TickersQueryResponse
        
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

public struct TickerSearchResponse : Decodable {
    
    public var request_id: String
    public var count: Int
    public var status: String
    public var results: [Ticker]
    
    private enum CodingKeys: String, CodingKey {
        case request_id = "request_id"
        case count = "count"
        case status = "status"
        case results = "results"
    }
    
    public struct Ticker : Codable {
        public var ticker: String
        public var name: String
        public var market: String
        public var locale: String
        public var primaryExch: String
        public var type: String
        public var currency: String
        public var active: Bool
        
        public var cik: String?
        public var composite_figi: String?
        public var share_class_figi: String?
        public var last_updated_utc: String
        
        private enum CodingKeys: String, CodingKey {
            case ticker = "ticker"
            case name = "name"
            case market = "market"
            case locale = "locale"
            case primaryExch = "primary_exchange"
            case type = "type"
            case active = "active"
            case currency = "currency_name"
            case cik = "cik"
            case composite_figi = "composite_figi"
            case share_class_figi = "share_class_figi"
            case last_updated_utc = "last_updated_utc"
        }
    }
}

