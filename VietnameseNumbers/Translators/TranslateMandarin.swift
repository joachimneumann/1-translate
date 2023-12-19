//
//  TranslateMandarin.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/18/23.
//

import SwiftUI

enum Variant {
    case simplified
    case financial
}

class TranslateMandarin: GeneralTranslator {
    var hundred        = "百"
    var thousand       = "千"
    var tenThousand    = "万"
    var hundredMillion = "亿"
    let filler         = "零"

    let variant: Variant

    init(variant: Variant) {
        self.variant = variant
        super.init(
            language: variant == .simplified ? "普通话" : "金融的",
            languageEnglish: variant == .simplified ? "Chinese" : "Financial",
            dotString: "点",
            negativeString: "减",
            andSoOn: "依此类推",
            exponentString: " e ")
        if variant == .financial {
            hundred        = "佰"
            thousand       = "仟"
            tenThousand    = "萬"
            hundredMillion = "億"
        }
    }
    
    private func translate_0_10(_ intValue: Int) -> String {
        if variant == .simplified {
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
            default: return "not implemented"
            }
        } else {
            switch intValue {
            case 0:     return "零"
            case 1:     return "壹"
            case 2:     return "壹"
            case 3:     return "叁"
            case 4:     return "肆"
            case 5:     return "伍"
            case 6:     return "陆"
            case 7:     return "柒"
            case 8:     return "捌"
            case 9:     return "玖"
            case 10:    return "拾"
            default: return "not implemented"
            }
        }
    }
    
    
    private func tens(_ intValue: Int) -> String {
        if intValue == 1 {
            return translate_0_10(10)
        } else {
            return translate_0_10(intValue) + translate_0_10(10)
        }
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        let secondLastDigit = (i / 10) % 10
        let thirdLastDigit = (i / 100) % 10

        var fillerCharacter = ""
        if i <= 10 {
            return translate_0_10(i)//, fromLargerNumber: fromLargerNumber)
        }
        if i <= 99 {
            let X0 = i / 10
            let leftover = i - X0 * 10

            if leftover > 0 {
                return tens(X0) + translate_0_10(leftover)
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
                fillerCharacter = translate_0_10(1)
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
