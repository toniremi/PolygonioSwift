//
//  StocksClient.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

import Foundation

public class StocksClient {
    private weak var polygonswift: PolygonioSwift?
    var debug: Bool { // computed property to get debug status from main client
        get { return polygonswift?.debug ?? false }
        set { polygonswift?.debug = newValue } // Allows setting if needed, or make it read-only
    }


    init(polygonswift: PolygonioSwift) {
        self.polygonswift = polygonswift
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
    
    
    /// Search a ticker by ticker or company name. This is based of the tickers query request but focusing only on search.
    /// It provides a more simplified tool if you want to just search tickers.
    /// - Parameters:
    ///   - search: Search for terms within the ticker and/or company name.
    ///   - limit: Limit the size of the response, default is 100 and max is 1000.
    ///   - active: Filter for only active or inactive symbols
    ///   - order: The order to sort the results on. Default is asc (ascending).
    ///   - completion: The completion to receive the response which is an TickersQueryResponse object.Tickers data will be inside the tickers property.
    public func searchTickers(search: String, limit: Int? = nil, active: Bool? = nil, order: Order? = nil, type: TickerTypes? = nil, completion: @escaping (Result<TickerSearchResponse, PolygonSwiftError>) -> Void) {
        let request = TickerSearchRequest(search: search, limit: limit, active: active, order: order, type: type)
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
    
    /// Get the previous day close for the specified ticker
    /// - Parameters:
    ///   - symbol: Symbol we want historical dividends data for
    ///   - unadjusted: Set to true if the results should NOT be adjusted for splits. Default is false.
    ///   - completion: The completion to receive the response which is an PreviousCloseResponse object.
    public func previousClose(symbol: String, unadjusted: Bool = false, completion: @escaping (Result<PreviousCloseResponse, PolygonSwiftError>) -> Void) {
        let request = PreviousCloseRequest(symbol: symbol, unadjusted: unadjusted)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    

    /// Get aggregates for a date range, in custom time window sizes.
    /// - Parameters:
    ///   - ticker: Ticker symbol of the request
    ///   - multiplier: Size of the timespan multiplier. Ex: 1, 5, 10
    ///   - timespan: Size of the time window
    ///   - from: From date. format for date is YYYY-MM-DD Ex: 2020-09-10 ; also can use timestamp in milliseconds ex: 1599701937000
    ///   - to: To date. format for date is YYYY-MM-DD Ex: 2020-09-10 ; also can use timestamp in milliseconds ex: 1599701937000
    ///   - unadjusted: Set to true if the results should NOT be adjusted for splits. Default is false.
    ///   - sorting: Sort by timestamp. Default is ascending.
    ///   - completion: The completion to receive the response which is an AggregateResponse object. Candle data will be inside the results property..
    public func aggregates(ticker:String, multiplier:Int, timespan:TimeSpan, from:String, to:String, unadjusted:Bool = false, sorting: Sorting = .ascending, completion: @escaping (Result<AggregatesResponse, PolygonSwiftError>) -> Void) {
        let request = AggregatesRequest(ticker: ticker, multiplier: multiplier, timespan: timespan, from: from, to: to, unadjusted: unadjusted, sort: sorting)
        polygonswift?.dispatch(request: request, completion: completion)
    }

    
    /// Get the open, close and afterhours prices of a symbol on a certain date.
    /// - Parameters:
    ///   - symbol: Symbol of the stock to get
    ///   - date: Date of the requested open/close ( YYYY-MM-DD format )
    ///   - completion: The completion to receive the response which is an DailyOpenCloseResponse object.
    public func dailyOpenClose(symbol:String, date:String, completion: @escaping (Result<DailyOpenCloseResponse, PolygonSwiftError>) -> Void) {
        let request = DailyOpenCloseRequest(symbol: symbol, date: date)
        polygonswift?.dispatch(request: request, completion: completion)
    }
    
    
    /// See the current snapshot of a single ticker
    /// - Parameters:
    ///   - symbol: Ticker of the snapshot
    ///   - completion: The completion to receive the response which is an TickerSnapshotResponse object.
    public func tickerSnapshot(symbol:String, completion: @escaping (Result<TickerSnapshotResponse, PolygonSwiftError>) -> Void) {
        let request = TickerSnapshotRequest(symbol: symbol)
        polygonswift?.dispatch(request: request, completion: completion)
    }

    /// Snapshot allows you to see all tickers current minute aggregate, daily aggregate and last trade. As well as previous days aggregate and calculated change for today.
    /// WARNING: The response size is large use this at your own discretion.
    /// - Parameters:
    ///   - completion: The completion to receive the response which is an AllTickersSnapshotResponse object. The tickers property contains an array with all the tickers info inside.
    public func allTickersSnapshot(completion: @escaping (Result<AllTickersSnapshotResponse, PolygonSwiftError>) -> Void) {
        let request = AllTickersSnapshotRequest()
        polygonswift?.dispatch(request: request, completion: completion)
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
    
    
    
}
