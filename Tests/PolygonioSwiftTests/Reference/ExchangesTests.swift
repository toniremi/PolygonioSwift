//
//  ExchangesTest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class ExchangesTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(ExchangesResponse.self, path: "Reference/exchanges.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
