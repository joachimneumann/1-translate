//
//  TranslateEnglish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/8/23.
//

import SwiftUI

class TranslateEnglish: HundredBasedTranslator {
    init() {
        super.init(
            language: "English",
            dotString: "point",
            negativeString: "minus",
            andSoOn: "and so on",
            exponentString: "times ten to the power of",
            hundred: "hundred",
            thousand: "thousand",
            million: "million",
            billion: "billion")
        beforeOneHundred = "one "
        beforeHundred = " "
        afterHundred = " "
    }

    private func english_tens(_ intValue: Int) -> String? {
        switch intValue {
        case 1:     return "ten"
        case 2:     return "twenty"
        case 3:     return "thirty"
        case 4:     return "forty"
        case 5:     return "fifty"
        case 6:     return "sixty"
        case 7:     return "seventy"
        case 8:     return "eighty"
        case 9:     return "ninety"
        default: return nil
        }
    }

    override func translatePositiveInteger_0_99(_ i: Int) -> String? {
        switch i {
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
        case 10:    return "ten"
        case 11:    return "eleven"
        case 12:    return "twelve"
        case 13:    return "thirteen"
        case 14:    return "fourteen"
        case 15:    return "fifteen"
        case 16:    return "sixteen"
        case 17:    return "seventeen"
        case 18:    return "eighteen"
        case 19:    return "nineteen"
        case 20:    return "twenty"
        default:
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            var ret = english_tens(X0)!
            if X > 0 {
                ret += "-" + translatePositiveInteger_0_99(X)!
            }
            return ret
        }
    }
}
