//
//  AllTickersSnapshot.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/16/20.
//

import XCTest
import TestResources
@testable import PolygonioSwift

final class AllTickersSnapshotTests: XCTestCase {
  let loader = Loader()
    
  func testDecodingResponse() {
    let rs = try? loader.loadJSON(AllTickersSnapshotResponse.self, path: "all_tickers_snapshot.json")
    XCTAssertNotNil(rs)
  }

  static var allTests = [
      ("testDecoding", testDecodingResponse),
  ]
}
