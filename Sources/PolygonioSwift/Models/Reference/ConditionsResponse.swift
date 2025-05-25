//
//  ConditionsResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/24.
//

import Foundation

public struct ConditionsResponse: Decodable {
    public let status: String
    public let requestId: String
    public let count: Int
    public let previousUrl: String?
    public let nextUrl: String?
    public let results: [ConditionsResults]

    private enum CodingKeys: String, CodingKey {
        case status
        case requestId = "request_id"
        case count
        case previousUrl = "previous_url"
        case nextUrl = "next_url"
        case results
    }
    
    public struct ConditionsResults: Decodable {
        public let abbreviation: String?
        public let assetClass: String
        public let dataTypes: [String]
        public let description: String?
        public let exchange: Int?
        public let id: Int
        public let legacy: Bool?
        public let name: String
        public let sipMapping: SipMapping
        public let type: String
        public let updateRules: UpdateRules?

        private enum CodingKeys: String, CodingKey {
            case abbreviation
            case assetClass = "asset_class"
            case dataTypes = "data_types"
            case description
            case exchange
            case id
            case legacy
            case name
            case sipMapping = "sip_mapping"
            case type
            case updateRules = "update_rules"
        }

        public struct SipMapping: Decodable {
            public let cta: String?
            public let opra: String?
            public let utp: String?

            private enum CodingKeys: String, CodingKey {
                case cta = "CTA"
                case opra = "OPRA"
                case utp = "UTP"
            }
        }

        public struct UpdateRules: Decodable {
            public let consolidated: ConsolidatedRule?
            public let marketCenter: MarketCenterRule? // Renamed from market_center for Swiftiness if desired

            private enum CodingKeys: String, CodingKey {
                case consolidated
                case marketCenter = "market_center"
            }
        }

        public struct ConsolidatedRule: Decodable {
            public let updatesHighLow: Bool
            public let updatesOpenClose: Bool
            public let updatesVolume: Bool

            private enum CodingKeys: String, CodingKey {
                case updatesHighLow = "updates_high_low"
                case updatesOpenClose = "updates_open_close"
                case updatesVolume = "updates_volume"
            }
        }

        public struct MarketCenterRule: Decodable { // Renamed from market_center for clarity if it's a type name
            public let updatesHighLow: Bool
            public let updatesOpenClose: Bool
            public let updatesVolume: Bool

            private enum CodingKeys: String, CodingKey {
                case updatesHighLow = "updates_high_low"
                case updatesOpenClose = "updates_open_close"
                case updatesVolume = "updates_volume"
            }
        }
    }
}
