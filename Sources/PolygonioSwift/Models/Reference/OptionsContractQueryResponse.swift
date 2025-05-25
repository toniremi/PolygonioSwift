//
//  OptionsContractQueryResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import Foundation

public struct OptionsContractQueryResponse: Decodable {
    public let status: String?
    public let requestId: String?
    public let previousUrl: String?
    public let nextUrl: String?
    public let results: [OptionsContractsResults]?

    private enum CodingKeys: String, CodingKey {
        case status
        case requestId = "request_id"
        case previousUrl = "previous_url"
        case nextUrl = "next_url"
        case results
    }
    
    public struct OptionsContractsResults: Decodable {
        public let cfi: String?
        public let contractType: String?
        public let correction: String?
        public let exerciseStyle: String?
        public let expirationDate: String?
        public let primaryExchange: String?
        public let sharesPerContract: Int?
        public let strikePrice: Double?
        public let ticker: String?
        public let underlyingTicker: String?

        private enum CodingKeys: String, CodingKey {
            case cfi
            case contractType = "contract_type"
            case correction
            case exerciseStyle = "exercise_style"
            case expirationDate = "expiration_date"
            case primaryExchange = "primary_exchange"
            case sharesPerContract = "shares_per_contract"
            case strikePrice = "strike_price"
            case ticker
            case underlyingTicker = "underlying_ticker"
        }
    }
}
