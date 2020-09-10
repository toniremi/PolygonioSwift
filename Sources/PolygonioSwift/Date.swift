//
//  Date.swift
//  
//
//  Created by Antoni Remeseiro Alfonso on 9/9/20.
//

public struct Date : Equatable, Hashable, Comparable {
  public let year: Int16
  public let month: Int8
  public let day: Int8

  public static func == (lhs: Date, rhs: Date) -> Bool {
    return lhs.year == rhs.year && lhs.month == rhs.month && lhs.day == rhs.day
  }

  public static func < (lhs: Date, rhs: Date) -> Bool {
    if lhs.year != rhs.year {
      return lhs.year < rhs.year
    }
    if lhs.month != rhs.month {
      return lhs.month < rhs.month
    }
    if lhs.day != rhs.day {
      return lhs.day < rhs.day
    }
    return false
  }
}

extension Date {
  private enum ParserState {
    case yyyy(Int)
    case mm(Int)
    case dd(Int)
  }

  private struct ParserError : Error {}

  static func parse(from s: String) throws -> Date {
    var year: Int16 = 0
    var month: Int8 = 0
    var day: Int8 = 0

    var state: ParserState = .yyyy(0)

    for c in s {
      if !c.isASCII {
        throw ParserError()
      }

      switch state {
        case .yyyy(let n):
          if c.isHexDigit, n < 4 {
            if let v = c.hexDigitValue, v < 10 {
              year = year * Int16(10) + Int16(v)
              state = .yyyy(n + 1)
              continue
            }
          }
          if c == "-", n == 4 {
            state = .mm(0)
            continue
          }
          throw ParserError()
        case .mm(let n):
          if c.isHexDigit, n < 2 {
            if let v = c.hexDigitValue, v < 10 {
              month = month * Int8(10) + Int8(v)
              state = .mm(n + 1)
              continue
            }
          }
          if c == "-", n == 2 {
            state = .dd(0)
            continue
          }
          throw ParserError()
        case .dd(let n):
          if c.isHexDigit, n < 2 {
            if let v = c.hexDigitValue, v < 10 {
              day = day * Int8(10) + Int8(v)
              state = .dd(n + 1)
              continue
            }
          }
          throw ParserError()
      }
    }
    switch state {
      case .dd(2):
        return Date(year: year, month: month, day: day)
      default:
        throw ParserError()
    }
  }
}
