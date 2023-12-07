//
//  Translate.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

///
/// TODOs:
///  Vietamese: kleinerer Numer Font, 000 separator
///  English translation
///  Country selectrion
///  Reading the text
///
///  in VietnameseDisplay: only show
///  Model for translation, translation happens there. No dependencies to screen or viewmodel.
///  test: no need for screen

import Foundation

protocol Translator {
    func toString(_ string: String) -> String?
    func toString(_ int: Int) -> String?
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
    let groupingSeparator: GroupingSeparator
    let thousand: VietnameseThousand
    let secondLast: VietnameseSecondLast
    let compact: Bool
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
    
    func toString(_ intValue: Int) -> String? {
        toString(intValue, fromLargerNumber: false)
    }

    func toString(_ intValue: Int, fromLargerNumber: Bool = false) -> String? {
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
                ret += toString(X00)! + " " + hundred
            } else {
                if fromLargerNumber || ret.count > 0 {
                    if ret.count > 0 { ret += " " }
                    ret += toString(0)! + " " + hundred
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
                    ret += toString(X0)! + between
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
                    ret += toString(X)!
                } else {
                    ret += toString(0)!
                }
            }
            return ret
        }
        
        if intValue <= 999_999 {
            let XXX = intValue % 1_000
            let XXX_000 = (intValue - XXX) / 1_000
            var ret = toString(XXX_000, fromLargerNumber: fromLargerNumber)! + " " + thousand.string
            if XXX > 0 {
                ret += " " + toString(XXX, fromLargerNumber: true)!
            }
            return ret
        }

        if intValue <= 999_999_999 {
            let XXX_XXX = intValue % 1_000_000
            let XXX_000_000 = (intValue - XXX_XXX) / 1_000_000
            var ret = toString(XXX_000_000)! + " " + million
            if XXX_XXX > 0 {
                ret += " " + toString(XXX_XXX, fromLargerNumber: true)!
            }
            return ret
        }

        if intValue <= 999_999_999_999 {
            let XXX_XXX_XXX = intValue % 1_000_000_000
            let XXX_000_000_000 = (intValue - XXX_XXX_XXX) / 1_000_000_000
            var ret = toString(XXX_000_000_000)! + " " + billion
            if XXX_XXX_XXX > 0 {
                ret += " " + toString(XXX_XXX_XXX, fromLargerNumber: true)!
            }
            return ret
        }

        return nil
    }

    func toString(_ string: String) -> String? {
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
    let groupingSeparator: GroupingSeparator
    enum Variant {
        case british, american
    }
    
    private let zero = "zero"
    private let one = "one"
    private let ten = "ten"
    private let hundred = "hundred"
    private let thousand = "thousand"
    private let million = "million"
    private let billion = "billion"

    private var variant: Variant
    
    init(groupingSeparator: GroupingSeparator, variant: Variant = Variant.american) {
        self.groupingSeparator = groupingSeparator
        self.variant = variant
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
    
    func toString(_ intValue: Int) -> String? {
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
                ret += " " + toString(leftover)!
            }
            return ret
        }
        
        if intValue <= 999_999 {
            let XXX_000 = (intValue - intValue % 1000) / 1000
            let XXX = intValue - 1000 * XXX_000
            var ret = toString(XXX_000)! + " " + thousand
            if XXX > 0 {
                ret += " " + toString(XXX)!
            }
            return ret
        }

        if intValue <= 999_999_999 {
            let XXX_000_000 = (intValue - intValue % 1_000_000) / 1_000_000
            let XXX_000 = intValue - 1_000_000 * XXX_000_000
            var ret = toString(XXX_000_000)! + " " + million
            if XXX_000 > 0 {
                ret += " " + toString(XXX_000)!
            }
            return ret
        }

        if intValue <= 999_999_999_999 {
            let XXX_000_000_000 = (intValue - intValue % 1_000_000_000) / 1_000_000_000
            let XXX_000_000 = intValue - 1_000_000_000 * XXX_000_000_000
            var ret = toString(XXX_000_000_000)! + " " + billion
            if XXX_000_000 > 0 {
                ret += " " + toString(XXX_000_000)!
            }
            return ret
        }

        return nil
    }
    
    func toString(_ string: String) -> String? {
        let groupSeparator = groupingSeparator.string
        let strippedString = string.replacingOccurrences(of: groupSeparator, with: "")
        let intValue = Int(strippedString)
        if intValue != nil {
            return toString(intValue!)
        }
        return nil;
    }

}


private func english_0_9(_ intValue: Int) -> String? {
    switch intValue {
    case 0:     return "zero"
    case 1:     return "one"
    case 2:     return "two"
    case 3:     return "three"
    case 4:     return "four"
    case 5:     return "five"
    case 6:     return "six"
    case 7:     return "seven"
    case 8:     return "eight"
    case 9:     return "nine"
    default: return nil
    }
}

private func english_10_20(_ intValue: Int) -> String? {
    switch intValue {
    case 10:    return "ten"
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


func english(_ intValue: Int) -> String? {
    if intValue < 0 { return nil }
    if intValue < 10 {
        return english_0_9(intValue)
    }
    if intValue <= 20 {
        return english_10_20(intValue)
    }
    if intValue <= 99 {
        let lastDigit = intValue % 10
        let tener = (intValue - lastDigit) / 10
        
        if lastDigit == 0 {
            return english_tens(tener)
        } else {
            return english_tens(tener)! + " " +
            english_0_9(lastDigit)!
        }
    }
    if intValue <= 999 {
        let lastDigit = intValue % 10
        let tenDigit = ( (intValue - lastDigit) / 10 ) % 10
        let hundredDigit = (intValue - 10 * tenDigit - lastDigit) / 100
        var ret = english_0_9(hundredDigit)! + " hundred"

        let leftover = intValue - 100 * hundredDigit
        if leftover > 0 {
            ret += " " + english(leftover)!
        }
        return ret
    }
    return nil
}

func english(_ string: String) -> String? {
    let intValue = Int(string)
    if intValue != nil {
        return english(intValue!)
    }
    return nil;
}

