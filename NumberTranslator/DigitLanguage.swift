//
//  DigitLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 24.08.24.
//

import Foundation

class DigitLanguage: GeneralLanguage {
    override func fromUInt(_ i: UInt) -> String {
        var ret = ""
        for digit in i.digits {
            ret += _0_9(UInt(digit))
        }
        return ret
    }
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
