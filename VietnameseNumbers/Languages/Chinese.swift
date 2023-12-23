//
//  Chinese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/23/23.
//

import Foundation

class Chinese: Language {

    enum Variant {
        case traditional
        case simplified
        case financial
        var name: String {
            switch self {
            case .traditional: "傳統中國"
            case .simplified:  "简体中文"
            case .financial:   "金融的"
            }
        }
        var englishName: String {
            switch self {
            case .traditional: "Traditional Chinese"
            case .simplified:  "Simplified Chinese"
            case .financial:   "Financial Chinese"
            }
        }
        var e1: String {
            switch self {
            case .traditional, .simplified:  "十"
            case .financial:   "拾"
            }
        }
        var e2: String {
            switch self {
            case .traditional, .simplified:  "百"
            case .financial:   "佰"
            }
        }
        var e3: String {
            switch self {
            case .traditional, .simplified:  "千"
            case .financial:   "仟"
            }
        }
        var e4: String {
            switch self {
            case .traditional: "萬"
            case .simplified:  "万"
            case .financial:   "萬"
            }
        }
        func read_0_9(_ i: Int) -> String {
            switch i {
            case 0:
                switch self {
                case .traditional, .financial: "零"
                case .simplified:  "〇"
                }
            case 1:
                switch self {
                case .traditional, .simplified: "一"
                case .financial:   "壹"
                }
            case 2:
                switch self {
                case .traditional, .simplified: "二"
                case .financial:   "壹"
                }
            case 3:
                switch self {
                case .traditional, .simplified: "三"
                case .financial:   "叁"
                }
            case 4:
                switch self {
                case .traditional, .simplified: "四"
                case .financial:   "肆"
                }
            case 5:
                switch self {
                case .traditional, .simplified: "五"
                case .financial:   "伍"
                }
            case 6:
                switch self {
                case .traditional, .simplified: "六"
                case .financial:   "陆"
                }
            case 7:
                switch self {
                case .traditional, .simplified: "七"
                case .financial:   "柒"
                }
            case 8:
                switch self {
                case .traditional, .simplified: "八"
                case .financial:   "捌"
                }
            case 9:
                switch self {
                case .traditional, .simplified: "九"
                case .financial:   "玖"
                }
            default: "not implemented"
            }
        }
    }

    let variant: Variant
    let filler = "零"

    init(variant: Variant) {
        self.variant = variant
        
        super.init(
            name: variant.name,
            negativeString: "负",
            dotString: "点",
            exponentString: " 乘以 十的 ",
            groupSeparator: "",
            decimalSeparator: ".")
        e2 = variant.e2
        e3 = variant.e3
        e4 = variant.e4
    }
    
    override func read_0_9(_ i: Int) -> String {
        return variant.read_0_9(i)
    }
    
    override func read_10s(_ i: Int) -> String {
        if i == 1 {
            return variant.e1
        } else {
            return read_0_9(i) + variant.e1
        }
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = read_0_9(i.E2) + e2!

        if i.E2x > 0 {
            ret += " "
            if i.secondLastDigit == 0 {
                ret += filler
            }
            ret += read(i.E2x)
        }
//        
//        let X00 = i / 100
//        let leftover = i - X00 * 100
//        if secondLastDigit == 0 {
//            fillerCharacter = filler
//        } else if secondLastDigit == 1 {
//            fillerCharacter = translate_0_10(1)
//        }
//        
//        var ret = translate(X00)! + hundred
//        if leftover > 0 {
//            ret += surroundingSpace + fillerCharacter + translate(leftover)!
//        }

        return ret
    }
//    
//    private func use(_ i: Int, _ s1: String, _ s2: String) -> String {
//        var use1 = false
//        switch i % 10 {
//        case 2, 3, 4:
//            use1 = true
//        default:
//            use1 = false
//        }
//        switch i % 100 {
//        case 11, 12, 13, 14:
//            use1 = false
//        default:
//            break
//        }
//        return use1 ? s1 : s2
//    }
//    
//    override func read_e3_e6(_ i: Int) -> String {
//        var ret = read(i.E3) + " " + use(i.E3, "tysiące", "tysięcy")
//        if i.E3 == 1 { ret = "tysiąc" }
//        if i.E3x > 0 { ret += " " + read(i.E3x) }
//        return ret
//    }
//    
//    override func read_e6_e9(_ i: Int) -> String {
//        var ret = read(i.E6) + " " + use(i.E6, "miliony", "milionów")
//        if i.E6 == 1 { ret = "jeden milion" }
//        if i.E6x > 0 { ret += " " + read(i.E6x) }
//        return ret
//    }
//    
//    override func read_e9_e12(_ i: Int) -> String {
//        var ret = read(i.E9) + " " + use(i.E9, "miliardy", "miliardów")
//        if i.E9 == 1 { ret = "jeden miliard" }
//        if i.E9x > 0 { ret += " " + read(i.E9x) }
//        return ret
//    }
//    
//    override func read_e12_e15(_ i: Int) -> String {
//        var ret = read(i.E12) + " " + use(i.E12, "biliony", "bilionów")
//        if i.E12 == 1 { ret = "jeden bilion" }
//        if i.E12x > 0 { ret += " " + read(i.E12x) }
//        return ret
//    }
}
