//
//  TickerTypesResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

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
