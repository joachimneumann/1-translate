//
//  BasicTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/9/23.
//

import Foundation

protocol TranslatorProtocol {
    var language: String { get }
    var groupSeparator: String  { get set }
    var decimalSeparator: String  { get set }
    func translate(_ i: Int) -> String?
    func translate(_ d: Double) -> String?
    func translate(_ s: String) -> String?
    
}

class BasicTranslator: TranslatorProtocol, Hashable {
    var beforeMinus: String = " "
    var beforeAndfterDotString: String = " "
    var allowNegativeNumbers = true
    var allowExponent = true
    var allowFraction = true

    func doubleToString(_ d: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.decimalSeparator = decimalSeparator
        numberFormatter.groupingSeparator = groupSeparator
        numberFormatter.maximumFractionDigits = 20
        if let result =  numberFormatter.string(from: d as NSNumber) {
            return result
        } else {
            return "SSSS"
        }
    }

    
    var uid = UUID().uuidString
    static func == (lhs: BasicTranslator, rhs: BasicTranslator) -> Bool {
        lhs.language == rhs.language
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(uid)
    }
    
    var language: String
    var dotString: String
    var negativeString: String
    var andSoOn: String
    var exponentString: String
    var groupSeparator: String
    var decimalSeparator: String
    init(language: String, dotString: String, negativeString: String, andSoOn: String, exponentString: String) {
        self.language = language
        self.dotString = dotString
        self.negativeString = negativeString
        self.andSoOn = andSoOn
        self.exponentString = exponentString
        self.groupSeparator = "" // will be set later
        self.decimalSeparator = ""
    }

    func translatePositiveInteger(_ i: Int) -> String? {
        // shall be overridden
        return nil
    }
    
    func translate(_ i: Int) -> String? {
        if i < 0 {
            guard allowNegativeNumbers else { return "negative: unknown" }
            guard let translation = translatePositiveInteger(-i) else { return nil }
            return negativeString + beforeMinus + translation
        } else {
            guard let translation = translatePositiveInteger(i) else { return nil }
            return translation
        }
    }
    
    func translate(_ d: Double) -> String? {
        translate(d.string)
    }
    
    func translate(_ s: String) -> String? {
        // lets remove the groupSeparator
        let groupSeparator = groupSeparator
        let strippedString = s.replacingOccurrences(of: groupSeparator, with: "")
        
        // exponent and mantissa part
        var parts = strippedString.components(separatedBy: "e")
        guard parts.count > 0 && parts.count <= 2 else { return nil }
        let mantissa = parts[0]
        let exponent: String? = (parts.count == 2) ? parts[1] : nil
        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }

        // integer part and fractional part
        parts = mantissa.components(separatedBy: decimalSeparator)
        guard parts.count > 0 && parts.count <= 2 else { return nil }
        let integerPart = parts[0]
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        guard allowFraction || fractionalPart == nil else { return "fractions not known" }

        
        var ret: String = ""

        if integerPart == "-0" {
            guard let nullString = translate(0) else { return nil }
            ret = negativeString + " " + nullString
        } else {
            guard let integerPartValue = Int(integerPart) else { return nil }
            guard let integerPartString = translate(integerPartValue) else { return nil }
            ret = integerPartString
        }
        if let fractionalPart = fractionalPart {
            var count = 0
            ret += beforeAndfterDotString + dotString
            for char in fractionalPart {
                if count < 10 {
                    guard let digit = Int(String(char)) else { return nil }
                    guard let digitString = translate(digit) else { return nil }
                    ret += beforeAndfterDotString + digitString
                }
                count += 1
            }
            if count >= 10 {
                ret += " " + andSoOn
            }
        }

        if let exponent = exponent {
            guard let translatedExponent = translate(exponent) else { return nil }
            ret += " " + exponentString + " " + translatedExponent
        }

        return ret;
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
