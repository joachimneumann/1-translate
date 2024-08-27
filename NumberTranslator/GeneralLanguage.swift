//
//  GeneralLanguage.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 25.08.24.
//

import Foundation

class GeneralLanguage {
    var name: String = "name"
    var englishName: String? = nil
    var code: String? = nil
    var groupSize: Int = 3
    var allowZero: Bool = true
    var allowNegative: Bool = true
    var allowExponent: Bool = true
    var allowFraction: Bool = true
    var negativeString: String = "-"
    var afterNegative: String = ""
    var dotString: String = "."
    var beforeAndAfterDotString: String = " "
    var exponentString: String = " EE "
    var postProcessing: ((String) -> String)? = nil

    func _0_9(_ i: UInt) -> String {
        return String(i)
    }
    
    func fromUInt(_ i: UInt) -> String {
        return String(i)
    }
    
    func translate(_ i: Int) -> String {
        var ret: String = ""
        if i >= 0 {
            ret =  fromUInt(UInt(i))
        } else {
            guard allowNegative else { return "negative not allowed" }
            ret =  negativeString + afterNegative + fromUInt(UInt(-i))
        }
        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret
    }
    
    func translate(_ f: Float)  -> String { translate(String(f)) }
    func translate(_ d: Double) -> String { translate(String(d)) }
    
    func translate(_ s: String) -> String {
        // exponent and mantissa part
        var parts = s.components(separatedBy: "e")
        guard parts.count > 0 && parts.count <= 2 else { return "Exponent Error" }
        let mantissa = parts[0]
        let exponentAsString: String? = (parts.count == 2) ? parts[1] : nil
        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }
        
        // integer part and fractional part
        parts = mantissa.components(separatedBy: ".")
        guard parts.count > 0 && parts.count <= 2 else { return "Fraction Error" }
        let integerPart = parts[0]
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        guard allowFraction || fractionalPart == nil else { return "fractions not known" }
        
        var ret: String = ""
        if integerPart == "-0" && fractionalPart != nil { // e.g. -0.7 !!!
            guard allowNegative else { return "negative not allowed" }
            ret = negativeString + afterNegative + _0_9(0)
        } else {
            guard let integerPartInt = Int(integerPart) else { return "Integer Sign Error" }
            ret = translate(integerPartInt)
        }
        
        if let fractionalPart = fractionalPart {
            var count = 0
            ret += beforeAndAfterDotString + dotString
            for char in fractionalPart {
                if count < 10 {
                    guard let digit = UInt(String(char)) else { return "Digit Error" }
                    ret += beforeAndAfterDotString + _0_9(digit)
                }
                count += 1
            }
            if count >= 10 {
                ret += "..."
            }
        }
        
        if let exponentAsString = exponentAsString {
            ret += exponentString + translate(exponentAsString)
        }
        
        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret;
    }
}

extension UInt {
    func E(_ i: UInt) -> UInt {
        let factor = UInt(pow(10.0, Double(i)))
        return self / factor
    }
    func Ex(_ i: UInt) -> UInt {
        let factor = UInt(pow(10.0, Double(i)))

        return self - self / factor * factor
    }
    var pow10: UInt { UInt(pow(10.0, Double(self))) }
    var secondLastDigit: UInt { (self /  10) % 10 }
    var thirdLastDigit:  UInt { (self / 100) % 10 }
}
