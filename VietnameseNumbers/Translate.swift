//
//  Translate.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

///
/// TODOs:
///  Reading the text
///  Nachkommastellen
///

import Foundation

protocol Translator {
    var dotString: String { get }
    var negativeString: String { get set }
    var andSoOn: String { get set }
    var groupSeparator: String { get set }
    var decimalSeparator: String { get set }
    func translatePositiveInteger(_ i: Int) -> String?
}

extension Translator {
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
        
        // integer part and fractional part
        let parts = strippedString.components(separatedBy: decimalSeparator)
        let integerPart = (parts.count >= 1) ? parts[0] : nil
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        
        var ret: String = ""

        if integerPart != nil {
            let integerPartValue = Int(integerPart!)
            if integerPartValue != nil {
                ret = translate(integerPartValue!)!
                if integerPart == "-0" {
                    ret = negativeString + " " + translate(0)!
                }
                if fractionalPart != nil {
                    var count = 0
                    for char in fractionalPart! {
                        if count < 10 {
                            let digit = Int(String(char))
                            if digit != nil {
                                ret += " " + dotString + " " + translatePositiveInteger(digit!)!
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
        return ret;
    }    
}

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
