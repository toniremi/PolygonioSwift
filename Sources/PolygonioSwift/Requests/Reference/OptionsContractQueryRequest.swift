//
//  OptionsContractQueryReqyest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import Foundation

public enum OptionsContractSorting: String {
    case ticker = "ticker"
    case underlying_ticker = "underlying_ticker"
    case expiration_date = "expiration_date"
    case strike_price = "strike_price"
}

public struct OptionsContractQueryRequest : ApiRequest {
    typealias Response = OptionsContractQueryResponse
    
    @available(*, deprecated, message: "Use Reference.optionsContract(ticker:) instead")
    let ticker: String?
    let underlying_ticker: String?
    let contract_type: ContractType?
    let expiration_date: String?
    let as_of: String?
    let strike_price: Double?
    let expired: Bool?
    let order: Order?
    let limit: Int?
    let sort: OptionsContractSorting?
    
    var path: String {
        return "/v3/reference/options/contracts/"
    }
    
    var queryItems: [URLQueryItem] {
        var parameters: [URLQueryItem] = []
        
        // This parameter has been deprecated. To search by specific options ticker, use Reference.optionsContract(ticker:)
        if ticker != nil {
            parameters.append(URLQueryItem(name: "ticker", value: ticker))
        }
        
        // Query for contracts relating to an underlying stock ticker.
        if underlying_ticker != nil {
            parameters.append(URLQueryItem(name: "underlying_ticker", value: underlying_ticker))
        }
        
        // Query by the type of contract.
        if contract_type != nil {
            parameters.append(URLQueryItem(name: "contract_type", value: contract_type?.rawValue))
        }
        
        // Query by contract expiration with date format YYYY-MM-DD.
        if expiration_date != nil {
            parameters.append(URLQueryItem(name: "expiration_date", value: expiration_date))
        }
        
        // Specify a point in time for contracts as of this date with format YYYY-MM-DD. Defaults to today's date.
        if as_of != nil {
            parameters.append(URLQueryItem(name: "as_of", value: as_of))
        }
        
        // Query by strike price of a contract.
        if strike_price != nil {
            parameters.append(URLQueryItem(name: "strike_price", value: String(strike_price!)))
        }
        
        // Query for expired contracts. Default is false.
        if expired != nil {
            parameters.append(URLQueryItem(name: "expired", value: expired?.description))
        }
        
        // Order results based on the `sort` field.
        if order != nil {
            parameters.append(URLQueryItem(name: "order", value: order?.rawValue))
        }
        
        // Limit the number of results returned, default is 10 and max is 1000.
        if limit != nil {
            parameters.append(URLQueryItem(name: "limit", value: String(limit!)))
        }
        
        // Sort field used for ordering.
        if sort != nil {
            parameters.append(URLQueryItem(name: "sort", value: sort?.rawValue))
        }
        
        return parameters
    }
}
