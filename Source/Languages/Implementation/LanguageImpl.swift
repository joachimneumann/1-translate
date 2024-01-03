//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

@Observable class LanguageImpl: Language {
    var name: String
    var nameDescription: String? = nil
    var flagName: String { nameDescription != nil ? nameDescription! : name }
    var voiceLanguageCode: String?
    var voiceLanguageName: String?
    var voiceIdentifier : String? = nil
    var negativeString: String
    var dotString: String
    var exponentString: String
    
    var afterNegative = " "
    var beforeAndAfterDotString = ""
    var exponentString2: String? = nil
    var allowExponent = true
    var allowFraction = true
    let error = "ERROR"
    
    var e2: String? = nil
    var e3: String? = nil
    var e4: String? = nil
    var e5: String? = nil
    var e6: String? = nil
    var e9: String? = nil
    var e12: String? = nil
    var e1_one: String? = nil
    var e2_one: String? = nil
    var e3_one: String? = nil
    var e6_one: String? = nil
    var e9_one: String? = nil
    var e12_one: String? = nil
    var e2_cleanPlural: String? = nil
    var beforeHundred = ""
    var afterHundred = ""
    var afterGroup = ""
    var allowNegativeNumbers = true
    var postProcessing: ((String) -> String)? = nil
    
    var eSpace: String? = nil
    var e3Space: String? = nil
    var e69Space: String? = nil
    private var eSpace_: String { eSpace == nil ? "" : eSpace! }
    private var e3Space_: String { e3Space == nil ? "" : e3Space! }
    private var e69Space_: String { e69Space == nil ? "" : e69Space! }
    
    var tensConnector: String? = nil
    var tensConnector_: String {
        if tensConnector != nil {
            tensConnector!
        } else {
            ""
        }
    }
    
    var nameWithDescription: String {
        name + (nameDescription != nil ? "/"+nameDescription! : "")
    }
    
    init(name: String,
         negativeString: String,
         dotString: String,
         exponentString: String) {
        self.name = name
        self.voiceLanguageCode = nil
        self.voiceLanguageName = nil
        self.negativeString = negativeString
        self.dotString = dotString
        self.exponentString = exponentString
    }
    
    func read_0_9(_ i: Int) -> String {
        fatalError("not implmented")
    }
    
    func read_10s(_ i: Int) -> String {
        fatalError("not implmented")
    }
    
    func read_10_99(_ i: Int) -> String {
        var ret = read_10s(i.E1)
        if i.E1 == 1 && e1_one != nil {
            ret = e1_one!
        } else {
            if i.E1x > 0 {
                ret += tensConnector_ + read_0_9(i.E1x)
            }
        }
        return ret
    }
    
    func read_e2_e3(_ i: Int) -> String {
        var ret = readInteger(i.E2)
        if i.E2 == 1 && e2_one != nil {
            ret = e2_one!
        } else {
            if let e2 = e2 {
                ret = readInteger(i.E2)
                ret += eSpace_
                if i.E2 > 1 && i.E2x == 0 && e2_cleanPlural != nil {
                    ret += e2_cleanPlural!
                } else {
                    ret += beforeHundred
                    ret += e2
                }
            }
        }
        if i.E2x > 0 {
            ret += afterHundred + afterGroup
            ret += eSpace_ + readInteger(i.E2x)
        }
        return ret
    }
    
    func read_e3_e6(_ i: Int) -> String {
        var ret = readInteger(i.E3)
        if i.E3 == 1 && e3_one != nil {
            ret = e3_one!
        } else {
            if let e3 = e3 {
                ret = readInteger(i.E3)
                ret += eSpace_ + e3Space_ + e3
            }
        }
        if i.E3x > 0 {
            ret += afterGroup + eSpace_ + e3Space_ + readInteger(i.E3x)
        }
        return ret
    }

    func read_e6_e9(_ i: Int) -> String {
        var ret = readInteger(i.E6)
        if i.E6 == 1 && e6_one != nil {
            ret = e6_one!
        } else {
            if let e6 = e6 {
                ret = readInteger(i.E6)
                ret += eSpace_ + e69Space_ + e6
            }
        }
        if i.E6x > 0 {
            ret += afterGroup + eSpace_ + e69Space_ + readInteger(i.E6x)
        }
        return ret
    }

    func read_e9_e12(_ i: Int) -> String {
        var ret = readInteger(i.E9)
        if i.E9 == 1 && e9_one != nil {
            ret = e9_one!
        } else {
            if let e9 = e9 {
                ret = readInteger(i.E9)
                ret += eSpace_ + e69Space_ + e9
            }
        }
        if i.E9x > 0 {
            ret += afterGroup + eSpace_ + e69Space_ + readInteger(i.E9x)
        }
        return ret
    }
    
    func read_e12_e15(_ i: Int) -> String {
        var ret = readInteger(i.E12)
        if i.E12 == 1 && e12_one != nil {
            ret = e12_one!
        } else {
            if let e12 = e12 {
                ret = readInteger(i.E12)
                ret += eSpace_ + e69Space_ + e12
            }
        }
        if i.E12x > 0 {
            ret += afterGroup + eSpace_ + e69Space_ + readInteger(i.E12x)
        }
        return ret
    }

    func read(_ i: Int) -> String {
        var ret = readInteger(i)
        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret
    }

    func readInteger(_ i: Int) -> String {
        if i < 0 {
            guard allowNegativeNumbers else { return "negative: unknown" }
            return negativeString + afterNegative + readInteger(-i)
        }
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("too large") }
        
        if i < 10    { return read_0_9(i) }
        if i <= 99   { return read_10_99(i)   }
        if i < 1_000 { return read_e2_e3(i) }
        
        var ret = ""
        if i < 1_000_000 {
            if e5 != nil {
                if i >= 100_000 {
                    ret += read_0_9(i.E5)
                    ret += e5!
                    if i.E5x > 0 {
                        ret += readInteger(i.E5x)
                    }
                    return ret
                }
            }
            if e4 != nil {
                if i >= 10_000 {
                    ret += readInteger(i.E4)
                    ret += e4!
                    if i.E4x > 0 {
                        ret += readInteger(i.E4x)
                    }
                    return ret
                }
            }
            return read_e3_e6(i)
        }
        
        if i < 1_000_000_000 {
            return read_e6_e9(i)
        }
        
        if i < 1_000_000_000_000 {
            return read_e9_e12(i)
        }
        return read_e12_e15(i)
    }
    
    func read(_ s: String) -> String {
        // exponent and mantissa part
        var parts = s.components(separatedBy: "e")
        guard parts.count > 0 && parts.count <= 2 else { return error }
        let mantissa = parts[0]
        let exponentAsString: String? = (parts.count == 2) ? parts[1] : nil
        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }

        // integer part and fractional part
        parts = mantissa.components(separatedBy: ".")
        guard parts.count > 0 && parts.count <= 2 else { return error }
        let integerPart = parts[0]
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        guard allowFraction || fractionalPart == nil else { return "fractions not known" }


        var ret: String = ""

        if integerPart == "-0" {
            ret = negativeString + afterNegative + readInteger(0)
        } else {
            guard let integerPartValue = Int(integerPart) else { return error }
            ret = readInteger(integerPartValue)
        }
        if let fractionalPart = fractionalPart {
            var count = 0
            ret += beforeAndAfterDotString + dotString
            for char in fractionalPart {
                if count < 10 {
                    guard let digit = Int(String(char)) else { return error }
                    ret += beforeAndAfterDotString + readInteger(digit)
                }
                count += 1
            }
            if count >= 10 {
                ret += "..."
            }
        }

        if let exponentAsString = exponentAsString {
            ret += exponentString + read(exponentAsString)
            if exponentString2 != nil {
                ret += exponentString2!
            }
        }

        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret;
    }
}

extension Int {
    var E1: Int { self / 10 }
    var E1x: Int { self - self / 10 * 10 } // self % 10?
    var E2: Int { self / 100 }
    var E2x: Int { self - self / 100 * 100 }
    var E3: Int { self / 1_000 }
    var E3x: Int { self - self / 1_000 * 1_000}
    var E4: Int { self / 10_000 }
    var E4x: Int { self - self / 10_000 * 10_000 }
    var E5: Int { self / 100_000 }
    var E5x: Int { self - self / 100_000 * 100_000 }
    var E6: Int { self / 1_000_000 }
    var E6x: Int { self - self / 1_000_000 * 1_000_000 }
    var E8: Int { self / 100_000_000 }
    var E8x: Int { self - self / 100_000_000 * 100_000_000 }
    var E9: Int { self / 1_000_000_000 }
    var E9x: Int { self - self / 1_000_000_000 * 1_000_000_000 }
    var E12: Int { self / 1_000_000_000_000 }
    var E12x: Int { self - self / 1_000_000_000_000 * 1_000_000_000_000 }
    var secondLastDigit: Int { (self /  10) % 10 }
    var thirdLastDigit:  Int { (self / 100) % 10 }
}
