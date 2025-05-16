//
//  MarketStatusTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/14/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class MarketStatusTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(MarketStatusResponse.self, path: "market_status.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
