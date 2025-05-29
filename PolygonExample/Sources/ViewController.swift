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
        
        // call configure to setup our PolygonLibrary with the correct api key
        PolygonioSwift.configure(apiKey: apiKey)
        
        Task.init(operation: {
            do {
                let response = try await makeRequests()
                print("API Response: \(response)")
            } catch {
                print("Error making API request: \(error)")
                // You might want to display an alert to the user here
            }
        })
    }
    
    func makeRequests() async throws -> Operations.GetStocksAggregates.Output.Ok.Body.jsonPayload {
        let response = try await PolygonioSwift.shared.client.GetStocksAggregates(.init(path: Operations.GetStocksAggregates.Input.Path.init(stocksTicker: "AAPL", multiplier: 1, timespan: Operations.GetStocksAggregates.Input.Path.timespanPayload.day, from: "2024-05-29", to: "2025-05-29")))
        return try response.ok.body.json
    }
}

