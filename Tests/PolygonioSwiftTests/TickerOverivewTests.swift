//
//  TickerOverivewTests.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/16.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class TickerOverviewTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(TickerOverviewResponse.self, path: "ticker_details_AAPL.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
