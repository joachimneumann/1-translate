//
//  TranslateDanish.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/15/23.
//

import SwiftUI

class TranslateDanish: GeneralTranslator {
    let oneHundred  = "hundred"
    let hundred     = "hundrede"
    let oneThousand = "ettusind"
    let thousand    = "tusind"
    let million     = "million"
    let billion     = "milliard"

    init() {
        super.init(
            language: "Dansk",
            dotString: "komma",
            negativeString: "minus",
            andSoOn: "og så videre",
            exponentString: "gange ti i")
    }

    private func tens(_ intValue: Int) -> String? {
        switch intValue {
        case 1:     return "ti"
        case 2:     return "tyve"
        case 3:     return "tredive"
        case 4:     return "fyrre"
        case 5:     return "halvtreds"
        case 6:     return "tres"
        case 7:     return "halvfjerds"
        case 8:     return "firs"
        case 9:     return "halvfems"
        default: return nil
        }
    }

    func translate_0_20(_ i: Int) -> String? {
        switch i {
        case 0:     return "nul"
        case 1:     return "en"
        case 2:     return "to"
        case 3:     return "tre"
        case 4:     return "fire"
        case 5:     return "fem"
        case 6:     return "seks"
        case 7:     return "syv"
        case 8:     return "otte"
        case 9:     return "ni"
        case 10:    return "ti"
        case 11:    return "elleve"
        case 12:    return "tolv"
        case 13:    return "tretten"
        case 14:    return "fjorten"
        case 15:    return "femten"
        case 16:    return "seksten"
        case 17:    return "sytten"
        case 18:    return "atten"
        case 19:    return "nitten"
        case 20:    return "tyve"
        default:
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            var ret = tens(X0)!
            if X > 0 {
                ret += " " + translate_0_20(X)!
            }
            return ret
        }
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        if i <= 20 {
            return translate_0_20(i)//, fromLargerNumber: fromLargerNumber)
        }
        if i <= 99 {
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            if X == 0 {
                return tens(X0)!
            } else {
                return translate_0_20(X)! + "og" + tens(X0)!
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
            if X00 == 1 {
                ret = oneHundred
            } else {
                ret = translate_0_20(X00)! + " " + hundred
            }
            let leftover = 10 * X0 + X
            if leftover > 0 {
                ret += " og "+translatePositiveInteger(leftover)!//, fromLargerNumber: fromLargerNumber)!
            }
            return ret
        }
        
        if i <= 999_999 {
            let XXX_000 = (i - i % 1000) / 1000
            let XXX = i - 1000 * XXX_000
            
            var ret = ""
            switch XXX_000 {
            case 1:
                ret = oneThousand
            default:
                ret = translatePositiveInteger(XXX_000)! + " " + thousand
            }
            if XXX > 0 {
                ret += " og " + translatePositiveInteger(XXX)!
            }
            return ret
        }
        
        if i <= 999_999_999 {
            // Above a million, the number is seperated
            let XXX_000_000 = (i - i % 1_000_000) / 1_000_000
            let XXX_000 = i - 1_000_000 * XXX_000_000
            var ret = ""
            if XXX_000_000 == 1 {
                ret += million
            } else {
                ret += translate(XXX_000_000)! + " " + million
            }
            if XXX_000 > 0 {
                ret += " og " + translatePositiveInteger(XXX_000)!
            }
            return ret
        }
        
        let XXX_000_000_000 = (i - i % 1_000_000_000) / 1_000_000_000
        let XXX_000_000 = i - 1_000_000_000 * XXX_000_000_000
        var ret = ""
        if XXX_000_000_000 == 1 {
            ret += billion
        } else {
            ret += translatePositiveInteger(XXX_000_000_000)!
            ret += " " + billion
        }
        if XXX_000_000 > 0 {
            ret += " og " + translatePositiveInteger(XXX_000_000)!
        }
        return ret
    }
        
}
