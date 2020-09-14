//
//  LocalesTests.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/14/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class LocalesTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingAgregates() {
    let rs = try? loader.loadJSON(LocalesResponse.self, path: "locales.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingAgregates),
  ]
}
