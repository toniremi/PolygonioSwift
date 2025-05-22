//
//  StockClient.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

fileprivate let baseURLString = "https://api.polygon.io"

public class PolygonioSwift {
    let session: URLSession
    var builder: URLBuilder
    
    // debug so we can see extra info
    var debug = false
    
    // Static shared instance for easy access
    public static var shared = PolygonioSwift(key: "")
    
    public init(key: String) {
        let components = URLComponents(string: baseURLString)!
        session = URLSession(configuration: .default)
        builder = URLBuilder(components: components, secret: key)
    }
    
    // If you want to set the API key after initialization
    public func configure(apiKey: String) {
        // Re-initialize builder or update its secret.
        // For simplicity, assuming it's set at init or this recreates the builder.
        let components = URLComponents(string: baseURLString)!
        self.builder = URLBuilder(components: components, secret: apiKey)
    }
    
    // to allow setting a debug to print extra info or not
    public func setDebug(enable: Bool) {
        self.debug = enable
    }
    
    // Generic network dispatch method
    // This significantly reduces boilerplate in sub-clients
    internal func dispatch<Request: ApiRequest>(
        request: Request,
        completion: @escaping (Result<Request.Response, PolygonSwiftError>) -> Void
    ) {
        let url = builder.buildURL(request)
        
        if self.debug {
            print("Request URL: \(url.absoluteURL)")
        }
        
        let task = session.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(.failure(PolygonSwiftError(message: error?.localizedDescription ?? "No data received.")))
                return
            }
            
            // Debug raw JSON
            if self.debug {
                if let jsonString = String(data: data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
            }
            
            do {
                let decodedResponse = try JSONDecoder().decode(Request.Response.self, from: data)
                completion(.success(decodedResponse))
            } catch {
                if self.debug {
                    print("Decoding error: \(String(describing: error)) for URL: \(url.absoluteString)")
                    if let jsonString = String(data: data, encoding: .utf8) {
                        print("Failed to decode JSON: \(jsonString)")
                    }
                }
                if let polygonError = try? JSONDecoder().decode(PolygonErrorResponse.self, from: data) {
                    completion(.failure(PolygonSwiftError(message: polygonError.error, requestId: polygonError.request_id, status: polygonError.status)))
                } else {
                    completion(.failure(PolygonSwiftError(message: "Decoding error: \(error.localizedDescription)")))
                }
            }
        }
        task.resume()
    }
    
    // MARK: - Service Clients
    public lazy var stocks: StocksClient = StocksClient(polygonswift: self)
    // public lazy var crypto: CryptoClient = CryptoClient(polygonswift: self)
    // public lazy var forex: ForexClient = ForexClient(polygonswift: self)
    // public lazy var options: OptionsClient = OptionsClient(polygonswift: self)
    // public lazy var indices: IndicesClient = IndicesClient(polygonswift: self)
    // public lazy var reference: ReferenceClient = ReferenceClient(polygonswift: self)
    
}
