//
//  ReferenceClient.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import Foundation

public class ReferenceClient {
    private weak var polygonswift: PolygonioSwift?
    var debug: Bool { // computed property to get debug status from main client
        get { return polygonswift?.debug ?? false }
        set { polygonswift?.debug = newValue } // Allows setting if needed, or make it read-only
    }
    
    
    init(polygonswift: PolygonioSwift) {
        self.polygonswift = polygonswift
    }
    
    /// Retrieve a unified and comprehensive list of trade and quote conditions from various upstream market data providers (e.g., CTA, UTP, OPRA, FINRA).
    /// - Parameters:
    ///   - asset_class: Ticker we want to search news for. If nil then we search for news in general
    ///   - data_type: Limit the size of the response, default is 100 and max is 1000.
    ///   - id: The order to sort the results on. Default is asc (ascending).
    ///   - sip: Return results where this field is less than or equal to the date. Ex: 2021-06-17
    ///   - order: Return results where this field is greater than or equal to the date. Ex: 2021-06-17
    ///   - limit: The completion to receive the response which is an TickerNewsResponse object.
    ///   - sort: The completion to receive the response which is an AllTickersSnapshotResponse object. The tickers property contains an array with all the tickers info inside.
    public func conditions(asset_class: AssetClass? = nil, data_type: DataType? = nil,id:String? = nil,sip: SIP? = nil,order: Order? = nil, limit: Int? = nil, sort: ConditionsSorting? = nil, completion: @escaping (Result<ConditionsResponse, PolygonSwiftError>) -> Void) {
        let request = ConditionsRequest(asset_class: asset_class, data_type: data_type, id: id, sip: sip, order: order, limit: limit, sort: sort)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Retrieve a list of known exchanges, including their identifiers, names, market types, and other relevant attributes.
    /// This information helps map exchange codes, understand market coverage, and integrate exchange details into applications.
    /// - Parameters:
    ///   - asset_class: Ticker we want to search news for. If nil then we search for news in general
    ///   - locale: Filter by locale.
    public func exchanges(asset_class: AssetClass? = nil, locale: Locale? = nil, completion: @escaping (Result<ExchangesResponse, PolygonSwiftError>) -> Void) {
        let request = ExchangesRequest(asset_class: asset_class, locale: locale)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Retrieve detailed information about a specific options contract, including its contract type (call or put),
    /// exercise style, expiration date, strike price, shares per contract, underlying ticker, and primary exchange.
    /// - Parameters:
    ///   - ticker: Query for a contract by options ticker.
    ///   - locale: Specify a point in time for the contract as of this date with format YYYY-MM-DD. Defaults to today's date.
    public func optionsContract(ticker: String, as_of: String? = nil, completion: @escaping (Result<OptionsContractResponse, PolygonSwiftError>) -> Void) {
        let request = OptionsContractRequest(optionTicker: ticker, as_of: as_of)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Retrieve a comprehensive index of options contracts, encompassing both active and expired listings.
    /// This endpoint can return a broad selection of contracts or be narrowed down to those tied to a specific underlying ticker.
    /// Each contract entry includes details such as contract type (call/put), exercise style, expiration date, and strike price.
    /// - Parameters:
    ///   - ticker: This parameter has been deprecated. To search by specific options ticker, use Reference.optionsContract(ticker:)
    ///   - underlying_ticker: Query for contracts relating to an underlying stock ticker.
    ///   - contract_type: Query by the type of contract.
    ///   - expiration_date: Query by contract expiration with date format YYYY-MM-DD.
    ///   - as_of: Specify a point in time for contracts as of this date with format YYYY-MM-DD. Defaults to today's date.
    ///   - strike_price: Query by strike price of a contract.
    ///   - expired: Query for expired contracts. Default is false.
    ///   - order: Order results based on the `sort` field.
    ///   - limit: Limit the number of results returned, default is 10 and max is 1000.
    ///   - sort: Sort field used for ordering.
    public func optionsContractQuery(ticker: String? = nil, underlying_ticker: String? = nil, contract_type: ContractType? = nil, expiration_date: String? = nil, as_of: String? = nil, strike_price: Double? = nil, expired: Bool? = nil, order: Order? = nil, limit: Int? = nil, sort: OptionsContractSorting? = nil,  completion: @escaping (Result<OptionsContractQueryResponse, PolygonSwiftError>) -> Void) {
        let request = OptionsContractQueryRequest(ticker: ticker, underlying_ticker: underlying_ticker, contract_type: contract_type, expiration_date: expiration_date, as_of: as_of, strike_price: strike_price, expired: expired, order: order, limit: limit, sort: sort)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Query all or a specific ticker symbol which are supported by Polygon.io. This API includes Indices, Crypto, FX, and Stocks/Equities.
    /// - Parameters:
    ///   - ticker: Specify a ticker symbol. Defaults to empty string which queries all tickers.
    ///   - sort: Which field to sort by.
    ///   - type: If you want the results to only container a certain type.
    ///   - market: Get tickers for a specific market
    ///   - locale: Get tickers for a specific region/locale
    ///   - limit: Limit the size of the response, default is 100 and max is 1000.
    ///   - active: Filter for only active or inactive symbols
    ///   - completion: The completion to receive the response which is an TickersQueryResponse object.Tickers data will be inside the tickers property.
    public func tickers(sort: TickerSorting? = nil, order: Order? = nil, type: TickerTypes? = nil, market: MarketOptions? = nil, locale: Locale? = nil, ticker: String, limit: Int? = nil, active: Bool? = nil, completion: @escaping (Result<TickersQueryResponse, PolygonSwiftError>) -> Void) {
        let request = TickersQueryRequest(ticker: ticker, sort: sort, order: order, type: type, market: market, locale: locale, limit: limit, active: active)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    
   
    
    /// Get the mapping of ticker types to descriptions / long names
    /// - Parameter completion: The completion to receive the response which is an TickerTypesResponse object.
    public func tickerTypes(completion: @escaping (Result<TickerTypesResponse, PolygonSwiftError>) -> Void) {
        let request = TickerTypesRequest()
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Get the details of the symbol company/entity. These are important details which offer an overview of the entity. Things like name, sector, description, logo and similar companies.
    /// - Parameters:
    ///   - symbol: Symbol we want details for
    ///   - completion: The completion to receive the response which is an TickerResponse object.
    @available(*, deprecated, message: "Use tickerOverview(symbol:) instead")
    public func tickerDetails(symbol: String, completion: @escaping (Result<TickerDetailsResponse, PolygonSwiftError>) -> Void) {
        let request = TickerDetailsRequest(symbol: symbol)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Get comprehensive details for a single ticker supported by Polygon.io. These are important details which offer an overview of the entity. Things like name, sector, description, logo and similar companies.
    /// - Parameters:
    ///   - symbol: Symbol we want details for
    ///   - completion: The completion to receive the response which is an TickerOverviewResponse object.
    public func tickerOverview(symbol: String, completion: @escaping (Result<TickerOverviewResponse, PolygonSwiftError>) -> Void) {
        let request = TickerOverviewRequest(symbol: symbol)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    
    /// Get news articles  in general or for a specific ticker.
    /// - Parameters:
    ///   - ticker: Ticker we want to search news for. If nil then we search for news in general
    ///   - limit: Limit the size of the response, default is 100 and max is 1000.
    ///   - order: The order to sort the results on. Default is asc (ascending).
    ///   - publishedLessEqualThan: Return results where this field is less than or equal to the date. Ex: 2021-06-17
    ///   - publishedGreaterEqualThan: Return results where this field is greater than or equal to the date. Ex: 2021-06-17
    ///   - completion: The completion to receive the response which is an TickerNewsResponse object.
    public func tickerNews(ticker: String? = nil, limit: Int? = nil, order: Order? = nil, publishedLessEqualThan: String? = nil, publishedGreaterEqualThan: String? = nil, completion: @escaping (Result<TickerNewsResponse, PolygonSwiftError>) -> Void) {
        let request = TickerNewsRequest(ticker: ticker, limit: limit, order: order, publishedLessEqualThan: publishedLessEqualThan, publishedGreaterEqualThan: publishedGreaterEqualThan)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Get the list of currently supported markets by Polygon.io API
    /// - Parameter completion: The completion to receive the response which is an MarketsResponse object.
    public func markets(completion: @escaping (Result<MarketsResponse, PolygonSwiftError>) -> Void) {
        let request = MarketsRequest()
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Get the list of currently supported locales by Polygon.io API
    /// - Parameter completion: The completion to receive the response which is an LocalesResponse object.
    public func locales(completion: @escaping (Result<LocalesResponse, PolygonSwiftError>) -> Void) {
        let request = LocalesRequest()
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Get the historical splits for this symbol.
    /// - Parameters:
    ///   - symbol: Symbol we want historical splits data for
    ///   - completion: The completion to receive the response which is an StockSplitsResponse object.
    public func stockSplits(symbol: String, completion: @escaping (Result<StockSplitsResponse, PolygonSwiftError>) -> Void) {
        let request = StockSplitsRequest(symbol: symbol)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    
    /// Get the historical divdends for this ticker.
    /// - Parameters:
    ///   - symbol: Symbol we want historical dividends data for
    ///   - completion: The completion to receive the response which is an StockDividendsResponse object.
    public func stockDividends(symbol: String, completion: @escaping (Result<StockDividendsResponse, PolygonSwiftError>) -> Void) {
        let request = StockDividendsRequest(symbol: symbol)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    /// Get the historical financials for this ticker.
    /// - Parameters:
    ///   - symbol: Symbol we want financials data for
    ///   - limit: Limit the number of results
    ///   - type : Specify a type of report to return. Y = Year YA = Year annualized Q = Quarter QA = Quarter Annualized T = Trailing twelve months TA = trailing twelve months annualized
    ///   - completion: The completion to receive the response which is an StockFinancialsResponse object.
    public func stockFinancials(symbol: String, limit: Int = 5, type: FinancialType? = nil, completion: @escaping (Result<StockFinancialsResponse, PolygonSwiftError>) -> Void) {
        let request = StockFinancialsRequest(symbol: symbol, limit: limit, type: type)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    
    /// Current status of each market
    /// - Parameter completion: The completion to receive the response which is an MarketStatusResponse object.
    public func marketStatus(completion: @escaping (Result<MarketStatusResponse, PolygonSwiftError>) -> Void) {
        let request = MarketStatusRequest()
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    
    /// Get upcoming market holidays and their open/close times
    /// - Parameter completion: The completion to receive the response which is an  array of MarketHolidaysResponse object.
    public func marketHolidays(completion: @escaping (Result<MarketHolidaysResponse, PolygonSwiftError>) -> Void) {
        let request = MarketHolidaysRequest()
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
}
