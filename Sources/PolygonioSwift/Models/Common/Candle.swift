//
//  Candle.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/06/04.
//
import Foundation

public struct Candle : Codable {
    public var ticker: String? // grouped daily includes ticker
    public var volume: Decimal
    public var VWAP: Decimal? //VWAP (Volume Weighted Average Price) Optional.
    public var open: Decimal
    public var close: Decimal
    public var high: Decimal
    public var low: Decimal
    public var timestamp: Int
    public var n: Int?
    
    private enum CodingKeys: String, CodingKey {
        case ticker = "T"
        case volume = "v"
        case VWAP = "vw"
        case open = "o"
        case close = "c"
        case high = "h"
        case low = "l"
        case timestamp = "t"
        case n = "n"
    }
}
