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
}
