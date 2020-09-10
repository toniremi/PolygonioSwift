import XCTest

#if !canImport(ObjectiveC)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(AggregatesTests.allTests),
        testCase(TickerQueryTests.allTests),
    ]
}
#endif
