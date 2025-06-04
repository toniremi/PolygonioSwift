//
//  AggsGroupedDailyResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/06/04.
//

import Foundation

public struct AggsGroupedDailyResponse : Decodable {

    public var status: String
    public var adjusted: Bool
    public var queryCount: Int
    public var results: [Candle]?
    public var requestid: String?
    public var resultsCount: Int
    public var count: Int?

    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case adjusted = "adjusted"
        case queryCount = "queryCount"
        case results = "results"
        case requestid = "request_id"
        case resultsCount = "resultsCount"
        case count = "count"
    }
}
