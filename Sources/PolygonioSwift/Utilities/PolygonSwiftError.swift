//
//  PolygonSwiftError.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/10/20.
//

import Foundation

public struct PolygonSwiftError: Error {
    public let message: String
    public let requestId: String?
    public let status: String?
    // You can add the underlying error if needed
    // public let underlyingError: Error?

    public init(message: String, requestId: String? = nil, status: String? = nil) {
        self.message = message
        self.requestId = requestId
        self.status = status
    }

    public var localizedDescription: String {
        return "PolygonSwiftError: \(message)" +
               (requestId != nil ? " (Request ID: \(requestId!))" : "") +
               (status != nil ? " (Status: \(status!))" : "")
    }
}


