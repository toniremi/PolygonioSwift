//
//  ViewController.swift
//  iOS Example
//
//  Created by __AUTHOR NAME__ on __TODAYS_DATE__.
//  Copyright © __TODAYS_YEAR__ __ORGANIZATION NAME__. All rights reserved.
//

import UIKit
import PolygonioSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let polygon = PolygonioSwift.Client(key: "YOUR_POLYGON_API_KEY")
        
        // Tickers Query
        
        /*polygon.tickers(sort: .type, type: nil, market: .Stocks, locale: nil, search: "Micro", active: true) { (result:TickersQueryResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
                print(result?.tickers)
            }
        }*/
        
        // Fetch Aggregates (Candle Data)
        
        /*polygon.aggregates(ticker: "APPL", multiplier: 1, timespan: .day, from: "2020-08-09", to: "2020-09-09") { (result:AggregatesResponse?, err) in
            // check if we got any errors
            if let err = err {
                print(err)
            } else {
                print(result)
                print(result?.results)
            }
        }*/
    }
    
    
}

