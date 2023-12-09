//
//  TranslateEnglish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/8/23.
//

import SwiftUI

class TranslateEnglish: GeneralTranslator {
    private let zero = "zero"
    private let one = "one"
    private let ten = "ten"
    private let hundred = "hundred"
    private let thousand = "thousand"
    private let million = "million"
    private let billion = "billion"
    var useAndAfterHundred: Bool = false
    
    init() {
        super.init(
            dotString: "point",
            negativeString: "minus",
            andSoOn: "and so on",
            exponentString: "times ten to the power of")
    }

//    override init(
//        dotString: String,
//        negativeString: String,
//        andSoOn: String,
//        exponentString: String,
//        groupSeparator: String,
//        decimalSeparator: String) {
//            super.init(
//                dotString: dotString,
//                negativeString: negativeString,
//                andSoOn: andSoOn,
//                exponentString: exponentString,
//                groupSeparator: groupSeparator,
//                decimalSeparator: decimalSeparator)
//        }

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
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        if i <= 20 {
            return english_0_20(i)
        }
        if i <= 99 {
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            var ret = english_tens(X0)!
            if X > 0 {
                ret += "-" + english_0_20(X)!
            }
            return ret
        }
        if i <= 999 {
            var temp = i
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
                ret += translate(leftover)!
            }
            return ret
        }
        
        if i <= 999_999 {
            let XXX_000 = (i - i % 1000) / 1000
            let XXX = i - 1000 * XXX_000
            var ret = translate(XXX_000)! + " " + thousand
            if XXX > 0 {
                ret += " " + translate(XXX)!
            }
            return ret
        }
        
        if i <= 999_999_999 {
            let XXX_000_000 = (i - i % 1_000_000) / 1_000_000
            let XXX_000 = i - 1_000_000 * XXX_000_000
            var ret = translate(XXX_000_000)! + " " + million
            if XXX_000 > 0 {
                ret += " " + translate(XXX_000)!
            }
            return ret
        }
        
        if i <= 999_999_999_999 {
            let XXX_000_000_000 = (i - i % 1_000_000_000) / 1_000_000_000
            let XXX_000_000 = i - 1_000_000_000 * XXX_000_000_000
            var ret = translate(XXX_000_000_000)! + " " + billion
            if XXX_000_000 > 0 {
                ret += " " + translate(XXX_000_000)!
            }
            return ret
        }
        return nil
    }
}
