//
//  Ticker.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

public struct TickerDetailsRequest : ApiRequest {
    typealias Response = TickerDetailsResponse
    
    let symbol: String

    var path: String {
        return "/v1/meta/symbols/\(symbol)/company"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct TickerDetailsResponse : Decodable {
    
    public var logo: String
    public var listdate: String
    public var cik: String
    public var bloomberg: String?
    public var figi: String?
    public var lei: String?
    public var sic: Int?
    public var country: String
    public var industry: String
    public var sector: String
    public var marketcap: Int
    public var employees: Int
    public var phone: String
    public var ceo: String
    public var url: String
    public var description: String?
    public var exchange: String?
    public var name: String?
    public var symbol: String?
    public var exchangeSymbol: String?
    public var hq_address: String
    public var hq_state: String
    public var hq_country: String
    public var type: String
    public var updated: String?
    public var tags: [String]
    public var similar: [String]
    public var active: Bool

    private enum CodingKeys: String, CodingKey {
        case logo = "logo"
        case listdate = "listdate"
        case cik = "cik"
        case bloomberg = "bloomberg"
        case figi = "figi"
        case lei = "lei"
        case sic = "sic"
        case country = "country"
        case industry = "industry"
        case sector = "sector"
        case marketcap = "marketcap"
        case employees = "employees"
        case phone = "phone"
        case ceo = "ceo"
        case url = "url"
        case description = "description"
        case exchange = "exchange"
        case name = "name"
        case symbol = "symbol"
        case exchangeSymbol = "exchangeSymbol"
        case hq_address = "hq_address"
        case hq_state = "hq_state"
        case hq_country = "hq_country"
        case type = "type"
        case updated = "updated"
        case tags = "tags"
        case similar = "similar"
        case active = "active"
    }
        
}
