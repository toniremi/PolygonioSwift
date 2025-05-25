//
//  TickerOverview.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/16.
//

import Foundation

public struct TickerOverviewResponse: Decodable {
    let requestId: String?
    let results: TickerOverviewResults?
    let status: String?
    
    enum CodingKeys: String, CodingKey {
        case requestId = "request_id"
        case results
        case status
    }
    
    struct TickerOverviewResults: Decodable {
        let active: Bool?
        let address: Address?
        let branding: Branding?
        let cik: String?
        let compositeFigi: String?
        let currencyName: String?
        let description: String?
        let homepageUrl: String?
        let listDate: String?
        let locale: String?
        let market: String?
        let marketCap: Double?
        let name: String?
        let phoneNumber: String?
        let primaryExchange: String?
        let roundLot: Int?
        let shareClassFigi: String?
        let shareClassSharesOutstanding: Double?
        let sicCode: String?
        let sicDescription: String?
        let ticker: String?
        let tickerRoot: String?
        let totalEmployees: Int?
        let type: String?
        let weightedSharesOutstanding: Double?
        let sourceFeed: String?
        
        enum CodingKeys: String, CodingKey {
            case active
            case address
            case branding
            case cik
            case compositeFigi = "composite_figi"
            case currencyName = "currency_name"
            case description
            case homepageUrl = "homepage_url"
            case listDate = "list_date"
            case locale
            case market
            case marketCap = "market_cap"
            case name
            case phoneNumber = "phone_number"
            case primaryExchange = "primary_exchange"
            case roundLot = "round_lot"
            case shareClassFigi = "share_class_figi"
            case shareClassSharesOutstanding = "share_class_shares_outstanding"
            case sicCode = "sic_code"
            case sicDescription = "sic_description"
            case ticker
            case tickerRoot = "ticker_root"
            case totalEmployees = "total_employees"
            case type
            case weightedSharesOutstanding = "weighted_shares_outstanding"
            case sourceFeed = "source_feed"
        }
    }
    
    struct Address: Decodable {
        let address1: String?
        let city: String?
        let state: String?
        let postalCode: String?
        
        enum CodingKeys: String, CodingKey {
            case address1
            case city
            case state
            case postalCode = "postal_code"
        }
    }
    
    struct Branding: Decodable {
        let iconUrl: String?
        let logoUrl: String?
        
        enum CodingKeys: String, CodingKey {
            case iconUrl = "icon_url"
            case logoUrl = "logo_url"
        }
    }
}
