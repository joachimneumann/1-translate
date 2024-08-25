//
//  GeneralLanguageProtocol.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 25.08.24.
//

import Foundation

protocol GeneralLanguageProtocol: LanguageProtocol {
    var allowNegative: Bool { get }
    var allowExponent: Bool { get }
    var allowFraction: Bool { get }
    var negativeString: String { get }
    var afterNegative: String { get }
    var dotString: String { get }
    var beforeAndAfterDotString: String { get }
    var exponentString: String { get }
    var postProcessing: ((String) -> String)? { get }
    func fromUInt(_ i: UInt) -> String
    func _0_9(_ i: UInt) -> String
}

extension GeneralLanguageProtocol {
    public func translate(_ i: Int) -> String {
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
    
    public func translate(_ s: String) -> String {
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
