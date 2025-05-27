//
//  LastTradeResponse.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/27.
//
import Foundation

public struct LastTradeResponse: Decodable {
    public let requestId: String?
    public let status: String
    public let results: LastTradeInfo?

    private enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case status
        case results
    }
    
    public struct LastTradeInfo: Decodable {
        // The exchange symbol that this item is traded under.
        public let T: String?
        // The nanosecond accuracy TRF(Trade Reporting Facility) Unix Timestamp.
        //This is the timestamp of when the trade reporting facility received this message.
        public let f: Int?
        // The sequence number represents the sequence in which message events happened.
        // These are increasing and unique per ticker symbol, but will not always be sequential (e.g., 1, 2, 6, 9, 10, 11).
        public let q: Int? // Sequence Number
        // The nanosecond accuracy SIP Unix Timestamp.
        // This is the timestamp of when the SIP received this message from the exchange which produced it.
        public let t: Int?
        // The nanosecond accuracy Participant/Exchange Unix Timestamp.
        // This is the timestamp of when the quote was actually generated at the exchange.
        public let y: Int? // TRF (Trade ReportingFacility) ID
        // A list of condition codes.
        public let c: [Int]?
        // The trade correction indicator.
        public let e: Int?
        // The Trade ID which uniquely identifies a trade.
        // These are unique per combination of ticker, exchange, and TRF.
        // For example: A trade for AAPL executed on NYSE and a trade for AAPL executed on NASDAQ could potentially have the same Trade ID.
        public let i: String? // Trade ID
        // The price of the trade. This is the actual dollar value per whole share of this trade.
        // A trade of 100 shares with a price of $2.00 would be worth a total dollar value of $200.00.
        public let p: Double?
        // The ID for the Trade Reporting Facility where the trade took place.
        public let r: Int?
        // The size of a trade (also known as volume).
        public let s: Double?
        // The exchange ID.
        public let x: Int?
        // There are 3 tapes which define which exchange the ticker is listed on.
        // These are integers in our objects which represent the letter of the alphabet.
        // Eg: 1 = A, 2 = B, 3 = C. * Tape A is NYSE listed securities * Tape B is NYSE ARCA / NYSE American * Tape C is NASDAQ
        public let z: Int?
        public let P: Double? // Price (Alternate field for tape B consolidated last)
        public let S: Double? // Size (Alternate field for tape B consolidated last)
        public let X: Int?    // Exchange (Alternate field for tape B consolidated last)
    }
}
