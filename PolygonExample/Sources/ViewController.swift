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
        PolygonioSwift.shared.configure(apiKey: apiKey)
        
        // set debug if needed
        PolygonioSwift.shared.setDebug(enable: true)
        
        // set a symbol to test
        let symbol = "AAPL"
        
        // Example accessing stocks
        PolygonioSwift.shared.stocks.aggregatesGrouopedDaily(date: "2025-06-03") { result in
            switch result {
            case .success(let snapshot):
                print("Successfully fetched snapshot")
                print(snapshot)
            case .failure(let error):
                // An error occurred
                print("Error fetching snapshot \(error.localizedDescription)")
                if let requestId = error.requestId {
                    print("  Request ID: \(requestId)")
                }
                if let status = error.status {
                    print("  Status: \(status)")
                }
            }
        }
        
        PolygonioSwift.shared.stocks.aggregates(ticker: symbol, multiplier: 1, timespan: .day, from: "2024-06-04", to: "2025-06-04") { result in
            switch result {
            case .success(let snapshot):
                print("Successfully fetched snapshot")
                print(snapshot)
            case .failure(let error):
                // An error occurred
                print("Error fetching snapshot \(error.localizedDescription)")
                if let requestId = error.requestId {
                    print("  Request ID: \(requestId)")
                }
                if let status = error.status {
                    print("  Status: \(status)")
                }
            }
        }
        
        // Ticker Snapshot
        /*PolygonioSwift.shared.stocks.tickerSnapshot(symbol: symbol) { result in
            switch result {
            case .success(let snapshot):
                print("Successfully fetched snapshot for \(symbol):")
                print(snapshot)
            case .failure(let error):
                // An error occurred
                print("Error fetching snapshot for \(symbol): \(error.localizedDescription)")
                if let requestId = error.requestId {
                    print("  Request ID: \(requestId)")
                }
                if let status = error.status {
                    print("  Status: \(status)")
                }
            }
        }
        
        // Related Tickers
        PolygonioSwift.shared.stocks.relatedTickers(ticker: symbol) { result in
            switch result {
            case .success(let snapshot):
                print("Successfully fetched related tickers to \(symbol)")
                print(snapshot)
            case .failure(let error):
                // An error occurred
                print("Error fetching conditions: \(error.localizedDescription)")
                if let requestId = error.requestId {
                    print("  Request ID: \(requestId)")
                }
                if let status = error.status {
                    print("  Status: \(status)")
                }
            }
        }
        
        // Last Trade
        PolygonioSwift.shared.stocks.lastTrade(ticker: symbol) { result in
            switch result {
            case .success(let snapshot):
                print("Successfully fetched last trade for \(symbol)")
                print(snapshot)
            case .failure(let error):
                // An error occurred
                print("Error fetching conditions: \(error.localizedDescription)")
                if let requestId = error.requestId {
                    print("  Request ID: \(requestId)")
                }
                if let status = error.status {
                    print("  Status: \(status)")
                }
            }
        }
        
        // Conditions
        PolygonioSwift.shared.reference.conditions(asset_class: .stocks, order: .ascending, limit: 10) { result in
            switch result {
            case .success(let snapshot):
                print("Successfully fetched conditions")
                print(snapshot)
            case .failure(let error):
                // An error occurred
                print("Error fetching conditions: \(error.localizedDescription)")
                if let requestId = error.requestId {
                    print("  Request ID: \(requestId)")
                }
                if let status = error.status {
                    print("  Status: \(status)")
                }
            }
        }
        
        // Exchanges
        PolygonioSwift.shared.reference.exchanges { result in
            switch result {
            case .success(let snapshot):
                print("Successfully fetched exchanges")
                print(snapshot)
            case .failure(let error):
                // An error occurred
                print("Error fetching conditions: \(error.localizedDescription)")
                if let requestId = error.requestId {
                    print("  Request ID: \(requestId)")
                }
                if let status = error.status {
                    print("  Status: \(status)")
                }
            }
        }*/
        
    }
}

