//
//  StockClient.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

fileprivate let baseURLString = "https://api.polygon.io"



public class Client {
    let session: URLSession
    let builder: URLBuilder
    
    // debug so we can see extra info
    var debug = false
    
    public init(key: String) {
        let components = URLComponents(string: baseURLString)!
        session = URLSession(configuration: .default)
        builder = URLBuilder(components: components, secret: key)
    }
    
    struct URLBuilder {
        let components: URLComponents
        let secret: String
        
        func buildURL<Rq>(_ rq: Rq) -> URL where Rq: ApiRequest {
            var components = self.components
            // configure query string
            var query = rq.queryItems
            query.append(URLQueryItem(name: "apikey", value: secret))
            // add the path and the parameters to the url
            components.path = rq.path
            components.queryItems = query
            
            return components.url!
        }
    }
    
    // to allow setting a debug to print extra info or not
    public func setDebug(enable: Bool) {
        self.debug = enable
    }
    
    //MARK: - Stocks Endpoints
    
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
    public func tickers(sort: TickerSorting? = nil, order: Order? = nil, type: TickerTypes? = nil, market: MarketOptions? = nil, locale: Locale? = nil, ticker: String, limit: Int? = nil, active: Bool? = nil, completion: @escaping (_ response: TickersQueryResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickersQueryRequest(ticker: ticker, sort: sort, order: order, type: type, market: market, locale: locale, limit: limit, active: active)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at tickers()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(TickersQueryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Search a ticker by ticker or company name. This is based of the tickers query request but focusing only on search.
    /// It provides a more simplified tool if you want to just search tickers.
    /// - Parameters:
    ///   - search: Search for terms within the ticker and/or company name.
    ///   - limit: Limit the size of the response, default is 100 and max is 1000.
    ///   - active: Filter for only active or inactive symbols
    ///   - order: The order to sort the results on. Default is asc (ascending).
    ///   - completion: The completion to receive the response which is an TickersQueryResponse object.Tickers data will be inside the tickers property.
    public func searchTickers(search: String, limit: Int? = nil, active: Bool? = nil, order: Order? = nil, type: TickerTypes? = nil, completion: @escaping (_ response: TickerSearchResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickerSearchRequest(search: search, limit: limit, active: active, order: order, type: type)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at tickers()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(TickerSearchResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    
    /// Get the mapping of ticker types to descriptions / long names
    /// - Parameter completion: The completion to receive the response which is an TickerTypesResponse object.
    public func tickerTypes( completion: @escaping (_ response: TickerTypesResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickerTypesRequest()
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at tickerTypes()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(TickerTypesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get the details of the symbol company/entity. These are important details which offer an overview of the entity. Things like name, sector, description, logo and similar companies.
    /// - Parameters:
    ///   - symbol: Symbol we want details for
    ///   - completion: The completion to receive the response which is an TickerResponse object.
    public func tickerDetails(symbol: String, completion: @escaping (_ response: TickerDetailsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickerDetailsRequest(symbol: symbol)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at tickerDetails()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(TickerDetailsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    
    /// Get news articles  in general or for a specific ticker.
    /// - Parameters:
    ///   - ticker: Ticker we want to search news for. If nil then we search for news in general
    ///   - limit: Limit the size of the response, default is 100 and max is 1000.
    ///   - order: The order to sort the results on. Default is asc (ascending).
    ///   - publishedLessEqualThan: Return results where this field is less than or equal to the date. Ex: 2021-06-17
    ///   - publishedGreaterEqualThan: Return results where this field is greater than or equal to the date. Ex: 2021-06-17
    ///   - completion: The completion to receive the response which is an TickerNewsResponse object.
    public func tickerNews(ticker: String? = nil, limit: Int? = nil, order: Order? = nil, publishedLessEqualThan: String? = nil, publishedGreaterEqualThan: String? = nil, completion: @escaping (_ response: TickerNewsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickerNewsRequest(ticker: ticker, limit: limit, order: order, publishedLessEqualThan: publishedLessEqualThan, publishedGreaterEqualThan: publishedGreaterEqualThan)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at tickerNews()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(TickerNewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    
    /// Get the list of currently supported markets by Polygon.io API
    /// - Parameter completion: The completion to receive the response which is an MarketsResponse object.
    public func markets( completion: @escaping (_ response: MarketsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = MarketsRequest()
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at markets()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(MarketsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get the list of currently supported locales by Polygon.io API
    /// - Parameter completion: The completion to receive the response which is an LocalesResponse object.
    public func locales( completion: @escaping (_ response: LocalesResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = LocalesRequest()
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at locales()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(LocalesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get the historical splits for this symbol.
    /// - Parameters:
    ///   - symbol: Symbol we want historical splits data for
    ///   - completion: The completion to receive the response which is an StockSplitsResponse object.
    public func stockSplits(symbol: String, completion: @escaping (_ response: StockSplitsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = StockSplitsRequest(symbol: symbol)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at stockSplits()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(StockSplitsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get the historical divdends for this ticker.
    /// - Parameters:
    ///   - symbol: Symbol we want historical dividends data for
    ///   - completion: The completion to receive the response which is an StockDividendsResponse object.
    public func stockDividends(symbol: String, completion: @escaping (_ response: StockDividendsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = StockDividendsRequest(symbol: symbol)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at stockDividends()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(StockDividendsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get the historical financials for this ticker.
    /// - Parameters:
    ///   - symbol: Symbol we want financials data for
    ///   - limit: Limit the number of results
    ///   - type : Specify a type of report to return. Y = Year YA = Year annualized Q = Quarter QA = Quarter Annualized T = Trailing twelve months TA = trailing twelve months annualized
    ///   - completion: The completion to receive the response which is an StockFinancialsResponse object.
    public func stockFinancials(symbol: String, limit: Int = 5, type: FinancialType? = nil, completion: @escaping (_ response: StockFinancialsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = StockFinancialsRequest(symbol: symbol, limit: limit, type: type)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at stockFinancials()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(StockFinancialsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Current status of each market
    /// - Parameter completion: The completion to receive the response which is an MarketStatusResponse object.
    public func marketStatus( completion: @escaping (_ response: MarketStatusResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = MarketStatusRequest()
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at marketStatus()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(MarketStatusResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get upcoming market holidays and their open/close times
    /// - Parameter completion: The completion to receive the response which is an  array of MarketHolidaysResponse object.
    public func marketHolidays( completion: @escaping (_ response: [MarketHolidaysResponse?], _ error: PolygonSwiftError?) -> Void) {
        let rq = MarketHolidaysRequest()
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion([], PolygonSwiftError(error?.localizedDescription ?? "Data is empty at marketHolidays()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode([MarketHolidaysResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion([], PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion([], PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get the previous day close for the specified ticker
    /// - Parameters:
    ///   - symbol: Symbol we want historical dividends data for
    ///   - unadjusted: Set to true if the results should NOT be adjusted for splits. Default is false.
    ///   - completion: The completion to receive the response which is an PreviousCloseResponse object.
    public func previousClose(symbol: String, unadjusted: Bool = false, completion: @escaping (_ response: PreviousCloseResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = PreviousCloseRequest(symbol: symbol, unadjusted: unadjusted)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at previousClose()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(PreviousCloseResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
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
    public func aggregates(ticker:String, multiplier:Int, timespan:TimeSpan, from:String, to:String, unadjusted:Bool = false, sorting: Sorting = .ascending, completion: @escaping (_ response: AggregatesResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = AggregatesRequest(ticker: ticker, multiplier: multiplier, timespan: timespan, from: from, to: to, unadjusted: unadjusted, sort: sorting)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at aggregates()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(AggregatesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        print(error)
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Get the open, close and afterhours prices of a symbol on a certain date.
    /// - Parameters:
    ///   - symbol: Symbol of the stock to get
    ///   - date: Date of the requested open/close ( YYYY-MM-DD format )
    ///   - completion: The completion to receive the response which is an DailyOpenCloseResponse object.
    public func dailyOpenClose(symbol:String, date:String, completion: @escaping (_ response: DailyOpenCloseResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = DailyOpenCloseRequest(symbol: symbol, date: date)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at dailyOpenClose()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(DailyOpenCloseResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// See the current snapshot of a single ticker
    /// - Parameters:
    ///   - symbol: Ticker of the snapshot
    ///   - completion: The completion to receive the response which is an TickerSnapshotResponse object.
    public func tickerSnapshot(symbol:String, completion: @escaping (_ response: TickerSnapshotResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickerSnapshotRequest(symbol: symbol)
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at tickerSnapshot()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(TickerSnapshotResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    /// Snapshot allows you to see all tickers current minute aggregate, daily aggregate and last trade. As well as previous days aggregate and calculated change for today.
    /// WARNING: The response size is large use this at your own discretion.
    /// - Parameters:
    ///   - completion: The completion to receive the response which is an AllTickersSnapshotResponse object. The tickers property contains an array with all the tickers info inside.
    public func allTickersSnapshot(completion: @escaping (_ response: AllTickersSnapshotResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = AllTickersSnapshotRequest()
        let url = builder.buildURL(rq)
        
        // debug url
        if self.debug {
            print(url.absoluteURL)
        }
        
        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            
            // Unwrap the data and make sure that an error wasn't returned
            guard let data = data, error == nil else {
                // If an error was returned set the value in the completion as nil and print the error
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(error?.localizedDescription ?? "Data is empty at allTickersSnapshot()."))
                }
                return
            }
            
            // add a try/catch so we can fetch any possible errors when decoding response or from the api call
            do {
                // you can debug the raw json reply by using the line below
                //let response = try? JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any]
                let rs = try JSONDecoder().decode(AllTickersSnapshotResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
                if self.debug {
                    // get better error description
                    print(String(describing: error))
                }
                // lets handle the type of error here
                // try to see if we got an error from the api in the response
                guard let responseError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) else {
                    // just send normal error
                    DispatchQueue.main.async {
                        completion(nil, PolygonSwiftError(error.localizedDescription))
                    }
                    return
                }
                
                // if we have an error from the api send that error instead as it may give more info.
                DispatchQueue.main.async {
                    completion(nil, PolygonSwiftError(responseError.error))
                }
            }
        })
        task.resume()
    }
    
    //MARK: - Crypto Endpoints
    
}
