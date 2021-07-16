//
//  StockDividends.swift
//
//
//  Created by Antoni Remeseiro Alfonso on 9/14/20.
//

import Foundation

public struct StockFinancialsRequest : ApiRequest {
    typealias Response = StockFinancialsResponse
    
    var symbol:String
    var limit: Int
    var type: FinancialType?
    
    var path: String {
        return "/v2/reference/financials/\(symbol)"
    }
    
    var queryItems: [URLQueryItem] {
        // add here the parameters if we have a value
        var parameters: [URLQueryItem] = []
        
        // always will have limit otherwise the response is huge
        parameters.append(URLQueryItem(name: "limit", value: String(limit)))
        
        // if a type is passed include it in the query
        if type != nil {
            parameters.append(URLQueryItem(name: "type", value: type?.rawValue))
        }
        
        return parameters
    }
}

public struct StockFinancialsResponse : Decodable {
    
    public var status: String
    public var results: [FinancialsInfo]
    
    private enum CodingKeys: String, CodingKey {
        case status = "status"
        case results = "results"
    }
    
    public struct FinancialsInfo : Codable {
        public var ticker : String?
        public var period : String
        public var calendarDate : String
        public var reportPeriod : String
        public var updated : String
        public var dateKey : String
        public var accumulatedOtherComprehensiveIncome : Int
        public var assets : Int
        public var assetsCurrent : Int
        public var assetsNonCurrent : Int
        public var bookValuePerShare : Decimal
        public var capitalExpenditure : Int
        public var cashAndEquivalents : Int
        public var cashAndEquivalentsUSD : Int
        public var costOfRevenue : Int
        public var consolidatedIncome : Int
        public var currentRatio : Decimal
        public var debtToEquityRatio : Decimal
        public var debt : Int
        public var debtCurrent : Int
        public var debtNonCurrent : Int
        public var debtUSD : Int
        public var deferredRevenue : Int
        public var depreciationAmortizationAndAccretion : Int
        public var deposits : Int
        public var dividendYield : Decimal
        public var dividendsPerBasicCommonShare : Decimal
        public var earningBeforeInterestTaxes : Int
        public var earningsBeforeInterestTaxesDepreciationAmortization : Int
        public var EBITDAMargin : Decimal
        public var earningsBeforeInterestTaxesDepreciationAmortizationUSD : Int
        public var earningBeforeInterestTaxesUSD : Int
        public var earningsBeforeTax : Int
        public var earningsPerBasicShare : Decimal
        public var earningsPerDilutedShare : Decimal
        public var earningsPerBasicShareUSD : Decimal
        public var shareholdersEquity : Int
        public var shareholdersEquityUSD : Int
        public var enterpriseValue : Int
        public var enterpriseValueOverEBIT : Int
        public var enterpriseValueOverEBITDA : Decimal
        public var freeCashFlow : Int
        public var freeCashFlowPerShare : Decimal
        public var foreignCurrencyUSDExchangeRate : Int
        public var grossProfit : Int
        public var grossMargin : Decimal
        public var goodwillAndIntangibleAssets : Int
        public var interestExpense : Int
        public var investedCapital : Int
        public var inventory : Int
        public var investments : Int
        public var investmentsCurrent : Int
        public var investmentsNonCurrent : Int
        public var totalLiabilities : Int
        public var currentLiabilities : Int
        public var liabilitiesNonCurrent : Int
        public var marketCapitalization : Int
        public var netCashFlow : Int
        public var netCashFlowBusinessAcquisitionsDisposals : Int
        public var issuanceEquityShares : Int
        public var issuanceDebtSecurities : Int
        public var paymentDividendsOtherCashDistributions : Int
        public var netCashFlowFromFinancing : Int
        public var netCashFlowFromInvesting : Int
        public var netCashFlowInvestmentAcquisitionsDisposals : Int
        public var netCashFlowFromOperations : Int
        public var effectOfExchangeRateChangesOnCash : Int
        public var netIncome : Int
        public var netIncomeCommonStock : Int
        public var netIncomeCommonStockUSD : Int
        public var netLossIncomeFromDiscontinuedOperations : Int
        public var netIncomeToNonControllingInterests : Int
        public var profitMargin : Decimal
        public var operatingExpenses : Int
        public var operatingIncome : Int
        public var tradeAndNonTradePayables : Int
        public var payoutRatio : Decimal
        public var priceToBookValue : Decimal
        public var priceEarnings : Decimal
        public var priceToEarningsRatio : Decimal
        public var propertyPlantEquipmentNet : Int
        public var preferredDividendsIncomeStatementImpact : Int
        public var sharePriceAdjustedClose : Decimal
        public var priceSales : Decimal
        public var priceToSalesRatio : Decimal
        public var tradeAndNonTradeReceivables : Int
        public var accumulatedRetainedEarningsDeficit : Int
        public var revenues : Int
        public var revenuesUSD : Int
        public var researchAndDevelopmentExpense : Int
        public var shareBasedCompensation : Int
        public var sellingGeneralAndAdministrativeExpense : Int
        public var shareFactor : Int
        public var shares : Int
        public var weightedAverageShares : Int
        public var weightedAverageSharesDiluted : Int
        public var salesPerShare : Decimal
        public var tangibleAssetValue : Int
        public var taxAssets : Int
        public var incomeTaxExpense : Int
        public var taxLiabilities : Int
        public var tangibleAssetsBookValuePerShare : Decimal
        public var workingCapital : Int
        
        private enum CodingKeys: String, CodingKey {
            case ticker = "ticker"
            case period = "period"
            case calendarDate = "calendarDate"
            case reportPeriod = "reportPeriod"
            case updated = "updated"
            case dateKey = "dateKey"
            case accumulatedOtherComprehensiveIncome = "accumulatedOtherComprehensiveIncome"
            case assets = "assets"
            case assetsCurrent = "assetsCurrent"
            case assetsNonCurrent = "assetsNonCurrent"
            case bookValuePerShare = "bookValuePerShare"
            case capitalExpenditure = "capitalExpenditure"
            case cashAndEquivalents = "cashAndEquivalents"
            case cashAndEquivalentsUSD = "cashAndEquivalentsUSD"
            case costOfRevenue = "costOfRevenue"
            case consolidatedIncome = "consolidatedIncome"
            case currentRatio = "currentRatio"
            case debtToEquityRatio = "debtToEquityRatio"
            case debt = "debt"
            case debtCurrent = "debtCurrent"
            case debtNonCurrent = "debtNonCurrent"
            case debtUSD = "debtUSD"
            case deferredRevenue = "deferredRevenue"
            case depreciationAmortizationAndAccretion = "depreciationAmortizationAndAccretion"
            case deposits = "deposits"
            case dividendYield = "dividendYield"
            case dividendsPerBasicCommonShare = "dividendsPerBasicCommonShare"
            case earningBeforeInterestTaxes = "earningBeforeInterestTaxes"
            case earningsBeforeInterestTaxesDepreciationAmortization = "earningsBeforeInterestTaxesDepreciationAmortization"
            case EBITDAMargin = "EBITDAMargin"
            case earningsBeforeInterestTaxesDepreciationAmortizationUSD = "earningsBeforeInterestTaxesDepreciationAmortizationUSD"
            case earningBeforeInterestTaxesUSD = "earningBeforeInterestTaxesUSD"
            case earningsBeforeTax = "earningsBeforeTax"
            case earningsPerBasicShare = "earningsPerBasicShare"
            case earningsPerDilutedShare = "earningsPerDilutedShare"
            case earningsPerBasicShareUSD = "earningsPerBasicShareUSD"
            case shareholdersEquity = "shareholdersEquity"
            case shareholdersEquityUSD = "shareholdersEquityUSD"
            case enterpriseValue = "enterpriseValue"
            case enterpriseValueOverEBIT = "enterpriseValueOverEBIT"
            case enterpriseValueOverEBITDA = "enterpriseValueOverEBITDA"
            case freeCashFlow = "freeCashFlow"
            case freeCashFlowPerShare = "freeCashFlowPerShare"
            case foreignCurrencyUSDExchangeRate = "foreignCurrencyUSDExchangeRate"
            case grossProfit = "grossProfit"
            case grossMargin = "grossMargin"
            case goodwillAndIntangibleAssets = "goodwillAndIntangibleAssets"
            case interestExpense = "interestExpense"
            case investedCapital = "investedCapital"
            case inventory = "inventory"
            case investments = "investments"
            case investmentsCurrent = "investmentsCurrent"
            case investmentsNonCurrent = "investmentsNonCurrent"
            case totalLiabilities = "totalLiabilities"
            case currentLiabilities = "currentLiabilities"
            case liabilitiesNonCurrent = "liabilitiesNonCurrent"
            case marketCapitalization = "marketCapitalization"
            case netCashFlow = "netCashFlow"
            case netCashFlowBusinessAcquisitionsDisposals = "netCashFlowBusinessAcquisitionsDisposals"
            case issuanceEquityShares = "issuanceEquityShares"
            case issuanceDebtSecurities = "issuanceDebtSecurities"
            case paymentDividendsOtherCashDistributions = "paymentDividendsOtherCashDistributions"
            case netCashFlowFromFinancing = "netCashFlowFromFinancing"
            case netCashFlowFromInvesting = "netCashFlowFromInvesting"
            case netCashFlowInvestmentAcquisitionsDisposals = "netCashFlowInvestmentAcquisitionsDisposals"
            case netCashFlowFromOperations = "netCashFlowFromOperations"
            case effectOfExchangeRateChangesOnCash = "effectOfExchangeRateChangesOnCash"
            case netIncome = "netIncome"
            case netIncomeCommonStock = "netIncomeCommonStock"
            case netIncomeCommonStockUSD = "netIncomeCommonStockUSD"
            case netLossIncomeFromDiscontinuedOperations = "netLossIncomeFromDiscontinuedOperations"
            case netIncomeToNonControllingInterests = "netIncomeToNonControllingInterests"
            case profitMargin = "profitMargin"
            case operatingExpenses = "operatingExpenses"
            case operatingIncome = "operatingIncome"
            case tradeAndNonTradePayables = "tradeAndNonTradePayables"
            case payoutRatio = "payoutRatio"
            case priceToBookValue = "priceToBookValue"
            case priceEarnings = "priceEarnings"
            case priceToEarningsRatio = "priceToEarningsRatio"
            case propertyPlantEquipmentNet = "propertyPlantEquipmentNet"
            case preferredDividendsIncomeStatementImpact = "preferredDividendsIncomeStatementImpact"
            case sharePriceAdjustedClose = "sharePriceAdjustedClose"
            case priceSales = "priceSales"
            case priceToSalesRatio = "priceToSalesRatio"
            case tradeAndNonTradeReceivables = "tradeAndNonTradeReceivables"
            case accumulatedRetainedEarningsDeficit = "accumulatedRetainedEarningsDeficit"
            case revenues = "revenues"
            case revenuesUSD = "revenuesUSD"
            case researchAndDevelopmentExpense = "researchAndDevelopmentExpense"
            case shareBasedCompensation = "shareBasedCompensation"
            case sellingGeneralAndAdministrativeExpense = "sellingGeneralAndAdministrativeExpense"
            case shareFactor = "shareFactor"
            case shares = "shares"
            case weightedAverageShares = "weightedAverageShares"
            case weightedAverageSharesDiluted = "weightedAverageSharesDiluted"
            case salesPerShare = "salesPerShare"
            case tangibleAssetValue = "tangibleAssetValue"
            case taxAssets = "taxAssets"
            case incomeTaxExpense = "incomeTaxExpense"
            case taxLiabilities = "taxLiabilities"
            case tangibleAssetsBookValuePerShare = "tangibleAssetsBookValuePerShare"
            case workingCapital = "workingCapital"
        }
    }
}
