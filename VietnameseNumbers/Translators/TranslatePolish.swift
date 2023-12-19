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
    let thousand1      = "tysiąc"
    let thousandTo4    = "tysiące"
    let thousandFrom5  = "tysięcy"
    let million1       = "milion"
    let millionTo4     = "miliony"
    let millionFrom5   = "milionów"
    let billion        = "billion"

    // 1_000_000_000_000 --> this is billion in polish
    // 1_000_000_000 --> this is milliard in polish

    init() {
        super.init(
            language: "Polski",
            dotString: "przecinek",
            negativeString: "minus",
            andSoOn: "and so on",
            exponentString: " times ten to the power of ")
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
    
    func determineThousand(forThousands thousands: Int) -> String {
        guard thousands >= 1 && thousands <= 999 else {
            return "Number out of range (1000 - 999000)"
        }

        let lastTwoDigits = thousands % 100
        let lastDigit = lastTwoDigits % 10
        if thousands == 1 { return thousand1 }
        if (lastTwoDigits >= 12 && lastTwoDigits <= 14) || (lastTwoDigits % 10 >= 5 || lastTwoDigits % 10 == 0  || lastDigit == 1) {
            return thousandFrom5 // tysięcy
        } else {
            return thousandTo4 // tysiące
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
            
            let polishThousand = determineThousand(forThousands: XXX_000)

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
            let XXX_000_000 = (i - i % 1_000_000) / 1_000_000
            let XXX_000 = i - 1_000_000 * XXX_000_000
            
            let lastDigitOfMillions = XXX_000_000 % 10
            let secondLastDigitOfMillions = (XXX_000_000 - lastDigitOfMillions) % 10 

            var polishMillion = ""
            if secondLastDigitOfMillions == 0 {
                switch lastDigitOfMillions {
                case 0:
                    polishMillion = millionFrom5
                case 1:
                    polishMillion = XXX_000_000 == 1 ? million1 : millionFrom5
                case 2, 3, 4:
                    polishMillion = millionTo4
                default:
                    polishMillion = millionFrom5
                }
            } else {
                polishMillion = millionFrom5
            }

            var ret = ""
//            if XXX_000_000 == 1 {
//                ret += polishMillion
//            } else {
                ret += translate(XXX_000_000)! + " " + polishMillion
//            }
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
