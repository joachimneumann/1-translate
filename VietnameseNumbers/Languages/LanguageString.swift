//
//  BasisLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class LanguageString {
    var name: String
    var negativeString: String
    var dotString: String
    var exponentString: String

    var afterNegative = " "
    var beforeAndAfterDotString = ""
    var exponentString2: String? = nil
    var allowExponent = true
    var allowFraction = true
    let error = "ERROR"
    var englishName: String? = nil
    
    init(name: String, negativeString: String, dotString: String, exponentString: String) {
        self.name = name
        self.negativeString = negativeString
        self.dotString = dotString
        self.exponentString = exponentString
    }
    
    func read(_ i: Int) -> String {
        fatalError("not implemented")
    }
    
    func read(_ s: String) -> String {
        // exponent and mantissa part
        var parts = s.components(separatedBy: "e")
        guard parts.count > 0 && parts.count <= 2 else { return error }
        let mantissa = parts[0]
        let exponent: String? = (parts.count == 2) ? parts[1] : nil
        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }

        // integer part and fractional part
        parts = mantissa.components(separatedBy: ".")
        guard parts.count > 0 && parts.count <= 2 else { return error }
        let integerPart = parts[0]
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        guard allowFraction || fractionalPart == nil else { return "fractions not known" }


        var ret: String = ""

        if integerPart == "-0" {
            ret = negativeString + afterNegative + read(0)
        } else {
            guard let integerPartValue = Int(integerPart) else { return error }
            ret = read(integerPartValue)
        }
        if let fractionalPart = fractionalPart {
            var count = 0
            ret += beforeAndAfterDotString + dotString
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
            ret += exponentString + read(exponent)
            if exponentString2 != nil {
                ret += exponentString2!
            }
        }

        return ret;
    }

}
