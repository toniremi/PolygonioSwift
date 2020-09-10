//
//  PolygonSwiftError.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/10/20.
//

import Foundation

public struct PolygonSwiftError: LocalizedError
{
    let message: String

    init(_ message: String)
    {
        self.message = message
    }

    public var errorDescription: String?
    {
        return message
    }
}
