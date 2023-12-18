//
//  TranslateMandarin.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/18/23.
//

import SwiftUI

class TranslateMandarin: GeneralTranslator {
    let hundred     = "百"
    let filler      = "零"
    let thousand    = "千"
    let tenThousand = "万"
    let hundredMillion     = "亿"


    init() {
        super.init(
            language: "普通话",
            languageEnglish: "Mandarin",
            dotString: "点",
            negativeString: "减",
            andSoOn: "依此类推",
            exponentString: " e ")
    }
    
    private func translate_0_20(_ intValue: Int) -> String {
        switch intValue {
        case 0:     return "零"
        case 1:     return "一"
        case 2:     return "二"
        case 3:     return "三"
        case 4:     return "四"
        case 5:     return "五"
        case 6:     return "六"
        case 7:     return "七"
        case 8:     return "八"
        case 9:     return "九"
        case 10:    return "十"
        case 11:    return "十一"
        case 12:    return "十二"
        case 13:    return "十三"
        case 14:    return "十四"
        case 15:    return "十五"
        case 16:    return "十六"
        case 17:    return "十七"
        case 18:    return "十八"
        case 19:    return "十九"
        case 20:    return "二十"
        default: return "not implemented"
        }
    }
    
    
    private func tens(_ intValue: Int) -> String {
        switch intValue {
        case 1:     return "一十"
        case 2:     return "二十"
        case 3:     return "三十"
        case 4:     return "四十"
        case 5:     return "五十"
        case 6:     return "六十"
        case 7:     return "七十"
        case 8:     return "八十"
        case 9:     return "九十"
        default: return "not implemented"
        }
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        let secondLastDigit = (i / 10) % 10
        let thirdLastDigit = (i / 100) % 10

        var fillerCharacter = ""
        if i <= 20 {
            return translate_0_20(i)//, fromLargerNumber: fromLargerNumber)
        }
        if i <= 99 {
            let X0 = i / 10
            let leftover = i - X0 * 10

            if leftover > 0 {
                return tens(X0) + translate_0_20(leftover)
            } else {
                return tens(X0)
            }
        }

        if i <= 999 {
            let X00 = i / 100
            let leftover = i - X00 * 100
            if secondLastDigit == 0 {
                fillerCharacter = filler
            } else if secondLastDigit == 1 {
                fillerCharacter = translate_0_20(1)
            }
            
            var ret = translate(X00)! + hundred
            if leftover > 0 {
                ret += fillerCharacter + translate(leftover)!
            }
            return ret
        }
        
        if i <= 9_999 {
            let X000 = i / 1000
            let leftover = i - X000 * 1000
            
            if thirdLastDigit == 0 {
                fillerCharacter = filler
            }
            var ret = ""
            ret += translate(X000)! + thousand
            if leftover > 0 {
                ret += fillerCharacter + translate(leftover)!
            }
            return ret
        }

        if i <= 99_999_999 {
            let X0_000 = i / 10_000
            let leftover = i - X0_000 * 10_000
            
            var ret = ""
            ret += translate(X0_000)! + tenThousand
            if leftover > 0 {
                ret += translate(leftover)!
            }
            return ret
        }
        
        if i <= 999_999_999_999 {
            let X00_000_000 = i / 100_000_000
            let leftover = i - X00_000_000 * 100_000_000
            
            var ret = ""
            ret += translate(X00_000_000)! + hundredMillion
            if leftover > 0 {
                ret += translate(leftover)!
            }
            return ret
        }
        

//        if i <= 999_999_999 {
//            let X000_000 = i / 1_000_000
//            let leftover = i - X000_000 * 1_000_000
//            
//            var ret = ""
//            if X000_000 == 1 {
//                ret += translate(X000_000)! + " " + million
//            } else {
//                ret += translate(X000_000)! + " " + millions
//            }
//            if leftover > 0 {
//                ret += " " + translate(leftover)!
//            }
//            return ret
//        }
//
//        let X000_000_000 = i / 1_000_000_000
//        let leftover = i - X000_000_000 * 1_000_000_000
//        
//        var ret = ""
//        if X000_000_000 == 1 {
//            ret += translate(X000_000_000)! + " " + milliard
//        } else {
//            ret += translate(X000_000_000)! + " " + milliards
//        }
//        if leftover > 0 {
//            ret += " " + translate(leftover)!
//        }
        return "ret"
    }
}
