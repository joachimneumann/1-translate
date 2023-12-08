//
//  TranslateGerman.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/8/23.
//

import SwiftUI

class TranslateGerman: Translator, ObservableObject {
    var dotString: String
    var negativeString: String
    var andSoOn: String
    var groupSeparator: String
    var decimalSeparator: String
    var useSoftHyphen: Bool = true

    private var softHyphen: String {
        useSoftHyphen ? "\u{AD}" : ""
    }

    required init(separators: Separators) {
        self.dotString = "Komma"
        self.negativeString = "Minus"
        self.andSoOn = "und so weiter"
        groupSeparator = separators.groupingSeparator.string
        decimalSeparator = separators.decimalSeparator.string
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
                return german_0_20(X)! + softHyphen + "und" + softHyphen + german_tens(X0)! // softHyphen is a soft hyphen
            }
        }
        if intValue <= 999 {
            var temp = intValue
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            temp = (temp - X0) / 10
            let X00 = temp % 10
            var ret = german_0_20(X00)! + softHyphen + "hundert" + softHyphen
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
            ret += softHyphen + "tausend" + softHyphen
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
                ret += translate(XXX_000_000)! + " Millionen"
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
    
    func translatePositiveInteger(_ i: Int) -> String? {
        let lowercase = toStringLowercase(i)!
        return lowercase.firstCapitalized
    }
}

