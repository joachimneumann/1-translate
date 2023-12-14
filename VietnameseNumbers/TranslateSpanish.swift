//
//  TranslateSpanish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/10/23.
//

import Foundation

class TranslateSpanish: GeneralTranslator {
    init() {
        super.init(
            language: Languages.spanish.rawValue,
            imageName: "spain flag",
            dotString: "punto",
            negativeString: "menos",
            andSoOn: "y así",
            exponentString: "por diez elevado a")
    }
    
    private func spanish_0_20(_ intValue: Int, fromLargerNumber: Bool = false) -> String? {
        switch intValue {
        case 0:     return "cero"
        case 1:     return "uno"
        case 2:     return fromLargerNumber ? "dós" : "dos"
        case 3:     return fromLargerNumber ? "trés" : "tres"
        case 4:     return "cuatro"
        case 5:     return "cinco"
        case 6:     return fromLargerNumber ? "séis" : "seis"
        case 7:     return "siete"
        case 8:     return "ocho"
        case 9:     return "nueve"
        case 10:    return "diez"
        case 11:    return "once"
        case 12:    return "doce"
        case 13:    return "trece"
        case 14:    return "catorce"
        case 15:    return "quince"
        case 16:    return "dieciséis"
        case 17:    return "diecisiete"
        case 18:    return "dieciocho"
        case 19:    return "diecinueve"
        case 20:    return "veinte"
        default: return nil
        }
    }
    
    private func spanish_tens(_ intValue: Int) -> String? {
        switch intValue {
        case 1:     return "diez"
        case 2:     return "veinte"
        case 3:     return "treinta"
        case 4:     return "cuarenta"
        case 5:     return "cincuenta"
        case 6:     return "sesenta"
        case 7:     return "setenta"
        case 8:     return "ochenta"
        case 9:     return "noventa"
        default: return nil
        }
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        if i <= 20 {
            return spanish_0_20(i)
        }
        
        if i <= 99 {
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            if X == 0 {
                return spanish_tens(X0)!
            } else {
                if X0 == 2 {
                    return "veinti" + spanish_0_20(X, fromLargerNumber: true)!
                } else {
                    return spanish_tens(X0)! + " y " + spanish_0_20(X)!
                }
            }
        }
        
        if i == 100 {
            return "cien"
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
                ret = "ciento"
            case 5:
                ret = "quinientos"
            case 7:
                ret = "setecientos"
            case 9:
                ret = "novecientos"
            default:
                ret = spanish_0_20(X00)! + "cientos"
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

        if i <= 999_999_999 {
            // Above a million, the number is seperated
            let XXX_000_000 = (i - i % 1_000_000) / 1_000_000
            let XXX_000 = i - 1_000_000 * XXX_000_000
            var ret = ""
            if XXX_000_000 == 1 {
                ret += "un millón"
            } else {
                ret += translate(XXX_000_000)! + " millones"
            }
            if XXX_000 > 0 {
                ret += " " + translatePositiveInteger(XXX_000)!
            }
            return ret
        }

        // Above a million, the number is seperated
        let XXX_000_000_000 = (i - i % 1_000_000_000) / 1_000_000_000
        let XXX_000_000 = i - 1_000_000_000 * XXX_000_000_000
        var ret = ""
        if XXX_000_000_000 == 1 {
            ret += "mil millones"
        } else {
            ret += translate(XXX_000_000_000)! + " mil millones"
        }
        if XXX_000_000 > 0 {
            ret += " " + translatePositiveInteger(XXX_000_000)!
        }
        return ret
    }
        
}
