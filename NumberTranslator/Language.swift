//
//  NumberTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 22.08.24.
//

import Foundation

public protocol Language {
    var name: String { get }
    func numberToText(_ s: String) -> String
    func numberToText(_ i: Int) -> String
    func numberToText(_ f: Float) -> String
    func numberToText(_ d: Double) -> String
}

//protocol LanguageImplementation {
//    var zero: String? { get }
//    var allowNegativeNumbers: Bool { get }
//    var allowExponent: Bool { get }
//    var allowFraction: Bool { get }
//    var afterNegative: String { get }
//    var negativeString: String { get }
//    var beforeAndAfterDotString: String { get }
//    var dotString: String { get }
//    var exponentString: String { get }
//    func read_positive(_ i: Int) -> String
//    func _0_9(_ i: Int) -> String
//}
//
//extension LanguageImplementation {
//    func read(_ i: Int) -> String {
//        var ret: String
//        if i == 0 {
//            if let zero = zero {
//                ret = zero
//            } else {
//                ret = "zero unknown"
//            }
//        } else if i < 0 {
//            if !allowNegativeNumbers {
//                ret = "negative unknown"
//            } else {
//                ret = negativeString + afterNegative + read(-i)
//            }
//        } else {
//            if i <= 0 {
//                fatalError("read() negative integer \(i)")
//            }
//            if i > 999_999_999_999_999 { fatalError("read() too large parameter \(i)") }
//            ret = read_positive(i)
//        }
////        if let postProcessing = postProcessing {
////            ret = postProcessing(ret)
////        }
//        return ret
//    }
//    
//    public func translate(_ s: String) -> String {
//        // exponent and mantissa part
//        var parts = s.components(separatedBy: "e")
//        guard parts.count > 0 && parts.count <= 2 else { return "wrong format" }
//        let mantissa = parts[0]
//        let exponentAsString: String? = (parts.count == 2) ? parts[1] : nil
//        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }
//        
//        // integer part and fractional part
//        parts = mantissa.components(separatedBy: ".")
//        guard parts.count > 0 && parts.count <= 2 else { return "wrong format" }
//        let integerPart = parts[0]
//        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
//        guard allowFraction || fractionalPart == nil else { return "fractions not known" }
//        
//        var ret = String("")
//        if integerPart == "-0" && fractionalPart != nil { // e.g. -0.7 !!!
//            if let zero = zero {
//                ret = String(negativeString + afterNegative + zero)
//            } else {
//                return "zero unknown"
//            }
//        } else {
//            guard let integerPartInt = Int(integerPart) else { return "ERROR" }
//            ret = read(integerPartInt)
//        }
//        
//        if let fractionalPart = fractionalPart {
//            var count = 0
//            ret = ret + String(beforeAndAfterDotString + dotString)
//            for char in fractionalPart {
//                if count < 10 {
//                    guard let digit = Int(String(char)) else { return "not a digit" }
//                    ret = ret + beforeAndAfterDotString + read_positive(digit)
//                }
//                count += 1
//            }
//            if count >= 10 {
//                ret = ret + "..."
//            }
//        }
//        
//        if let exponentAsString = exponentAsString {
//            ret = ret + exponentString + translate(exponentAsString)
//        }
//        return ret
//    }
//}
//
//protocol LanguageImplGroup3 {
//    var _20_99_connector: String { get }
//    var use_single_hundreds: Bool { get }
//    var before_hundreds: String { get }
//    var after_hundreds: String { get }
//    var use_single_group: Bool { get }
//    var before_groupName: String { get }
//    var after_groupName: String { get }
//    func _0_9(_ i: Int) -> String
//    func _10s(_ i: Int) -> String
//}
//
//extension LanguageImplGroup3 {
//    func _11_19(_ i: Int) -> String {
//        return _20_99(i)
//    }
//    
//    func _20_99(_ i: Int) -> String {
//        let left = i / 10
//        let right = i - left * 10
//        var ret = _10s(left)
//        if right > 0 {
//            ret = ret + _20_99_connector + _0_9(right)
//        }
//        return ret
//    }
//    
//    func _0_99(_ i: Int) -> String {
//        if i <= 9 { return _0_9(i) }
//        if i == 10 { return _10s(1) }
//        if i <= 19 { return _11_19(i) }
//        return _20_99(i)
//    }
//    
//    func _100_999(_ hundreds: Int, below: Int) -> String {
//        var ret = String("")
//        if hundreds > 1 || use_single_hundreds {
//            ret = _0_9(hundreds) + before_hundreds
//        }
//        if let hundredsName = groupName(2, hundreds) {
//            ret = ret + hundredsName
//        }
//        if below > 0 {
//            ret = ret + after_hundreds + _0_99(below)
//        }
//        return ret
//    }
//    
//    func groupName(_ groupIndex: Int, _ above: Int) -> String? {
//        return nil
//    }
//    
//    func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
//        var ret = String("")
//        
//        if above > 1 || use_single_group {
//            ret = read_positive(above) + before_groupName
//        }
//        if let groupName = groupName(groupIndex, above) {
//            ret = ret + groupName
//        }
//        
//        if below > 0 {
//            ret = ret + after_groupName + read_positive(below)
//        }
//        return ret
//    }
//    
//    func read_positive(_ i: Int) -> String {
//        if i <= 9 {
//            return _0_9(i)
//        }
//        
//        if i == 10 {
//            return _10s(1)
//        }
//        
//        if i <= 19 {
//            return _11_19(i)
//        }
//        
//        if i <= 99 {
//            return _20_99(i)
//        }
//        
//        if i <= 999 {
//            return _100_999(i.E(2), below: i.Ex(2))
//        }
//        
//        for exponent in stride(from: 3, to: 15, by: 3){
//            if i <= (exponent+3).pow10 - 1 {
//                return group(exponent, i.E(exponent), below: i.Ex(exponent))
//            }
//        }
//        
//        fatalError("ERROR in NewLanguageGroup3.read_positive()")
//    }
//}
//
//extension Int {
//    func E(_ i: Int) -> Int {
//        let factor = Int(pow(10.0, Double(i)))
//        return self / factor
//    }
//    func Ex(_ i: Int) -> Int {
//        let factor = Int(pow(10.0, Double(i)))
//        
//        return self - self / factor * factor
//    }
//    var pow10: Int { Int(pow(10.0, Double(self))) }
//    var secondLastDigit: Int { (self /  10) % 10 }
//    var thirdLastDigit:  Int { (self / 100) % 10 }
//}
