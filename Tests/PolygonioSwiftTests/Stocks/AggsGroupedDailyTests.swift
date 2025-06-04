//
//  AggsGroupedDailyTests.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/06/04.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class AggsGroupedDailyTests: XCTestCase {
    let loader = Loader()
    
    func testDecodingResponse() {
        do {
            let rs = try? loader.loadJSON(AggsGroupedDailyResponse.self, path: "Stocks/aggregates_grouped_daily.json")
            XCTAssertNotNil(rs)
        } catch let error as DecodingError {
            XCTFail("Decoding failed with error: \(error)") // Catch specific decoding errors
        } catch {
            XCTFail("An unexpected error occurred: \(error)") // Catch any other errors
        }
    }
    
    static var allTests = [
        ("testDecoding", testDecodingResponse),
    ]
}
