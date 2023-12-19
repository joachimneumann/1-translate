//
//  TranslatePolish.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/15/23.
//

import Foundation

import SwiftUI

class TranslatePolish: GeneralTranslator {

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
    
    func polish(power: Int, for number: Int) -> String {
        guard number >= 1 && number <= 999 else {
            return "Number out of range (1000 - 999000)"
        }
        
        if number == 1 {
            switch power {
            case 3:
                return "tysiąc"
            case 6:
                return "milion"
            case 9:
                return "miliard"
            case 12:
                return "bilion"
            default:
                return "Error"
            }
        }
        let lastTwoDigits = number % 100
        let lastDigit = lastTwoDigits % 10
        
        if (lastTwoDigits >= 12 && lastTwoDigits <= 14) || (lastTwoDigits % 10 >= 5 || lastTwoDigits % 10 == 0  || lastDigit == 1) {
            switch power {
            case 3:
                return "tysięcy"
            case 6:
                return "milionów"
            case 9:
                return "miliardów"
            case 12:
                return "bilionów"
            default:
                return "Error"
            }
        } else {
            switch power {
            case 3:
                return "tysiące"
            case 6:
                return "miliony"
            case 9:
                return "miliardy"
            case 12:
                return "biliony"
            default:
                return "Error"
            }
        }
    }
    
    private func _10(to exponent: Int) -> Int {
        return Int(pow(10.0, Double(exponent)))
    }
    
    private func topThree(number: Int, power: Int, useOne: Bool = true) -> String {
        let powerNumber = _10(to: power)
        let topThree = number / powerNumber
        let leftover = number - topThree * powerNumber
        let topName = polish(power: power, for: topThree)
        var ret: String
        if !useOne && topThree == 1 {
            ret = topName
        } else {
            ret = translatePositiveInteger(topThree)! + " " + topName
        }
        if leftover > 0 {
            ret += " " + translatePositiveInteger(leftover)!
        }
        return ret
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
            let hundreds = i / 100
            let leftover = i - hundreds * 100

            var ret = ""
            switch hundreds {
            case 1:
                ret = "sto"
            case 2:
                ret = "dwieście"
            case 3, 4:
                ret = translate_0_20(hundreds)! + "sta"
            default:
                ret = translate_0_20(hundreds)! + "set"
            }
            if leftover > 0 {
                ret += " " + translatePositiveInteger(leftover)!//, fromLargerNumber: fromLargerNumber)!
            }
            return ret
        }
        
        if i <= 999_999 {
            return topThree(number: i, power: 3, useOne: false)
        }
        
        if i <= 999_999_999 {
            return topThree(number: i, power: 6)
        }

        if i <= 999_999_999_999 {
            return topThree(number: i, power: 9)
        }
        
        return topThree(number: i, power: 12)
    }
        
}
