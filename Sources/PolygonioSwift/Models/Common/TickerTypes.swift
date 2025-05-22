//
//  TickerTypes.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/22.
//

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
