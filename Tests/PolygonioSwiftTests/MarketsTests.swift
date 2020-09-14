//
//  MarketsTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/14/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class MarketsTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingAgregates() {
    let rs = try? loader.loadJSON(MarketsResponse.self, path: "markets.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingAgregates),
  ]
}
