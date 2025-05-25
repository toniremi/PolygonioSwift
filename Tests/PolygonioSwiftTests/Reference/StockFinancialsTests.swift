//
//  StockFinancialsTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/14/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class StockFinancialsTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(StockFinancialsResponse.self, path: "stock_financials_AAPL.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
