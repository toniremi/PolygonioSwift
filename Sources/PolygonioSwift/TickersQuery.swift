//
//  TickersQuery.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

public struct TickersQueryRequest : ApiRequest {
    typealias Response = TickersQueryResponse
    
    public enum Sorting: String {
        case ticker = "ticker"
        case name = "name"
        case market = "market"
        case locale = "locale"
        case type = "type"
        case primaryExch = "primary_exchange"
        case active = "active"
        case currency = "currency_name"
        case cik = "cik"
        case composite_figi = "composite_figi"
        case share_class_figi = "share_class_figi"
        case last_updated_utc = "last_updated_utc"
    }
    
    public enum Order: String {
        case ascending = "asc"
        case descending = "desc"
    }
    
    // Can see this by checking https://api.polygon.io/v2/reference/types
    public enum TickerTypes: String {
        // Stock Types
        case CommonStock = "CS"
        case AmericanDepositoryReceipt = "ADR"
        case NonVotingDepositoryReceipt = "NVDR"
        case GlobalDepositaryReceipt = "GDR"
        case SpecialDrawingRight = "SDR"
        case ClosedEndFund = "CEF"
        case ExchangeTradedProduct_Fund = "ETP"
        case RealEstateInvestmentTrust = "REIT"
        case MasterLimitedPartnership = "MLP"
        case EquityWRT = "WRT"
        case Public = "PUB"
        case NewYorkRegistryShares = "NYRS"
        case Unit = "UNIT"
        case Right = "RIGHT"
        case TrackingStockOrTargetedStock = "TRAK"
        case LimitedPartnership = "LTDP"
        case RoyaltyTrust = "RYLT"
        case MutualFund = "MF"
        case PreferredStock = "PFD"
        case ForeignOrdinaryShares = "FDR"
        case OtherSecurityType = "OST"
        case Fund = "FUND"
        case StructuredProduct = "SP"
        case SecondaryIssue = "SI"
        // Index Types
        case Index = "INDEX"
        case ExchangeTradedFund = "ETF"
        case ExchangeTradedNote = "ETN"
        case ExchangeTradedManagedFund = "ETMF"
        case Settlement = "SETTLEMENT"
        case Spot = "SPOT"
        case SubordinatedProduct = "SUBPROD"
        case WorldCurrency = "WC"
        case AlphaIndex = "ALPHAINDEX"
    }
    
    // Can see this by checking
    public enum MarketOptions: String {
        case Stocks = "stocks"
        case Crypto = "crypto"
        case Forex = "fx"
    }
    
    // Can see this by checking https://api.polygon.io/v2/reference/locales
    public enum Locale: String {
        case global = "G"
        case UnitedStates = "US"
        case GreatBritain = "GB"
        case Canada = "CA"
        case Netherlands = "NL"
        case Greece = "GR"
        case Spain = "SP"
        case Germany = "DE"
        case Belgium = "BE"
        case Denmark = "DK"
        case Finland = "FI"
        case Ireland = "IE"
        case Portugal = "PT"
        case India = "IN"
        case Mexico = "MX"
        case France = "FR"
        case China = "CN"
        case Switzerland = "CH"
        case Sweden = "SE"
    }
    
    
    
    let ticker: String
    let sort: Sorting?
    let order: Order?
    let type: TickerTypes?
    let market: MarketOptions?
    let locale: Locale?
    var limit: Int? // how many results per page. Default is 100
    let active: Bool?
    
    var path: String {
        return "/v3/reference/tickers"
    }
    
    var queryItems: [URLQueryItem] {
        // add here the parameters if we have a value
        var parameters: [URLQueryItem] = []
        
        // always append the ticker as there has to be something in this field.
        // for search we created a dedicated function to better handle search and make it simpler
        parameters.append(URLQueryItem(name: "ticker", value: ticker))
        
        // append sort if we have one
        if sort != nil {
            parameters.append(URLQueryItem(name: "sort", value: sort?.rawValue))
        }
        
        // append sort if we have one
        if order != nil {
            parameters.append(URLQueryItem(name: "order", value: order?.rawValue))
        }
        
        // append type if we have one
        if type != nil {
            parameters.append(URLQueryItem(name: "type", value: type?.rawValue))
        }
        
        // append market if we have one
        if market != nil {
            parameters.append(URLQueryItem(name: "market", value: market?.rawValue))
        }
        
        // append locale if we have one
        if locale != nil {
            parameters.append(URLQueryItem(name: "locale", value: locale?.rawValue))
        }
        
        // append limit if we have one
        if limit != nil {
            // add it to the parameters array
            parameters.append(URLQueryItem(name: "limit", value: String(limit!)))
        }
        
        // append active if we have one
        if active != nil {
            parameters.append(URLQueryItem(name: "active", value: active?.description))
        }
        
        return parameters
    }
}

public struct TickersQueryResponse : Decodable {
    
    public var request_id: String
    public var count: Int
    public var status: String
    public var results: [Ticker]
    
    private enum CodingKeys: String, CodingKey {
        case request_id = "request_id"
        case count = "count"
        case status = "status"
        case results = "results"
    }
    
    public struct Ticker : Codable {
        public var ticker: String
        public var name: String
        public var market: String
        public var locale: String
        public var primaryExch: String
        public var type: String
        public var currency: String
        public var active: Bool
        
        public var cik: String
        public var composite_figi: String
        public var share_class_figi: String
        public var last_updated_utc: String
        
        private enum CodingKeys: String, CodingKey {
            case ticker = "ticker"
            case name = "name"
            case market = "market"
            case locale = "locale"
            case primaryExch = "primary_exchange"
            case type = "type"
            case active = "active"
            case currency = "currency_name"
            case cik = "cik"
            case composite_figi = "composite_figi"
            case share_class_figi = "share_class_figi"
            case last_updated_utc = "last_updated_utc"
        }
    }
}
