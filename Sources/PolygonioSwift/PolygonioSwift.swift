//
//  PolygonClient.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/28.
//
import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

// Import our Auto Generated Clients
import PolygonioCryptoClient
import PolygonioStocksClient
import PolygonioOptionsClient
import PolygonioReferenceClient
import PolygonioForexClient
import PolygonioIndicesClient

// MARK: - PolygonioSwift (Main Singleton Client)

public class PolygonioSwift {
    internal let apiKey: String // Keep API key here
    internal let serverURL: URL
    
    // Initialize each client instance
    public let cryptoClient: PolygonioCryptoClient.Client
    public let stockClient: PolygonioStocksClient.Client
    public let optionsClient: PolygonioOptionsClient.Client
    public let referenceClient: PolygonioReferenceClient.Client
    public let forexClient: PolygonioForexClient.Client
    public let indicesClient: PolygonioIndicesClient.Client

    // Static shared instance for easy access
    // IMPORTANT: You MUST call `PolygonioSwift.configure(apiKey: "YOUR_KEY")`
    // before using the shared instance for the first time.
    public static var shared = PolygonioSwift() // Initialize without API Key initially

    // Private initializer to enforce configuration via 'configure'
    private init() {
        // Dummy client for initial setup, will be replaced by configure
        self.apiKey = ""
        self.serverURL = URL(string: "https://api.polygon.io")!
        // create our transport for our clients
        let transport = URLSessionTransport()
        // create our middle ware so we can inject the api key into the url
        let middleware = APIKeyInterceptor(apiKey: self.apiKey)
        // Initialie all of our separated clients
        self.cryptoClient = PolygonioCryptoClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.stockClient = PolygonioStocksClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.optionsClient = PolygonioOptionsClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.referenceClient = PolygonioReferenceClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.forexClient = PolygonioForexClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.indicesClient = PolygonioIndicesClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
    }

    /// Configure the shared instance of PolygonioSwift with your API Key and optional server URL.
    /// This MUST be called once at your app's startup before accessing `PolygonioSwift.shared`.
    public static func configure(apiKey: String, serverURL: URL = URL(string: "https://api.polygon.io")!) {
        // Re-assign the shared instance with proper configuration
        PolygonioSwift.shared = PolygonioSwift(apiKey: apiKey, serverURL: serverURL)
    }

    // Actual initializer called by configure
    private init(apiKey: String, serverURL: URL) {
        self.apiKey = apiKey
        self.serverURL = serverURL
        // create our transport for our clients
        let transport = URLSessionTransport()
        // create our middle ware so we can inject the api key into the url
        let middleware = APIKeyInterceptor(apiKey: self.apiKey)
        // Initialie all of our separated clients
        self.cryptoClient = PolygonioCryptoClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.stockClient = PolygonioStocksClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.optionsClient = PolygonioOptionsClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.referenceClient = PolygonioReferenceClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.forexClient = PolygonioForexClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
        self.indicesClient = PolygonioIndicesClient.Client(serverURL: self.serverURL,transport: transport,middlewares: [middleware])
    }
}

