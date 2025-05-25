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
}
