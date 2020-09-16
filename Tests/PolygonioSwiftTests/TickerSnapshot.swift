//
//  TickerSnapshot.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/16/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class TickerSnapshotTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingAgregates() {
    let rs = try? loader.loadJSON(TickerSnapshotResponse.self, path: "ticker_snapshot_AAPL.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingAgregates),
  ]
}
