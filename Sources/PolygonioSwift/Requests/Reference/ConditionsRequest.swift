//
//  ConditionsRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/24.
//

import Foundation

public enum ConditionsSorting: String {
    case asset_class = "asset_class"
    case data_type = "data_type"
    case id = "id"
    case type = "type"
    case name = "name"
    case lgacy = "legacy"
}

public struct ConditionsRequest : ApiRequest {
    typealias Response = ConditionsResponse
    
    let asset_class: AssetClass?
    let data_type: DataType?
    let id: String?
    let sip: SIP?
    let order: Order?
    let limit: Int?
    let sort: ConditionsSorting?
    
    var path: String {
        return "/v3/reference/conditions"
    }
    
    var queryItems: [URLQueryItem] {
        var parameters: [URLQueryItem] = []
        
        // Filter for conditions within a given asset class.
        if asset_class != nil {
            parameters.append(URLQueryItem(name: "asset_class", value: asset_class?.rawValue))
        }
        
        // Filter by data type.
        if data_type != nil {
            parameters.append(URLQueryItem(name: "data_type", value: data_type?.rawValue))
        }
        
        // Filter for conditions with a given ID.
        if id != nil {
            parameters.append(URLQueryItem(name: "id", value: id))
        }
        
        // Filter by SIP. If the condition contains a mapping for that SIP, the condition will be returned.
        if sip != nil {
            parameters.append(URLQueryItem(name: "sip", value: sip?.rawValue))
        }
        
        // Order results based on the `sort` field.
        if order != nil {
            parameters.append(URLQueryItem(name: "order", value: order?.rawValue))
        }
        
        // Limit the number of results returned, default is 10 and max is 1000.
        if limit != nil {
            parameters.append(URLQueryItem(name: "limit", value: String(limit!)))
        }
        
        if sort != nil {
            parameters.append(URLQueryItem(name: "sort", value: sort?.rawValue))
        }
        
        return parameters
    }
}
