//
//  BasicTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/9/23.
//

import Foundation

protocol BasicTranslatorProtocol {
    var dotString: String { get }
    var negativeString: String { get }
    var andSoOn: String { get }
    var exponentString: String { get }
    var groupSeparator: String { get }
    var decimalSeparator: String { get }
}

class BasicTranslator: BasicTranslatorProtocol {
    var dotString: String
    var negativeString: String
    var andSoOn: String
    var exponentString: String
    var groupSeparator: String
    var decimalSeparator: String
    init(dotString: String, negativeString: String, andSoOn: String, exponentString: String) {
        self.dotString = dotString
        self.negativeString = negativeString
        self.andSoOn = andSoOn
        self.exponentString = exponentString
        self.groupSeparator = "" // will be set later
        self.decimalSeparator = ""
    }

    func translatePositiveInteger(_ i: Int) -> String? {
        // placeholder
        return nil
    }
    
    func translate(_ i: Int) -> String? {
        if i < 0 {
            return negativeString + " " + translatePositiveInteger(-i)!
        } else {
            return translatePositiveInteger(i)!
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
        let mantissa = (parts.count >= 1) ? parts[0] : nil
        let exponent: String? = (parts.count == 2) ? parts[1] : nil

        // integer part and fractional part
        parts = mantissa!.components(separatedBy: decimalSeparator)
        let integerPart = (parts.count >= 1) ? parts[0] : nil
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        
        var ret: String = ""

        if integerPart != nil {
            let integerPartValue = Int(integerPart!)
            if integerPartValue != nil {
                if integerPart == "-0" {
                    ret = negativeString + " " + translate(0)!
                } else {
                    ret = translate(integerPartValue!)!
                }
                if fractionalPart != nil {
                    var count = 0
                    ret += " " + dotString
                    for char in fractionalPart! {
                        if count < 10 {
                            let digit = Int(String(char))
                            if digit != nil {
                                ret += " " + translate(digit!)!
                            } else {
                                ret += "?"
                            }
                        }
                        count += 1
                    }
                    if count >= 10 {
                        ret += " " + andSoOn
                    }
                }
            }
        }

        if exponent != nil {
            ret += " " + exponentString + " " + translate(exponent!)!
        }

        return ret;
    }
}
