//
//  Loader.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

import Foundation

public class Loader {
  private var baseURL: URL

  public init() {
    let thisFile = URL(fileURLWithPath: #file)
    let thisDir = thisFile.deletingLastPathComponent()
    baseURL = thisDir.appendingPathComponent("data")
  }

  public func load(path: String) throws -> Data {
    let fileURL = URL(string: path, relativeTo: baseURL)
    let data = try Data(contentsOf: fileURL!)
    return data
  }

  public func loadJSON<T>(_ type: T.Type, path: String) throws -> T where T: Decodable {
    let decoder = JSONDecoder()
    let data = try load(path: path)
    return try decoder.decode(type, from: data)
  }
}
