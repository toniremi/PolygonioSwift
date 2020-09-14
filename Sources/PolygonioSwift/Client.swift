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
    
    
    /// Query all ticker symbols which are supported by Polygon.io. This API includes Indices, Crypto, FX, and Stocks/Equities.
    /// - Parameters:
    ///   - sort: Which field to sort by.
    ///   - type: If you want the results to only container a certain type.
    ///   - market: Get tickers for a specific market
    ///   - locale: Get tickers for a specific region/locale
    ///   - search: Search the name of tickers
    ///   - perpage: How many items to be on each page during pagination. Max 50
    ///   - page: Which page of results to return
    ///   - active: Filter for only active or inactive symbols
    ///   - completion: The completion to receive the response which is an TickersQueryResponse object.Tickers data will be inside the tickers property.
    public func tickers(sort: TickersQueryRequest.Sorting?, type: TickersQueryRequest.TickerTypes?, market: TickersQueryRequest.MarketOptions?, locale: TickersQueryRequest.Locale?, search: String, perpage: Int = 50, page: Int = 1, active: Bool?, completion: @escaping (_ response: TickersQueryResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickersQueryRequest(sort: sort, type: type, market: market, locale: locale, search: search, perpage: perpage, page: page, active: active)
        let url = builder.buildURL(rq)
        
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
                let rs = try JSONDecoder().decode(TickersQueryResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(TickerTypesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(TickerDetailsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
    
    
    /// Get news articles for this ticker.
    /// - Parameters:
    ///   - symbol: Ticker we want to search news for
    ///   - perpage: How many items to be on each page during pagination. Max 50
    ///   - page: Which page of results to return
    ///   - completion: The completion to receive the response which is an TickerNewsResponse object.
    public func tickerNews(symbol: String, perpage: Int = 50, page: Int = 1, completion: @escaping (_ response: TickerNewsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = TickerNewsRequest(symbol: symbol, perpage: perpage, page: page)
        let url = builder.buildURL(rq)
        
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
                let rs = try JSONDecoder().decode(TickerNewsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(MarketsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(LocalesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(StockSplitsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(StockDividendsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
    ///   - completion: The completion to receive the response which is an StockFinancialsResponse object.
    public func stockFinancials(symbol: String, limit: Int, completion: @escaping (_ response: StockFinancialsResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = StockFinancialsRequest(symbol: symbol, limit: limit)
        let url = builder.buildURL(rq)
        
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
                let rs = try JSONDecoder().decode(StockFinancialsResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(MarketStatusResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode([MarketHolidaysResponse].self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
                let rs = try JSONDecoder().decode(PreviousCloseResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
    
    /// Get the open, close and afterhours prices of a symbol on a certain date.
    /// - Parameters:
    ///   - symbol: Symbol of the stock to get
    ///   - date: Date of the requested open/close ( YYYY-MM-DD format )
    ///   - completion: The completion to receive the response which is an DailyOpenCloseResponse object.
    public func dailyOpenClose(symbol:String, date:String, completion: @escaping (_ response: DailyOpenCloseResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = DailyOpenCloseRequest(symbol: symbol, date: date)
        let url = builder.buildURL(rq)
        
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
                let rs = try JSONDecoder().decode(DailyOpenCloseResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
    public func aggregates(ticker:String, multiplier:Int, timespan:AggregatesRequest.TimeSpan, from:String, to:String, unadjusted:Bool = false, sorting:AggregatesRequest.Sorting = .ascending, completion: @escaping (_ response: AggregatesResponse?, _ error: PolygonSwiftError?) -> Void) {
        let rq = AggregatesRequest(ticker: ticker, multiplier: multiplier, timespan: timespan, from: from, to: to, unadjusted: unadjusted, sort: sorting)
        let url = builder.buildURL(rq)
        
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
                let rs = try JSONDecoder().decode(AggregatesResponse.self, from: data)
                DispatchQueue.main.async {
                    completion(rs, nil)
                }
            } catch {
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
    
}
