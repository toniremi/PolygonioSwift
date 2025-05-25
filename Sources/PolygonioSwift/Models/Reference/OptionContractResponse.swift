//
//  OptionContractResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

public struct OptionsContractResponse: Decodable {
    public let requestId: String?
    public let results: OptionsContractResults?
    public let status: String?

    private enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case results
        case status
    }
    
    public struct OptionsContractResults: Decodable {
        public let additionalUnderlyings: [AdditionalUnderlyings]?
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
            case additionalUnderlyings = "additional_underlyings"
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
    
    public struct AdditionalUnderlyings: Decodable {
        public let amount: Double
        public let type: String
        public let underlying: String
    }
}
