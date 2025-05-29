//
//  PolygonClient.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/28.
//

import Foundation
import OpenAPIRuntime
import OpenAPIURLSession

// MARK: - PolygonioSwift (Main Singleton Client)

public class PolygonioSwift {
    // The generated client from Swift OpenAPI Generator
    public let client: Client
    internal let apiKey: String // Keep API key here
    internal let serverURL: URL

    // Debug flag for extra info
    public var debug = false

    // Static shared instance for easy access
    // IMPORTANT: You MUST call `PolygonioSwift.configure(apiKey: "YOUR_KEY")`
    // before using the shared instance for the first time.
    public static var shared = PolygonioSwift() // Initialize without API Key initially

    // Private initializer to enforce configuration via 'configure'
    private init() {
        // Dummy client for initial setup, will be replaced by configure
        self.apiKey = ""
        self.serverURL = URL(string: "https://api.polygon.io")!
        self.client = Client(serverURL: self.serverURL, transport: URLSessionTransport())
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
        self.client = Client(serverURL: serverURL, transport: URLSessionTransport(), middlewares: [APIKeyInterceptor(apiKey: apiKey)])
    }

    // Allows setting a debug flag to print extra info or not
    public func setDebug(enable: Bool) {
        self.debug = enable
    }
}

