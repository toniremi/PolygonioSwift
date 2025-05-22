//
//  LocalesRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
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
