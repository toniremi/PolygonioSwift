import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(TickerQueryTests.allTests),
        testCase(MarketsTests.allTests),
        testCase(MarketStatusTests.allTests),
        testCase(MarketHolidaysTests.allTests),
        testCase(LocalesTests.allTests),
        testCase(StockFinancialsTests.allTests),
        testCase(TickerDetailsTests.allTests),
        testCase(TickerNewsTests.allTests),
        testCase(TickerTypesTests.allTests),
        testCase(AggregatesTests.allTests),
        testCase(DailyOpenCloseTests.allTests),
        testCase(TickerSnapshotTests.allTests),
        testCase(AllTickersSnapshotTests.allTests),
    ]
}
#endif
