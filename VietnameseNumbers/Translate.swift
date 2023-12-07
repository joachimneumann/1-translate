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
    func translate(_ string: String) -> String?
}

enum VietnameseThousand: String, Codable, CaseIterable {
    case ngàn
    case nghìn
    var string: String {
        switch self {
        case .ngàn: return "ngàn"
        case .nghìn: return "nghìn"
        }
    }
}

enum VietnameseSecondLast: String, Codable, CaseIterable {
    case linh
    case lẻ
    var string: String {
        switch self {
        case .linh: return "linh"
        case .lẻ: return "lẻ"
        }
    }
}

class VietnameseTranslator: Translator {
    var groupingSeparator: GroupingSeparator
    var thousand: VietnameseThousand
    var secondLast: VietnameseSecondLast
    var compact: Bool
    private let one = "một"
    private let one_with_up_tone = "mốt"
    private let ten = "mười"
    private let ten_no_tone = "mươi"
    private let hundred = "trăm"
    private let million = "triệu"
    private let billion = "tỷ"
    
    init(groupingSeparator: GroupingSeparator, thousand: VietnameseThousand, secondLast: VietnameseSecondLast, compact: Bool) {
        self.groupingSeparator = groupingSeparator
        self.thousand = thousand
        self.secondLast = secondLast
        self.compact = compact
    }
    
    private func toString_0_10(_ intValue: Int, one_up_tone: Bool = false, lăm: Bool = false, ten_tone: Bool = false) -> String? {
        switch intValue {
        case 0:     return "không"
        case 1:     if one_up_tone { return one_with_up_tone } else { return one }
        case 2:     return "hai"
        case 3:     return "ba"
        case 4:     return "bốn"
        case 5:     if lăm { return "lăm" } else { return "năm" }
        case 6:     return "sáu"
        case 7:     return "bảy"
        case 8:     return "tám"
        case 9:     return "chín"
        case 10:    if ten_tone { return ten_no_tone } else { return ten }
        default: return nil
        }
    }
        
    private func toString_(_ intValue: Int, fromLargerNumber: Bool) -> String? {
        if intValue < 0 { return nil }
        if !fromLargerNumber && intValue <= 10 {
            return toString_0_10(intValue)
        }
        if !fromLargerNumber && intValue < 20 {
            return toString_0_10(10)! + " " +
            toString_0_10(intValue - 10, one_up_tone: false, lăm: true)!
        }
        if intValue <= 999 {
            var temp = intValue
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            temp = (temp - X0) / 10
            let X00 = temp % 10
            var ret = ""
            if fromLargerNumber || X00 > 0 {
                if ret.count > 0 { ret += " " }
                ret += toString_(X00, fromLargerNumber: false)! + " " + hundred
            } else {
                if fromLargerNumber || ret.count > 0 {
                    if ret.count > 0 { ret += " " }
                    ret += toString_(0, fromLargerNumber: false)! + " " + hundred
                }
            }
            if X0 == 0 && X == 0 {
                return ret
            }
            if X0 > 0 {
                if ret.count > 0 { ret += " " }
                if X0 >= 2 {
                    var between = " " + ten_no_tone
                    if compact {
                        if X > 0 {
                            between = ""
                        }
                    }
                    ret += toString_(X0, fromLargerNumber: false)! + between
                    if X > 0 {
                        ret += " " + toString_0_10(X, one_up_tone: true, lăm: true)!
                    }
                } else {
                    // X0 is 1
                    ret += ten
                    if X > 0 {
                        ret += " " + toString_0_10(X, one_up_tone: false, lăm: true)!
                    }
                }
            } else {
                // lẻ?
                if ret.count > 0 { ret += " " }
                if X > 0 {
                    ret += secondLast.string + " "
                    ret += toString_(X, fromLargerNumber: false)!
                } else {
                    ret += toString_(0, fromLargerNumber: false)!
                }
            }
            return ret
        }
        
        if intValue <= 999_999 {
            let XXX = intValue % 1_000
            let XXX_000 = (intValue - XXX) / 1_000
            var ret = toString_(XXX_000, fromLargerNumber: fromLargerNumber)! + " " + thousand.string
            if XXX > 0 {
                ret += " " + toString_(XXX, fromLargerNumber: true)!
            }
            return ret
        }
        
        if intValue <= 999_999_999 {
            let XXX_XXX = intValue % 1_000_000
            let XXX_000_000 = (intValue - XXX_XXX) / 1_000_000
            var ret = toString_(XXX_000_000, fromLargerNumber: false)! + " " + million
            if XXX_XXX > 0 {
                ret += " " + toString_(XXX_XXX, fromLargerNumber: true)!
            }
            return ret
        }
        
        if intValue <= 999_999_999_999 {
            let XXX_XXX_XXX = intValue % 1_000_000_000
            let XXX_000_000_000 = (intValue - XXX_XXX_XXX) / 1_000_000_000
            var ret = toString_(XXX_000_000_000, fromLargerNumber: false)! + " " + billion
            if XXX_XXX_XXX > 0 {
                ret += " " + toString_(XXX_XXX_XXX, fromLargerNumber: true)!
            }
            return ret
        }
        
        return nil
    }

    func toString(_ intValue: Int) -> String? {
        var wasNegative = false
        if intValue < 0 {
            wasNegative = true
        }
        var ret: String
        if wasNegative {
            ret = toString_(-intValue, fromLargerNumber: false)!
        } else {
            ret = toString_(intValue, fromLargerNumber: false)!
        }
        if wasNegative {
            ret = "âm " + ret
        }
        return ret
    }

    func translate(_ string: String) -> String? {
        let groupSeparator = groupingSeparator.string
        let strippedString = string.replacingOccurrences(of: groupSeparator, with: "")
        let intValue = Int(strippedString)
        if intValue != nil {
            return toString(intValue!)
        }
        return nil;
    }
}

class EnglishTranslator: Translator {
    var groupingSeparator: GroupingSeparator
    var decimalSeparator: DecimalSeparator
    var useAndAfterHundred: Bool
    
    private let zero = "zero"
    private let one = "one"
    private let ten = "ten"
    private let hundred = "hundred"
    private let thousand = "thousand"
    private let million = "million"
    private let billion = "billion"
    
    init(groupingSeparator: GroupingSeparator, decimalSeparator: DecimalSeparator, useAndAfterHundred: Bool) {
        self.groupingSeparator = groupingSeparator
        self.decimalSeparator = decimalSeparator
        self.useAndAfterHundred = useAndAfterHundred
    }
    
    private func english_0_20(_ intValue: Int) -> String? {
        switch intValue {
        case 0:     return zero
        case 1:     return one
        case 2:     return "two"
        case 3:     return "three"
        case 4:     return "four"
        case 5:     return "five"
        case 6:     return "six"
        case 7:     return "seven"
        case 8:     return "eight"
        case 9:     return "nine"
        case 10:    return ten
        case 11:    return "eleven"
        case 12:    return "twelve"
        case 13:    return "thirteen"
        case 14:    return "fourteen"
        case 15:    return "fifteen"
        case 16:    return "sixteen"
        case 17:    return "seventeen"
        case 18:    return "eightteen"
        case 19:    return "nineteen"
        case 20:    return "twenty"
        default: return nil
        }
    }
    
    private func english_tens(_ intValue: Int) -> String? {
        switch intValue {
        case 1:     return "ten"
        case 2:     return "twenty"
        case 3:     return "thirty"
        case 4:     return "fourty"
        case 5:     return "fifty"
        case 6:     return "sixty"
        case 7:     return "seventy"
        case 8:     return "eighty"
        case 9:     return "ninety"
        default: return nil
        }
    }
    
    private func translateInteger(_ intValue: Int) -> String? {
        if intValue <= 20 {
            return english_0_20(intValue)
        }
        if intValue <= 99 {
            var temp = intValue
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            var ret = english_tens(X0)!
            if X > 0 {
                ret += "-" + english_0_20(X)!
            }
            return ret
        }
        if intValue <= 999 {
            var temp = intValue
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            temp = (temp - X0) / 10
            let X00 = temp % 10
            var ret = english_0_20(X00)! + " " + hundred
            let leftover = 10 * X0 + X
            if leftover > 0 {
                if useAndAfterHundred {
                    ret += " and "
                } else {
                    ret += " "
                }
                ret += translateInteger(leftover)!
            }
            return ret
        }
        
        if intValue <= 999_999 {
            let XXX_000 = (intValue - intValue % 1000) / 1000
            let XXX = intValue - 1000 * XXX_000
            var ret = translateInteger(XXX_000)! + " " + thousand
            if XXX > 0 {
                ret += " " + translateInteger(XXX)!
            }
            return ret
        }
        
        if intValue <= 999_999_999 {
            let XXX_000_000 = (intValue - intValue % 1_000_000) / 1_000_000
            let XXX_000 = intValue - 1_000_000 * XXX_000_000
            var ret = translateInteger(XXX_000_000)! + " " + million
            if XXX_000 > 0 {
                ret += " " + translateInteger(XXX_000)!
            }
            return ret
        }
        
        if intValue <= 999_999_999_999 {
            let XXX_000_000_000 = (intValue - intValue % 1_000_000_000) / 1_000_000_000
            let XXX_000_000 = intValue - 1_000_000_000 * XXX_000_000_000
            var ret = translateInteger(XXX_000_000_000)! + " " + billion
            if XXX_000_000 > 0 {
                ret += " " + translateInteger(XXX_000_000)!
            }
            return ret
        }
        
        return nil
    }
    
    private func handleNegative(_ intValue: Int) -> String? {
        var wasNegative = false
        if intValue < 0 {
            wasNegative = true
        }
        var ret: String
        if wasNegative {
            ret = translateInteger(-intValue)!
        } else {
            ret = translateInteger(intValue)!
        }
        if wasNegative {
            ret = "minus " + ret
        }
        return ret
    }
    
    func translate(_ string: String) -> String? {
        let groupSeparator = groupingSeparator.string
        let strippedString = string.replacingOccurrences(of: groupSeparator, with: "")
        let parts = strippedString.components(separatedBy: decimalSeparator.string)
        if parts.count == 1 {
            // is an integer
            let intValue = Int(parts[0])
            if intValue != nil {
                return handleNegative(intValue!)
            }
        } else if parts.count == 2 {
            var ret = ""
            let intValue = Int(parts[0])
            if intValue != nil {
                ret = handleNegative(intValue!)!
                ret += " dot"
                var count = 0
                for char in parts[1] {
                    if count < 10 {
                        ret += " " + translate(String(char))!
                    }
                    count += 1
                }
                if count >= 10 {
                    ret += " and so on"
                }
            }
            return ret
        }
        return nil;
    }
    
}


class GermanTranslator: Translator {
    var groupingSeparator: GroupingSeparator
    
    init(groupingSeparator: GroupingSeparator) {
        self.groupingSeparator = groupingSeparator
    }
    
    private func german_0_20(_ intValue: Int) -> String? {
        switch intValue {
        case 0:     return "null"
        case 1:     return "ein"// "eins" handled seperately
        case 2:     return "zwei"
        case 3:     return "drei"
        case 4:     return "vier"
        case 5:     return "fünf"
        case 6:     return "sechs"
        case 7:     return "sieben"
        case 8:     return "acht"
        case 9:     return "neun"
        case 10:    return "zehn"
        case 11:    return "elf"
        case 12:    return "zwölf"
        case 13:    return "dreizehn"
        case 14:    return "vierzehn"
        case 15:    return "fünfzehn"
        case 16:    return "sechzehn"
        case 17:    return "siebzehn"
        case 18:    return "achtzehn"
        case 19:    return "neunzehn"
        case 20:    return "zwanzig"
        default: return nil
        }
    }
    
    private func german_tens(_ intValue: Int) -> String? {
        switch intValue {
        case 1:     return "zehn"
        case 2:     return "zwanzig"
        case 3:     return "dreißig"
        case 4:     return "vierzig"
        case 5:     return "fünfzig"
        case 6:     return "sechzig"
        case 7:     return "siebzig"
        case 8:     return "achtzig"
        case 9:     return "neunzig"
        default: return nil
        }
    }
        
    private func toStringLowercase(_ intValue: Int) -> String? {
        if intValue == 1 {
            return "eins"
        }
        if intValue <= 20 {
            return german_0_20(intValue)
        }
        if intValue <= 99 {
            var temp = intValue
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            if X == 0 {
                return german_tens(X0)!
            } else {
                return german_0_20(X)! + "\u{AD}" + "und" + "\u{AD}" + german_tens(X0)! // "\u{AD}" is a soft hyphen
            }
        }
        if intValue <= 999 {
            var temp = intValue
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            temp = (temp - X0) / 10
            let X00 = temp % 10
            var ret = german_0_20(X00)! + "\u{AD}" + "hundert" + "\u{AD}"
            let leftover = 10 * X0 + X
            if leftover > 0 {
                ret += toStringLowercase(leftover)!
            }
            return ret
        }
        
        if intValue <= 999_999 {
            let XXX_000 = (intValue - intValue % 1000) / 1000
            let XXX = intValue - 1000 * XXX_000
            var ret = ""
            if XXX_000 == 1 {
                ret = "ein"
            } else {
                ret = toStringLowercase(XXX_000)!
            }
            ret += "\u{AD}" + "tausend" + "\u{AD}"
            if XXX > 0 {
                ret += toStringLowercase(XXX)!
            }
            return ret
        }
        
        if intValue <= 999_999_999 {
            // Above a million, the number is seperated
            let XXX_000_000 = (intValue - intValue % 1_000_000) / 1_000_000
            let XXX_000 = intValue - 1_000_000 * XXX_000_000
            var ret = ""
            if XXX_000_000 == 1 {
                ret += "eine Million"
            } else {
                ret += toString(XXX_000_000)! + " Millionen"
            }
            if XXX_000 > 0 {
                ret += " " + toStringLowercase(XXX_000)!
            }
            return ret
        }
        
        if intValue <= 999_999_999_999 {
            let XXX_000_000_000 = (intValue - intValue % 1_000_000_000) / 1_000_000_000
            let XXX_000_000 = intValue - 1_000_000_000 * XXX_000_000_000
            var ret = ""
            if XXX_000_000_000 == 1 {
                ret += "eine Milliarde"
            } else {
                ret += toStringLowercase(XXX_000_000_000)!
                ret += " " + "Milliarden"
            }
            if XXX_000_000 > 0 {
                ret += " " + toStringLowercase(XXX_000_000)!
            }
            return ret
        }
        
        return nil
    }
    
    func toString(_ intValue: Int) -> String? {
        var wasNegative = false
        if intValue < 0 {
            wasNegative = true
        }
        let lowercase: String
        if wasNegative {
            lowercase = toStringLowercase(-intValue)!
        } else {
            lowercase = toStringLowercase(intValue)!
        }
        var ret = lowercase.firstCapitalized
        if wasNegative {
            ret = "Minus " + ret
        }
        return ret
    }

    func translate(_ string: String) -> String? {
        let groupSeparator = groupingSeparator.string
        let strippedString = string.replacingOccurrences(of: groupSeparator, with: "")
        let intValue = Int(strippedString)
        if intValue != nil {
            return toString(intValue!)
        }
        return nil;
    }
    
}


extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}
