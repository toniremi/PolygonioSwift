//
//  APIKeyInterceptor.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/29.
//
import Foundation
import OpenAPIRuntime
import OpenAPIURLSession
import HTTPTypes

struct APIKeyInterceptor: ClientMiddleware {
    let apiKey: String

    func intercept(
            _ request: HTTPRequest,
            body: HTTPBody?,
            baseURL: URL,
            operationID: String,
            next: (HTTPRequest, HTTPBody?, URL) async throws -> (HTTPResponse, HTTPBody?)
    ) async throws -> (HTTPResponse, HTTPBody?) {
        // 1. Construct the full URL that the request *would* normally go to
        // This is crucial because HTTPRequest.path only has the path, not host/scheme
        // We need baseURL to correctly build the URL for URLComponents.
        let fullURLString = baseURL.absoluteString + (request.path ?? "")
        
        // 2. Use URLComponents to parse and modify the URL
        guard var urlComponents = URLComponents(string: fullURLString) else {
            // If the URL is invalid, we can't inject. Propagate the original request.
            print("Error: Could not create URLComponents from \(fullURLString)")
            return try await next(request, body, baseURL)
        }

        // 3. Create the API key query item
        let apiKeyQueryItem = URLQueryItem(name: "apiKey", value: apiKey)

        // 4. Add the API key query item to existing query items or create a new array
        if urlComponents.queryItems == nil {
            urlComponents.queryItems = [apiKeyQueryItem]
        } else {
            // Check if the API key parameter already exists to avoid duplicates
            if !(urlComponents.queryItems?.contains(where: { $0.name == "apiKey" }) ?? false) {
                urlComponents.queryItems?.append(apiKeyQueryItem)
            }
        }

        // 5. Get the modified URL's path with the query string
        guard let modifiedPathWithQuery = urlComponents.url?.absoluteString.replacingOccurrences(of: baseURL.absoluteString, with: "") else {
             print("Error: Could not get modified path with query from URLComponents.")
            return try await next(request, body, baseURL)
        }
        
        // 6. Create a mutable copy of the original request
        var modifiedRequest = request
        
        // 7. Update the path of the HTTPRequest
        modifiedRequest.path = modifiedPathWithQuery
        
        print("Original Path: \(request.path)")
        print("Modified Path: \(modifiedRequest.path)") // This will now include the query string

        // 8. Pass the modified request to the next middleware or the client
        return try await next(modifiedRequest, body, baseURL)
    }
}
