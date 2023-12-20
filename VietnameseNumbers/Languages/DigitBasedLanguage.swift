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

    func readPeriod(_ p: Period) -> String {
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

