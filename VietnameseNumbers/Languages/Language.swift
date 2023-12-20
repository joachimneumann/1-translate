//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

protocol LanguageProtocol {
    var name: String { get }
    var negativeString: String { get }
    var dotString: String { get }
    var exponentString: String { get }
    func readPositive(_ i: Int) -> String    // implemented in subclasses of LanguageClass
    func read(_ s: String) -> String // implemented in LanguageClass
}

typealias Language = LanguageProtocol & LanguageClass

class LanguageClass {
    var groupSeparator: String = ""
    var decimalSeparator: String = "."
    var afterNegative = " "
    var beforeAndAfterDotString = ""
    var exponentString2: String? = nil
    var allowExponent = true
    var allowFraction = true
    let error = "ERROR"
    var englishName: String? = nil
    var subClass: Language? = nil
    
    init() {
        guard let temp = self as? Language else { return }
        self.subClass = temp
    }
    
    func read(_ i: Int) -> String {
        if i < 0 {
            return subClass!.negativeString + subClass!.afterNegative +  subClass!.readPositive(-i)
        } else {
            return subClass!.readPositive(i)
        }
    }
    func read(_ s: String) -> String {
        // lets remove the groupSeparator
        let strippedString = s.replacingOccurrences(of: groupSeparator, with: "")

        // exponent and mantissa part
        var parts = strippedString.components(separatedBy: "e")
        guard parts.count > 0 && parts.count <= 2 else { return error }
        let mantissa = parts[0]
        let exponent: String? = (parts.count == 2) ? parts[1] : nil
        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }

        // integer part and fractional part
        parts = mantissa.components(separatedBy: decimalSeparator)
        guard parts.count > 0 && parts.count <= 2 else { return error }
        let integerPart = parts[0]
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        guard allowFraction || fractionalPart == nil else { return "fractions not known" }


        var ret: String = ""

        if integerPart == "-0" {
            ret = subClass!.negativeString + afterNegative + read(0)
        } else {
            guard let integerPartValue = Int(integerPart) else { return error }
            ret = read(integerPartValue)
        }
        if let fractionalPart = fractionalPart {
            var count = 0
            ret += beforeAndAfterDotString + subClass!.dotString
            for char in fractionalPart {
                if count < 10 {
                    guard let digit = Int(String(char)) else { return error }
                    ret += beforeAndAfterDotString + read(digit)
                }
                count += 1
            }
            if count >= 10 {
                ret += "..."
            }
        }

        if let exponent = exponent {
            ret += subClass!.exponentString + read(exponent)
            if exponentString2 != nil {
                ret += exponentString2!
            }
        }

        return ret;
    }

}
