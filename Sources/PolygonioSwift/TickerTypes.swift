//
//  TickerTypes.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct TickerTypesRequest : ApiRequest {
    typealias Response = TickerTypesResponse
    
    var path: String {
        return "/v2/reference/types"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct TickerTypesResponse : Decodable {
    
    public var status: String
    public var results: Results
   
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case results = "results"
    }
    
    // only shown for Stock Symbols
    public struct Results : Codable {
        public var types: Dictionary<String,String>
        public var indexTypes: Dictionary<String,String>
        
        private enum CodingKeys: String, CodingKey {
            case types = "types"
            case indexTypes = "indexTypes"
        }
    }
    
        
}
