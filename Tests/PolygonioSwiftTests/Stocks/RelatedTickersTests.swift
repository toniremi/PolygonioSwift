//
//  RelatedTickersTests.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/27.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class RelatedTickersTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(RelatedTickersResponse.self, path: "Stocks/related_tickers_AAPL.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
