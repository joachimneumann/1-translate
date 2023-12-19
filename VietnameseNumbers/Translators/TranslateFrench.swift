//
//  TranslateFrench.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/18/23.
//

import SwiftUI

class TranslateFrench: GeneralTranslator {
    let hundred   = "cent"
    let hundreds  = "cents"
    let thousand  = "mille"
    let million   = "million"
    let millions  = "millions"
    let milliard  = "milliard"
    let milliards = "milliards"


    init() {
        super.init(
            language: "Française",
            dotString: "virgule",
            negativeString: "moins",
            exponentString: " fois dix à la puissance ")
    }
    
    private func translate_0_20(_ intValue: Int) -> String {
        switch intValue {
        case 0:     return "zéro"
        case 1:     return "un"
        case 2:     return "deux"
        case 3:     return "trois"
        case 4:     return "quatre"
        case 5:     return "cinq"
        case 6:     return "six"
        case 7:     return "sept"
        case 8:     return "huit"
        case 9:     return "neuf"
        case 10:    return "dix"
        case 11:    return "onze"
        case 12:    return "douze"
        case 13:    return "treize"
        case 14:    return "quatorze"
        case 15:    return "quinze"
        case 16:    return "seize"
        case 17:    return "dix-sept"
        case 18:    return "dix-huit"
        case 19:    return "dix-neuf"
        case 20:    return "vingt"
        default: return "not implemented"
        }
    }
    
    
    private func tens(_ intValue: Int) -> String {
        switch intValue {
        case 1:     return "dix"
        case 2:     return "vingt"
        case 3:     return "trente"
        case 4:     return "quarante"
        case 5:     return "cinquante"
        case 6:     return "soixante"
        case 7:     return "soixante-dix"
        case 8:     return "quatre-vingts"
        case 9:     return "quatre-vingt-dix"
        default: return "not implemented"
        }
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        if i <= 20 {
            return translate_0_20(i)//, fromLargerNumber: fromLargerNumber)
        }
        if i <= 99 {
            var temp = i
            var X = temp % 10
            temp = (temp - X) / 10
            var X0 = temp % 10
            if X0 == 7 || X0 == 9 {
                X0 -= 1
                X += 10
            }
            var tens = tens(X0)
            if X0 == 8 && X > 0 {
                tens = "quatre-vingt" // no tailing s
            }
            if X == 0 {
                return tens
            } else if X0 < 8 && (X == 1 || X == 11) {
                return tens + " et " + translate_0_20(X)
            } else {
                return tens + "-" + translate_0_20(X)
            }
        }

        if i <= 999 {
            let X00 = i / 100
            let leftover = i - X00 * 100
            
            var ret = ""
            if X00 == 1 {
                ret += hundred
            } else {
                ret += translate_0_20(X00) + " " + ((leftover > 0) ? hundred : hundreds)
            }
            if leftover > 0 {
                ret += " " + translate(leftover)!
            }
            return ret
        }
        
        if i <= 999_999 {
            let X000 = i / 1000
            let leftover = i - X000 * 1000
            
            var ret = ""
            if X000 == 1 {
                ret += thousand
            } else {
                ret += translate(X000)! + " " + thousand
            }
            if leftover > 0 {
                ret += " " + translate(leftover)!
            }
            return ret
        }

        if i <= 999_999_999 {
            let X000_000 = i / 1_000_000
            let leftover = i - X000_000 * 1_000_000
            
            var ret = ""
            if X000_000 == 1 {
                ret += translate(X000_000)! + " " + million
            } else {
                ret += translate(X000_000)! + " " + millions
            }
            if leftover > 0 {
                ret += " " + translate(leftover)!
            }
            return ret
        }

        let X000_000_000 = i / 1_000_000_000
        let leftover = i - X000_000_000 * 1_000_000_000
        
        var ret = ""
        if X000_000_000 == 1 {
            ret += translate(X000_000_000)! + " " + milliard
        } else {
            ret += translate(X000_000_000)! + " " + milliards
        }
        if leftover > 0 {
            ret += " " + translate(leftover)!
        }
        return ret
    }
}
