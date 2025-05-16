//
//  ViewController.swift
//  iOS Example
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import UIKit
import PolygonioSwift

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let apiKey = Bundle.main.infoDictionary?["POLYGON_KEY"] as? String

        guard let apiKey = apiKey else {
            print("Polygon.IO API Key not found in Info.plist. Please set 'API_KEY'.")
            return
        }
        
        print("Polygon.IO API Key: \(apiKey)")
        
        // Do any additional setup after loading the view.
        let polygon = PolygonioSwift.Client(key: apiKey)
        
        polygon.setDebug(enable: true)
        
        // Market Status
        polygon.marketStatus { (result: MarketStatusResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
                print(result?.market)
            }
        }
        
        // Ticker News
        polygon.tickerNews(ticker: "AAPL",limit: 5, order: .descending, publishedLessEqualThan: nil, publishedGreaterEqualThan: nil) { (result:TickerNewsResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
            }
        }
        
        // Market Holidays
       polygon.marketHolidays { (result: [MarketHolidaysResponse?], err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
            }
        }
        
        // Daily Open Close
        polygon.dailyOpenClose(symbol: "AAPL", date: "2020-09-11") { (result: DailyOpenCloseResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
            }
        }
        
        // Tickers Query
        polygon.tickers(sort: .ticker, order: nil, type: nil, market: .Stocks, locale: nil, ticker: "AAPL", limit: 100, active: true) { (result:TickersQueryResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
                print(result?.results)
            }
        }
        
        // Ticker Search
        polygon.searchTickers(search: "Vis", type: .CommonStock) {
            (result:TickerSearchResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
                print(result?.results)
            }
        }
        
        // Stock Financials
        polygon.stockFinancials(symbol: "AAPL", limit: 5, type: .Year) { (result: StockFinancialsResponse?, err) in
            if let err = err {
                print(err)
            } else {
                print(result)
            }
        }
        
        // Ticker Details @deprecated use
        polygon.tickerDetails(symbol: "AAPL") { (result:TickerDetailsResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print("Old ticker Details. Please use polygon.tickerOverview(symbol:) instead")
                print(result)
                
            }
        }
        
        // Ticker Overview (new ticker details)
        polygon.tickerOverview(symbol: "AAPL") { (result:TickerOverviewResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
            }
        }
        
        // Fetch Aggregates (Candle Data)
        polygon.aggregates(ticker: "AAPL", multiplier: 1, timespan: .day, from: "2020-06-01", to: "2020-12-01") { (result:AggregatesResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
                print(result?.results)
            }
        }
    }
}

