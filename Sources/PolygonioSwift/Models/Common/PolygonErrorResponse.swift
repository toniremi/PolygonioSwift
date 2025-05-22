//
//  PolygonErrorResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

public struct PolygonErrorResponse : Decodable {
    
    public var status: String?
    public var request_id: String?
    public var error: String
}
