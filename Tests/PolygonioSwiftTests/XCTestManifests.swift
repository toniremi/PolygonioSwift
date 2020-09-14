import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AggregatesTests.allTests),
        testCase(TickerQueryTests.allTests),
        testCase(MarketsTests.allTests),
        testCase(LocalesTests.allTests),
        testCase(StockFinancialsTests.allTests),
        testCase(TickerDetailsTests.allTests),
        testCase(TickerNewsTests.allTests),
        testCase(TickerTypesTests.allTests),
    ]
}
#endif
