//
//  TranslateCatalan.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/14/23.
//

import Foundation

class TranslateCatalan: GeneralTranslator {
    init() {
        super.init(
            language: Languages.catalan.rawValue,
            imageName: "catalan flag",
            dotString: "punt",
            negativeString: "menys",
            andSoOn: "etcètera",
            exponentString: "vegades deu a la potència de")
    }
    
    private func catalan_0_20(_ intValue: Int) -> String? {
        switch intValue {
        case 0:     return "zero"
        case 1:     return "un"
        case 2:     return "dos"
        case 3:     return "tres"
        case 4:     return "quatre"
        case 5:     return "cinc"
        case 6:     return "sis"
        case 7:     return "set"
        case 8:     return "vuit"
        case 9:     return "nou"
        case 10:    return "deu"
        case 11:    return "onze"
        case 12:    return "dotze"
        case 13:    return "tretze"
        case 14:    return "catorze"
        case 15:    return "quinze"
        case 16:    return "setze"
        case 17:    return "disset"
        case 18:    return "divuit"
        case 19:    return "dinou"
        case 20:    return "vint"
        default: return nil
        }
    }
    
    private func catalan_tens(_ intValue: Int) -> String? {
        switch intValue {
        case 1:     return "deu"
        case 2:     return "vint"
        case 3:     return "trenta"
        case 4:     return "quaranta"
        case 5:     return "cinquanta"
        case 6:     return "seixanta"
        case 7:     return "setanta"
        case 8:     return "vuitanta"
        case 9:     return "noranta"
        default: return nil
        }
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        if i <= 20 {
            return catalan_0_20(i)
        }
        
        if i <= 99 {
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            if X == 0 {
                return catalan_tens(X0)!
            } else {
                if X0 == 2 {
                    return "vint-i-" + catalan_0_20(X)!
                } else {
                    return catalan_tens(X0)! + "-" + catalan_0_20(X)!
                }
            }
        }
        
        if i <= 999 {
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            temp = (temp - X0) / 10
            let X00 = temp % 10
            var ret = ""
            switch X00 {
            case 1:
                ret = "cent"
            case 9:
                ret = "nou-cents"
            default:
                ret = catalan_0_20(X00)! + "-cents"
            }
            let leftover = 10 * X0 + X
            if leftover > 0 {
                ret += " " + translatePositiveInteger(leftover)!
            }
            return ret
        }
        
        if i <= 999_999 {
            let XXX_000 = (i - i % 1000) / 1000
            let XXX = i - 1000 * XXX_000
            var ret = ""
            if XXX_000 == 1 {
                ret = ""
            } else {
                ret = translatePositiveInteger(XXX_000)! + " "
            }
            ret += "mil"
            if XXX > 0 {
                ret += " " + translatePositiveInteger(XXX)!
            }
            return ret
        }

//        if i <= 999_999_999 {
            // Above a million, the number is seperated
            let XXX_000_000 = (i - i % 1_000_000) / 1_000_000
            let XXX_000 = i - 1_000_000 * XXX_000_000
            var ret = ""
            if XXX_000_000 == 1 {
                ret += "un milió"
            } else {
                ret += translate(XXX_000_000)! + " milió"
            }
            if XXX_000 > 0 {
                ret += " " + translatePositiveInteger(XXX_000)!
            }
            return ret
//        }
//
//        // Above a million, the number is seperated
//        let XXX_000_000_000 = (i - i % 1_000_000_000) / 1_000_000_000
//        let XXX_000_000 = i - 1_000_000_000 * XXX_000_000_000
//        var ret = ""
//        if XXX_000_000_000 == 1 {
//            ret += "un billion"
//        } else {
//            ret += translate(XXX_000_000_000)! + " billion"
//        }
//        if XXX_000_000 > 0 {
//            ret += " " + translatePositiveInteger(XXX_000_000)!
//        }
//        return ret
    }
        
}
