//
//  TimeSeriesTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class TickerDetailsTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingAgregates() {
    let rs = try? loader.loadJSON(TickerDetailsResponse.self, path: "ticker_details_AAPL.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingAgregates),
  ]
}
