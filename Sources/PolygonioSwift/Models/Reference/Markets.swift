//
//  Markets.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct MarketsRequest : ApiRequest {
    typealias Response = MarketsResponse
    
    var path: String {
        return "/v2/reference/markets"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct MarketsResponse : Decodable {
    
    public var status: String
    public var results: [Dictionary<String,String>]
   
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case results = "results"
    }
}
