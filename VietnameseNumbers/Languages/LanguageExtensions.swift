//
//  LanguageExtensions.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class Period {
    let __x: Int
    let _x_: Int
    let x__: Int
    let _xx: Int
    let value: Int
    let isLargest: Bool
    
    init(_ integer: Int, isLargest: Bool) {
        guard integer >= 0 && integer <= 999 else {
            fatalError("Period init() out of range")
        }
        __x = integer % 10
        _x_ = (integer / 10) % 10
        x__ = integer / 100
        _xx = __x + 10 * _x_
        value = integer
        self.isLargest = isLargest
    }
}

extension Int {
    
    var e0: Period {
        return Period(self % 1_000, isLargest: self < 1000)
    }
    var e3: Period? {
        if self >= 1000 {
            return Period((self / 1_000) % 1_000, isLargest: self < 1000_000)
        } else {
            return nil
        }
    }
    var e6: Period? {
        if self >= 1_000_000 {
            return Period((self / 1_000_000) % 1_000, isLargest: self < 1000_000_000)
        } else {
            return nil
        }
    }
    var e9: Period? {
        if self >= 1_000_000_000 {
            return Period((self / 1_000_000_000) % 1_000, isLargest: self < 1000_000_000_000)
        } else {
            return nil
        }
    }
    var e12: Period? {
        if self >= 1_000_000_000_000 {
            return Period((self / 1_000_000_000_000) % 1_000, isLargest: self < 1000_000_000_000_000)
        } else {
            return nil
        }
    }
}
