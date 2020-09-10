//
//  SymbolSearchTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class TickerQueryTests: XCTestCase {
  let loader = Loader()

  func testDecoding() {
    let rs = try? loader.loadJSON(TickersQueryResponse.self, path: "ticker_query_results.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
    ("testDecoding", testDecoding),
  ]
}
