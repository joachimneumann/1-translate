//
//  DigitLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 24.08.24.
//

import Foundation

public class DigitLanguage {
    let negativeString = "-"
    let dotString = "."
    let exponentString = " EE "
    
    public init() {}

//    public var name: String = ""
    
    public func numberToText(_ s: String) -> String {
        var ret = ""
        for digit in s {
            if digit == "e" {
                ret += exponentString
            } else if digit == "." {
                ret += dotString
            } else if digit == "-" {
                ret += negativeString
            } else if let i = digit.wholeNumberValue {
                ret += _0_9(i)
            } else {
                ret += "?"
            }
        }
        return ret
    }
    
    public func numberToText(_ i: Int) -> String {
        var ret = ""
        for digit in i.digits {
            ret += _0_9(digit)
        }
        return ret
    }
    
    public func numberToText(_ f: Float) -> String {
        return numberToText(String(f))
    }
    
    public func numberToText(_ d: Double) -> String {
        return numberToText(String(d))
    }
    
    func _0_9(_ i: Int) -> String {
        return String(i)
    }
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
