//
//  OptionContractRequest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import Foundation

public struct OptionsContractRequest : ApiRequest {
    typealias Response = OptionsContractResponse
    
    let optionTicker: String
    let as_of: String?
    
    var path: String {
        return "/v3/reference/options/contracts/\(optionTicker)"
    }
    
    var queryItems: [URLQueryItem] {
        var parameters: [URLQueryItem] = []
        
        // Filter for conditions within a given asset class.
        if as_of != nil {
            parameters.append(URLQueryItem(name: "as_of", value: as_of))
        }
        
        return parameters
    }
}
