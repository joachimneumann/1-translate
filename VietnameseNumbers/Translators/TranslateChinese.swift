//
//  TranslateChinese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/18/23.
//

import SwiftUI

enum Variant {
    case traditional
    case simplified
    case financial
}

class TranslateChinese: GeneralTranslator {
    var hundred: String
    var thousand: String
    var tenThousand: String
    var hundredMillion: String
    let filler = "零"
    let variant: Variant
    let surroundingSpace = " "
    
    init(variant: Variant) {
        self.variant = variant
        let language: String
        let languageEnglish: String
        switch variant {
        case .traditional:
            language = "傳統中國"
            languageEnglish = "Traditional Chinese"
            hundred        = "百"
            thousand       = "千"
            tenThousand    = "萬"
            hundredMillion = "億"
        case .simplified:
            language = "简体中文"
            languageEnglish = "Simplified Chinese"
            hundred        = "百"
            thousand       = "千"
            tenThousand    = "万"
            hundredMillion = "亿"
        case .financial:
            language = "金融的"
            languageEnglish = "Financial Chinese"
            hundred        = "佰"
            thousand       = "仟"
            tenThousand    = "萬"
            hundredMillion = "億"
        }
        super.init(
            language: language,
            languageEnglish: languageEnglish,
            dotString: "点",
            negativeString: "负",
            andSoOn: "依此类推",
            exponentString: " 乘以 十的 ")
        exponentString2 = "次冪"
    }
    
    private func translate_0_10(_ intValue: Int) -> String {
        switch variant {
        case .traditional:
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
        case .simplified:
            switch intValue {
            case 0:     return "〇"
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
        case .financial:
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
                ret += surroundingSpace + fillerCharacter + translate(leftover)!
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
                ret += surroundingSpace + fillerCharacter + translate(leftover)!
            }
            return ret
        }
        
        if i <= 99_999_999 {
            let X0_000 = i / 10_000
            let leftover = i - X0_000 * 10_000
            
            var ret = ""
            ret += translate(X0_000)! + tenThousand
            if leftover > 0 {
                ret += surroundingSpace + translate(leftover)!
            }
            return ret
        }
        
        let X00_000_000 = i / 100_000_000
        let leftover = i - X00_000_000 * 100_000_000
        
        var ret = ""
        ret += translate(X00_000_000)! + hundredMillion
        if leftover > 0 {
            ret += surroundingSpace + translate(leftover)!
        }
        return ret
    }
}
