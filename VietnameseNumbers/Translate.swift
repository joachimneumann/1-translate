//
//  Translate.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

import Foundation

private func vietnamese_0_10(_ intValue: Int, mốt: Bool = false, lăm: Bool = false, mươi: Bool = false) -> String? {
    switch intValue {
    case 0:     return "không"
    case 1:     if mốt { return "mốt" } else { return "một" }
    case 2:     return "hai"
    case 3:     return "ba"
    case 4:     return "bốn"
    case 5:     if lăm { return "lăm" } else { return "năm" }
    case 6:     return "sáu"
    case 7:     return "bảy"
    case 8:     return "tám"
    case 9:     return "chín"
    case 10:    if mươi { return "mươi" } else { return "mười" }
    default: return nil
    }
}

func vietnamese(_ intValue: Int) -> String? {
    if intValue < 0 { return nil }
    if intValue <= 10 {
        return vietnamese_0_10(intValue)
    }
    if intValue < 20 {
        return vietnamese_0_10(10)! + " " +
        vietnamese_0_10(intValue - 10, mốt: false, lăm: true)!
    }
    if intValue <= 99 {
        let lastDigit = intValue % 10
        let tener = (intValue - lastDigit) / 10
        var ret = vietnamese_0_10(tener)! + " mươi"
        if lastDigit != 0 {
            ret += " " + vietnamese_0_10(lastDigit, mốt: true, lăm: true, mươi: true)!
        }
        return ret
    }
    if intValue <= 109 {
        let lastDigit = intValue % 10
        var ret = "một trăm"
        if lastDigit != 0 {
            ret += " lẻ " + vietnamese_0_10(lastDigit)!
        }
        return ret
    }
    if intValue <= 999 {
        let lastDigit = intValue % 10
        let tenDigit = ( (intValue - lastDigit) / 10 ) % 10
        let hundredDigit = (intValue - 10 * tenDigit - lastDigit) / 100
        var ret = vietnamese_0_10(hundredDigit)! + " trăm"
        let leftover = intValue - 100 * hundredDigit
        if leftover > 0 {
            ret += " " + vietnamese(leftover)!
        }
        return ret
    }
    return nil
}

func vietnamese(_ string: String) -> String? {
    let intValue = Int(string)
    if intValue != nil {
        return vietnamese(intValue!)
    }
    return nil;
}

private func english_0_9(_ intValue: Int) -> String? {
    switch intValue {
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
    default: return nil
    }
}

private func english_10_20(_ intValue: Int) -> String? {
    switch intValue {
    case 10:    return "ten"
    case 11:    return "eleven"
    case 12:    return "twelve"
    case 13:    return "thirteen"
    case 14:    return "fourteen"
    case 15:    return "fifteen"
    case 16:    return "sixteen"
    case 17:    return "seventeen"
    case 18:    return "eightteen"
    case 19:    return "nineteen"
    case 20:    return "twenty"
    default: return nil
    }
}


private func english_tens(_ intValue: Int) -> String? {
    switch intValue {
    case 1:     return "ten"
    case 2:     return "twenty"
    case 3:     return "thirty"
    case 4:     return "fourty"
    case 5:     return "fifty"
    case 6:     return "sixty"
    case 7:     return "seventy"
    case 8:     return "eighty"
    case 9:     return "ninety"
    default: return nil
    }
}


func english(_ intValue: Int) -> String? {
    if intValue < 0 { return nil }
    if intValue < 10 {
        return english_0_9(intValue)
    }
    if intValue <= 20 {
        return english_10_20(intValue)
    }
    if intValue <= 99 {
        let lastDigit = intValue % 10
        let tener = (intValue - lastDigit) / 10
        
        if lastDigit == 0 {
            return english_tens(tener)
        } else {
            return english_tens(tener)! + " " +
            english_0_9(lastDigit)!
        }
    }
    if intValue <= 999 {
        let lastDigit = intValue % 10
        let tenDigit = ( (intValue - lastDigit) / 10 ) % 10
        let hundredDigit = (intValue - 10 * tenDigit - lastDigit) / 100
        var ret = english_0_9(hundredDigit)! + " hundred"

        let leftover = intValue - 100 * hundredDigit
        if leftover > 0 {
            ret += " " + english(leftover)!
        }
        return ret
    }
    return nil
}

func english(_ string: String) -> String? {
    let intValue = Int(string)
    if intValue != nil {
        return english(intValue!)
    }
    return nil;
}

