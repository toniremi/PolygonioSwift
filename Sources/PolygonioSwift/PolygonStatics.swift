//
//  PolygonStatics.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 7/16/21.
//

import Foundation

// time span enum
public enum TimeSpan: String {
    case minute = "minute"
    case hour = "hour"
    case day = "day"
    case week = "week"
    case month = "month"
    case quarter = "quarter"
    case year = "year"
}

// sorting enum
public enum Sorting: String {
    case ascending = "asc"
    case descending = "desc"
}

// order enum
public enum Order: String {
    case ascending = "asc"
    case descending = "desc"
}

// ticker sorting
public enum TickerSorting: String {
    case ticker = "ticker"
    case name = "name"
    case market = "market"
    case locale = "locale"
    case type = "type"
    case primaryExch = "primary_exchange"
    case active = "active"
    case currency = "currency_name"
    case cik = "cik"
    case composite_figi = "composite_figi"
    case share_class_figi = "share_class_figi"
    case last_updated_utc = "last_updated_utc"
}

// Can see this by checking https://api.polygon.io/v2/reference/types
public enum TickerTypes: String {
    // Stock Types
    case CommonStock = "CS"
    case Bond = "BOND"
    case Baslet = "Basket"
    case AmericanDepositoryReceiptCommon = "ADRC"
    case AmericanDepositoryReceiptPreferred = "ADRP"
    case AmericanDepositoryReceiptWarrant = "ADRW"
    case AmericanDepositoryReceiptRight = "ADRR"
    case NonVotingDepositoryReceipt = "NVDR"
    case GlobalDepositaryReceipt = "GDR"
    case SpecialDrawingRight = "SDR"
    case ClosedEndFund = "CEF"
    case ExchangeTradedProduct_Fund = "ETP"
    case RealEstateInvestmentTrust = "REIT"
    case MasterLimitedPartnership = "MLP"
    case EquityWRT = "WRT"
    case Public = "PUB"
    case NewYorkRegistryShares = "NYRS"
    case Unit = "UNIT"
    case Right = "RIGHT"
    case TrackingStockOrTargetedStock = "TRAK"
    case LimitedPartnership = "LTDP"
    case RoyaltyTrust = "RYLT"
    case MutualFund = "MF"
    case PreferredStock = "PFD"
    case ForeignOrdinaryShares = "FDR"
    case OtherSecurityType = "OST"
    case Fund = "FUND"
    case StructuredProduct = "SP"
    case SecondaryIssue = "SI"
    case Warrant = "WARRANT"

    // Index Types
    case Index = "INDEX"
    case ExchangeTradedFund = "ETF"
    case ExchangeTradedNote = "ETN"
    case ExchangeTradedManagedFund = "ETMF"
    case Settlement = "SETTLEMENT"
    case Spot = "SPOT"
    case SubordinatedProduct = "SUBPROD"
    case WorldCurrency = "WC"
    case AlphaIndex = "ALPHAINDEX"
}

// Can see this by checking https://polygon.io/docs/get_v3_reference_tickers_anchor
public enum MarketOptions: String {
    case Stocks = "stocks"
    case Crypto = "crypto"
    case Forex = "fx"
}

// Can see this by checking https://api.polygon.io/v2/reference/locales
public enum Locale: String {
    case global = "G"
    case UnitedStates = "US"
    case GreatBritain = "GB"
    case Canada = "CA"
    case Netherlands = "NL"
    case Greece = "GR"
    case Spain = "SP"
    case Germany = "DE"
    case Belgium = "BE"
    case Denmark = "DK"
    case Finland = "FI"
    case Ireland = "IE"
    case Portugal = "PT"
    case India = "IN"
    case Mexico = "MX"
    case France = "FR"
    case China = "CN"
    case Switzerland = "CH"
    case Sweden = "SE"
}

// Financial Types Enum
public enum FinancialType: String {
    case Year = "Y"
    case YearAnnualized = "YA"
    case Quarter = "Q"
    case QuarterAnnualied = "QA"
    case Trailing12Months = "T"
    case Trailing12MonthsAnnualized = "TA"
}
