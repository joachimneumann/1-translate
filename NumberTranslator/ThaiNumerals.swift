//
//  ThaiNumerals.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 22.08.24.
//

import Foundation

public struct ThaiNumerals: Language, LanguageImplementation {
    public let name = "แบบดั้งเดิม"
    let zero: String? = "๐"
    let allowNegativeNumbers: Bool = true
    let allowExponent: Bool = false
    let allowFraction: Bool = false
    let afterNegative: String = ""
    let negativeString = "-"
    let beforeAndAfterDotString = ""
    let dotString = "."
    let exponentString = " EE "
    
    public init() {}

    func read_positive(_ i: Int) -> String {
        var ret = ""
        for digit in i.digits {
            ret += _0_9(digit)
        }
        return ret
    }
    
    func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return "๐"
        case 1: return "๑"
        case 2: return "๒"
        case 3: return "๓"
        case 4: return "๔"
        case 5: return "๕"
        case 6: return "๖"
        case 7: return "๗"
        case 8: return "๘"
        case 9: return "๙"
        default: return "read_0_9: outside range"
        }
    }
    
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
