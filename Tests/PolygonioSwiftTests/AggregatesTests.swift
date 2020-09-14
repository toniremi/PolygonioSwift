//
//  AggregatesTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class AggregatesTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingAgregates() {
    let rs = try? loader.loadJSON(AggregatesResponse.self, path: "aggregates_AAPL_daily.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingAgregates),
  ]
}
