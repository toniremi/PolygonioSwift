//
//  ExchangesResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import Foundation

public struct ExchangesResponse: Decodable {
    public let status: String
    public let requestId: String
    public let count: Int?
    public let results: [ExchangesResults]

    private enum CodingKeys: String, CodingKey {
        case status
        case requestId = "request_id"
        case count
        case results
    }
    
    public struct ExchangesResults: Decodable {
        public let acronym: String?
        public let assetClass: String
        public let id: Int
        public let locale: String
        public let mic: String?
        public let name: String
        public let operatingMic: String?
        public let participantId: String?
        public let type: String
        public let url: String?

        private enum CodingKeys: String, CodingKey {
            case acronym = "acronymstring"
            case assetClass = "asset_class"
            case id
            case locale
            case mic
            case name
            case operatingMic = "operating_mic"
            case participantId = "participant_id"
            case type
            case url
        }
    }
}
