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


