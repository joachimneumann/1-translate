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
    
    var isZero: Bool {
        return __x == 0 && _x_ == 0 && x__ == 0
    }

    var isOne: Bool {
        return __x == 1 && _x_ == 0 && x__ == 0
    }

    init(_ integer: Int) {
        guard integer > 0 && integer <= 999 else {
            __x = 0
            _x_ = 0
            x__ = 0
            _xx = 0
            return
        }
        __x = integer % 10
        _x_ = (integer / 10) % 10
        x__ = integer / 100
        _xx = __x + 10 * _x_
    }
}

extension Int {
    
    var e0: Period {
        return Period(self % 1_000)
    }
    var e3: Period? {
        if self >= 1000 {
            return Period((self / 1_000) % 1_000)
        } else {
            return nil
        }
    }
    var e6: Period? {
        if self >= 1_000_000 {
            return Period((self / 1_000_000) % 1_000)
        } else {
            return nil
        }
    }
    var e9: Period? {
        if self >= 1_000_000_000 {
            return Period((self / 1_000_000_000) % 1_000)
        } else {
            return nil
        }
    }
    var e12: Period? {
        if self >= 1_000_000_000_000 {
            return Period((self / 1_000_000_000_000) % 1_000)
        } else {
            return nil
        }
    }
}
