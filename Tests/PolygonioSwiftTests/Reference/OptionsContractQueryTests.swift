//
//  OptionsContractQueryTests.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class OptionsContractQueryTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(OptionsContractQueryResponse.self, path: "Reference/options_contract_query.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
