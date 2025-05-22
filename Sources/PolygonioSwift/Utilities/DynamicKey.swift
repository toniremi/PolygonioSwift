//
//  DynamicKey.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

struct DynamicKey: CodingKey {
  var stringValue: String
  var intValue: Int? = nil
  
  init?(intValue: Int) {
    return nil
  }
  
  init?(stringValue: String) {
      self.stringValue = stringValue
  }
}
