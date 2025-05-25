//
//  OptionsContractTests.swift
//  PolygonioSwift
//
//  Created by Antoni Remeseiro Alfonso on 2025/05/25.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class OptionsContractTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(OptionsContractResponse.self, path: "Reference/options_contract.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
