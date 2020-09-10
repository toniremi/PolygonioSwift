//
//  TickersQueryRequest.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

public struct TickersQueryRequest : ApiRequest {
    typealias Response = TickersQueryResponse
    
    public enum Sorting: String {
        case type = "type"
        case ascending = "ticker"
        case descending = "-ticker"
    }
    
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
    
    // the markets we can select
    public enum MarketOptions: String {
        case Stocks = "STOCKS"
        case Indices = "INDICES"
        case Crypto = "CRYPTO"
        case Forex = "FX"
        case Bonds = "BONDS"
        case MutualFunds = "MF"
        case MoneyMarketFunds = "MMF"
    }
    
    // Can see this by chekcing https://api.polygon.io/v2/reference/locales
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
    
    let sort: Sorting?
    let type: TickerTypes?
    let market: MarketOptions?
    let locale: Locale?
    let search: String
    var perpage: Int // how many results per page. Default is 50
    var page: Int // for pagination if not assigned. Default is 1
    let active: Bool?
    
    var path: String {
        return "/v2/reference/tickers"
    }
    
    var queryItems: [URLQueryItem] {
        // add here the parameters if we have a value
        var parameters: [URLQueryItem] = []
        
        // append sort if we have one
        if sort != nil {
            parameters.append(URLQueryItem(name: "sort", value: sort?.rawValue))
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
        
        // always append the search as there has to be something in this field
        parameters.append(URLQueryItem(name: "search", value: search))
        

        // make sure perPage is between 0 and 50
        var perPageString = String(perpage)
        // just make sure its not bigger than 50 or smaller than 0
        if (perpage < 0 || perpage > 50) {
            perPageString =  String(50) // max is 50 per page
        }
        // add it to the parameters array
        parameters.append(URLQueryItem(name: "perpage", value: perPageString))
        
        // make sure page is between bigger than 0
        var pageString = String(page)
        // just make sure page is not less than 1
        if (page < 1) {
            pageString = String(1) // page cant be negative
        }
        // add it to the parameters array
        parameters.append(URLQueryItem(name: "page", value: pageString))
        
        // append active if we have one
        if active != nil {
            parameters.append(URLQueryItem(name: "active", value: active?.description))
        }
        
        return parameters
    }
}

public struct TickersQueryResponse : Decodable {
    
    public var page: Int
    public var perPage: Int
    public var count: Int
    public var status: String
    public var tickers: [Ticker]
    
    private enum CodingKeys: String, CodingKey {
        case page = "page"
        case perPage = "perPage"
        case count = "count"
        case status = "status"
        case tickers = "tickers"
    }
    
    public struct Ticker : Codable {
        public var ticker: String
        public var name: String
        public var market: String
        public var locale: String
        public var currency: String
        public var active: Bool
        public var primaryExch: String
        public var updated: String
        public var codes: Codes
        public var url: String
        
        private enum CodingKeys: String, CodingKey {
            case ticker = "ticker"
            case name = "name"
            case market = "market"
            case locale = "locale"
            case currency = "currency"
            case active = "active"
            case primaryExch = "primaryExch"
            case updated = "updated"
            case codes = "codes"
            case url = "url"
        }
    }
    
    public struct Codes : Codable {
        public var figiuid: String
        public var scfigi: String
        public var cfigi: String
        public var figi: String
        
        private enum CodingKeys: String, CodingKey {
            case figiuid = "figiuid"
            case scfigi = "scfigi"
            case cfigi = "cfigi"
            case figi = "figi"
        }
    }
    
}
