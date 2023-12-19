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
    
    init() {
        super.init(
            language: "Polski",
            dotString: "przecinek",
            negativeString: "minus",
            exponentString: " razy dziesięć do potęgi ")
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
    
    func _e3(for e3: Int) -> String {
        guard e3 >= 1 && e3 <= 999 else {
            return "Number out of range (1000 - 999000)"
        }

        let lastTwoDigits = e3 % 100
        let lastDigit = lastTwoDigits % 10
        if e3 == 1 {
            return "tysiąc"
        }
        if (lastTwoDigits >= 12 && lastTwoDigits <= 14) || (lastTwoDigits % 10 >= 5 || lastTwoDigits % 10 == 0  || lastDigit == 1) {
            return "tysięcy"
        } else {
            return "tysiące"
        }
    }

    func _e6(for e6: Int) -> String {
        guard e6 >= 1 && e6 <= 999 else {
            return "Number out of range (1000 - 999000)"
        }

        let lastTwoDigits = e6 % 100
        let lastDigit = lastTwoDigits % 10
        if e6 == 1 {
            return "milion"
        }
        if (lastTwoDigits >= 12 && lastTwoDigits <= 14) || (lastTwoDigits % 10 >= 5 || lastTwoDigits % 10 == 0  || lastDigit == 1) {
            return "milionów"
        } else {
            return "miliony"
        }
    }

    func _e9(for e9: Int) -> String {
        guard e9 >= 1 && e9 <= 999 else {
            return "Number out of range (1000 - 999000)"
        }

        let lastTwoDigits = e9 % 100
        let lastDigit = lastTwoDigits % 10
        if e9 == 1 {
            return "miliard"
        }
        if (lastTwoDigits >= 12 && lastTwoDigits <= 14) || (lastTwoDigits % 10 >= 5 || lastTwoDigits % 10 == 0  || lastDigit == 1) {
            return "miliardów"
        } else {
            return "miliardy"
        }
    }


    func _e12(for e12: Int) -> String {
        guard e12 >= 1 && e12 <= 999 else {
            return "Number out of range (1000 - 999000)"
        }

        let lastTwoDigits = e12 % 100
        let lastDigit = lastTwoDigits % 10
        if e12 == 1 {
            return "bilion"
        }
        if (lastTwoDigits >= 12 && lastTwoDigits <= 14) || (lastTwoDigits % 10 >= 5 || lastTwoDigits % 10 == 0  || lastDigit == 1) {
            return "bilionów"
        } else {
            return "biliony"
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
            let XXX_000 = i / 1_000
            let leftover = i - XXX_000 * 1_000
            let _e3 = _e3(for: XXX_000)
            var ret = ""
            switch XXX_000 {
            case 1:
                ret = _e3
            default:
                ret = translatePositiveInteger(XXX_000)! + " " + _e3
            }
            if leftover > 0 {
                ret += " " + translatePositiveInteger(leftover)!
            }
            return ret
        }
        
        if i <= 999_999_999 {
            let XXX_000_000 = i / 1_000_000
            let leftover = i - XXX_000_000 * 1_000_000
            let _e6 = _e6(for: XXX_000_000)
            var ret = translatePositiveInteger(XXX_000_000)! + " " + _e6
            if leftover > 0 {
                ret += " " + translatePositiveInteger(leftover)!
            }
            return ret
        }

        if i <= 999_999_999_999 {
            let XXX_000_000_000 = i / 1_000_000_000
            let leftover = i - XXX_000_000_000 * 1_000_000_000
            let _e9 = _e9(for: XXX_000_000_000)
            var ret = translatePositiveInteger(XXX_000_000_000)! + " " + _e9
            if leftover > 0 {
                ret += " " + translatePositiveInteger(leftover)!
            }
            return ret
        }
        
        let XXX_000_000_000_000 = i / 1_000_000_000_000
        let leftover = i - XXX_000_000_000_000 * 1_000_000_000_000
        let _e12 = _e12(for: XXX_000_000_000_000)
        var ret = translatePositiveInteger(XXX_000_000_000_000)! + " " + _e12
        if leftover > 0 {
            ret += " " + translatePositiveInteger(leftover)!
        }
        return ret
    }
        
}
