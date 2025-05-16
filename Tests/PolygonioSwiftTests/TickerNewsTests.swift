//
//  TickerNewsTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/11/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class TickerNewsTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON([TickerNewsResponse].self, path: "ticker_news_AAPL.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
