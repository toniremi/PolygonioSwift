//
//  RelatedTickersResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/27.
//

public struct RelatedTickersResponse: Decodable {
    public let requestId: String
    public let results: [TickerResult]
    public let status: String
    public let ticker: String

    private enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case results
        case status
        case ticker
    }
    
    public struct TickerResult: Decodable {
        public let ticker: String
    }
}
