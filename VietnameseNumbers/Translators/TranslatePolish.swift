//
//  TranslatePolish.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/15/23.
//

import Foundation

import SwiftUI

class TranslatePolish: GeneralTranslator {
    let hundred        = "sto"
    let thousand       = "tysiąc"
    let thousandTo4    = "tysiące"
    let thousandFrom5  = "tysięcy"
    let million        = "miliony"
    let billion        = "miliardów"

    init() {
        super.init(
            language: "Polski",
            dotString: "przecinek",
            negativeString: "minus",
            andSoOn: "and so on",
            exponentString: "times ten to the power of")
    }

    private func tens(_ intValue: Int) -> String? {
        switch intValue {
        case 1:     return "dziesięć"
        case 2:     return "dwadzieścia"
        case 3:     return "trzydzieści"
        case 4:     return "czterdzieści"
        case 5:     return "pięćdziesiąt"
        case 6:     return "sześćdziesiąt"
        case 7:     return "siedemdziesiąt"
        case 8:     return "osiemdziesiąt"
        case 9:     return "dziewięćdziesiąt"
        default: return nil
        }
    }

    func translate_0_20(_ i: Int) -> String? {
        switch i {
        case 0:     return "zero"
        case 1:     return "jeden"
        case 2:     return "dwa"
        case 3:     return "trzy"
        case 4:     return "cztery"
        case 5:     return "pięć"
        case 6:     return "sześć"
        case 7:     return "siedem"
        case 8:     return "osiem"
        case 9:     return "dziewięć"
        case 10:    return "dziesięć"
        case 11:    return "jedenaście"
        case 12:    return "dwanaście"
        case 13:    return "trzynaście"
        case 14:    return "czternaście"
        case 15:    return "piętnaście"
        case 16:    return "szesnaście"
        case 17:    return "siedemnaście"
        case 18:    return "osiemnaście"
        case 19:    return "dziewiętnaście"
        case 20:    return "dwadzieścia"
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
                return tens(X0)! + " " + translate_0_20(X)!
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
                ret = hundred
            case 2:
                ret = "dwieście"
            case 3, 4:
                ret = translate_0_20(X00)! + "sta"
            case 9:
                ret = "dziewięćset"
            default:
                ret = translate_0_20(X00)! + "set"
            }
            let leftover = 10 * X0 + X
            if leftover > 0 {
                ret += " " + translatePositiveInteger(leftover)!//, fromLargerNumber: fromLargerNumber)!
            }
            return ret
        }
        
        if i <= 999_999 {
            let XXX_000 = (i - i % 1000) / 1000
            let XXX = i - 1000 * XXX_000
            
            let lastDigitOfTousands = XXX_000 % 10
            let secondDigitOfTousands = XXX_000 % 100 - lastDigitOfTousands

            var polishThousand = ""
            if secondDigitOfTousands == 0 {
                switch lastDigitOfTousands {
                case 0:
                    polishThousand = thousandFrom5
                case 1:
                    polishThousand = XXX_000 == 1 ? thousand : thousandFrom5
                case 2, 3, 4:
                    polishThousand = thousandTo4
                default:
                    polishThousand = thousandFrom5
                }
            } else {
                polishThousand = thousandFrom5
            }
            
            var ret = ""
            switch XXX_000 {
            case 1:
                ret = polishThousand
            default:
                ret = translatePositiveInteger(XXX_000)! + " " + polishThousand
            }
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
                ret += million
            } else {
                ret += translate(XXX_000_000)! + " " + million
            }
            if XXX_000 > 0 {
                ret += " " + translatePositiveInteger(XXX_000)!
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
            ret += " " + translatePositiveInteger(XXX_000_000)!
        }
        return ret    }
        
}
