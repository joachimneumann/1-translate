//
//  LanguageImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 20.06.24.
//

import Foundation

@Observable class LanguageImpl: Language {
    
    
    func read(_ i: Int) -> String {
        var ret: String
        if i == 0 {
            ret = zero ?? "zero unknown"
        } else if i < 0 {
            if !allowNegativeNumbers {
                ret = "negative unknown"
            } else {
                ret = negativeString + afterNegative + read(-i)
            }
        } else {
            if i <= 0 {
                fatalError("read() negative integer \(i)")
            }
            if i > 999_999_999_999_999 { fatalError("read() too large parameter \(i)") }
            ret = read_positive(i)
        }
        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret
    }
    
    override func read(_ s: String) -> String {
        // exponent and mantissa part
        var parts = s.components(separatedBy: "e")
        guard parts.count > 0 && parts.count <= 2 else { return LanguageError }
        let mantissa = parts[0]
        let exponentAsString: String? = (parts.count == 2) ? parts[1] : nil
        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }
        
        // integer part and fractional part
        parts = mantissa.components(separatedBy: ".")
        guard parts.count > 0 && parts.count <= 2 else { return LanguageError }
        let integerPart = parts[0]
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        guard allowFraction || fractionalPart == nil else { return "fractions not known" }
        
        var ret: String = ""
        if integerPart == "-0" && fractionalPart != nil { // e.g. -0.7 !!!
            if let zero = zero {
                ret = negativeString + afterNegative + zero
            } else {
                return "zero unknown"
            }
        } else {
            guard let integerPartInt = Int(integerPart) else { return LanguageError }
            ret = read(integerPartInt)
        }
        
        if let fractionalPart = fractionalPart {
            var count = 0
            ret += beforeAndAfterDotString + dotString
            for char in fractionalPart {
                if count < 10 {
                    guard let digit = Int(String(char)) else { return LanguageError }
                    ret += beforeAndAfterDotString + read_positive(digit)
                }
                count += 1
            }
            if count >= 10 {
                ret += "..."
            }
        }
        
        if let exponentAsString = exponentAsString {
            ret += exponentString + read(exponentAsString)
        }
        
        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret;
    }
}
