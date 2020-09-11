//
//  Locales.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct LocalesRequest : ApiRequest {
    typealias Response = LocalesResponse
    
    var path: String {
        return "/v2/reference/locales"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct LocalesResponse : Decodable {
    
    public var status: String
    public var results: [Dictionary<String,String>]
   
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case results = "results"
    }
}
