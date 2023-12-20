//
//  DigitBasedLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class DigitBasedLanguage: Language {

    func read_0_9(_ i: Int) -> String {
        fatalError("not implmented")
    }

    fileprivate func readPeriod(_ p: Period) -> String {
        var ret = ""
        let allDigits = !p.isLargest
        if p.x__ > 0 || allDigits {
            ret += read_0_9(p.x__)
        }
        if p._x_ > 0 || p.x__ > 0 || allDigits {
            ret += read_0_9(p._x_)
        }
        if p.value > 0 || allDigits {
            ret += read_0_9(p.__x)
        }
        return ret
    }

    override func readPositive(_ i: Int) -> String {
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("TenBasedLanguage readPositive out of range") }
        
        if i == 0 { return read_0_9(0) }
        
        var ret = ""
        let e0 = i.e0
        
        guard let e3 = i.e3  else {
            return readPeriod(e0)
        }
        ret = readPeriod(e0)
        
        guard let e6 = i.e6  else {
            return readPeriod(e3) + ret
        }
        ret = readPeriod(e3) + ret
        
        guard let e9 = i.e9  else {
            return readPeriod(e6) + ret
        }
        ret = readPeriod(e6) + ret
        
        guard let e12 = i.e12  else {
            return readPeriod(e9) + ret
        }
        ret = readPeriod(e9) + ret
        ret = readPeriod(e12) + ret
        
        return ret
    }
}

fileprivate class Period {
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

fileprivate extension Int {
    
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
