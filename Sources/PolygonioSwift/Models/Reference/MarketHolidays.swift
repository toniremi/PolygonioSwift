//
//  Markets.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import Foundation

public struct MarketHolidaysRequest : ApiRequest {
    typealias Response = MarketHolidaysResponse
    
    var path: String {
        return "/v1/marketstatus/upcoming"
    }
    
    var queryItems: [URLQueryItem] {
        return []
    }
}

public struct MarketHolidaysResponse : Decodable {
    
        public var exchange: String
        public var name: String
        public var date: String
        public var status: String
        public var open: String?
        public var close: String?
        
        private enum CodingKeys: String, CodingKey {
            case exchange = "exchange"
            case name = "name"
            case date = "date"
            case status = "status"
            case open = "open"
            case close = "close"
        }
   
}
