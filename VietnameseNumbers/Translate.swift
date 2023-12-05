//
//  Translate.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

import Foundation

class Vietnamese {
    var linh_instead_of_lẻ: Bool
    var ngàn_instead_of_nghìn: Bool
    
    private let one = "một"
    private let one_with_up_tone = "mốt"
    private let ten = "mười"
    private let ten_no_tone = "mươi"
    private let hundred = "trăm"
    private var secondlastZero: String {
        linh_instead_of_lẻ ? "linh" : "lẻ"
    }
    private var thousand: String {
        ngàn_instead_of_nghìn ? "ngàn" : "nghìn"
    }
    let million = "triệu"
    let billion = "tỷ"

    init(linh_instread_of_lẻ: Bool = false, ngàn_instead_of_nghìn: Bool = false) {
        self.linh_instead_of_lẻ = linh_instread_of_lẻ
        self.ngàn_instead_of_nghìn = ngàn_instead_of_nghìn
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
            temp = (temp - X00) / 10
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
                    ret += toString(X0)! + " " + ten_no_tone
                    if X > 0 {
                        ret += " " + toString_0_10(X, one_up_tone: true, lăm: true)!
                    }
                } else {
                    ret += ten
                    if X > 0 {
                        ret += " " + toString_0_10(X, one_up_tone: false, lăm: true)!
                    }
                }
            } else {
                // lẻ?
                if ret.count > 0 { ret += " " }
                if X > 0 {
                    ret += secondlastZero + " "
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
            var ret = toString(XXX_000)! + " " + thousand
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
        let intValue = Int(string)
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

