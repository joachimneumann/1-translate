//
//  DigitLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 24.08.24.
//

import Foundation

public class DigitLanguage: GeneralLanguage {
    
    override func fromUInt(_ i: UInt) -> String {
        var ret = ""
        for digit in i.digits {
            ret += _0_9(UInt(digit))
        }
        return ret
    }
//    
//    public func uInt2String(_ s: String) -> String {
//        var ret = ""
//        for digit in s {
//            if digit == "e" {
//                ret += exponentString
//            } else if digit == "." {
//                ret += dotString
//            } else if digit == "-" {
//                ret += negativeString
//            } else {
//                let i = digit.wholeNumberValue
//                if i != nil && i! >= 0 {
//                    ret += fromUInt(UInt(i!))
//                } else {
//                    ret += "?"
//                }
//            }
//        }
//        return ret
//    }
        
}

extension BinaryInteger {
    var digits: [Int] {
        return String(describing: self).compactMap { Int(String($0)) }
    }
}
