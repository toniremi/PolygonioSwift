//
//  ConditionsTest.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/24.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class ConditionsTest: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(ConditionsResponse.self, path: "conditions.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
