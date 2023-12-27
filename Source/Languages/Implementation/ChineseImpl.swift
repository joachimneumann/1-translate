//
//  Chinese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/23/23.
//

import Foundation

class ChineseImpl: LanguageImpl {
    
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
        var e8: String {
            switch self {
            case .traditional, .financial: "億"
            case .simplified:  "亿"
            }
        }
        var e12: String {
           "兆"
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
            exponentString: " 乘以 十的 ")
        
        englishName = variant.englishName
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
    
    func read_trailing_tens(_ i: Int) -> String {
        var ret = readChinese(i)
        if i.E1 == 1 {
            ret = readChinese(1) + ret
        }
        return ret
    }
    
    override func read_10_99(_ i: Int) -> String {
        var ret = ""
        if i.E1 > 0 {
            ret = read_0_9(i.E1)
        }
        ret += variant.e1
        if i.E1x > 0 {
            ret += read_0_9(i.E1x)
        }
        return ret
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = read_0_9(i.E2) + variant.e2
        
        if i.E2x > 0 {
            ret += " "
            if i.E2x < 10 {
                ret += filler
            }
            ret += readChinese(i.E2x)
        }
        return ret
    }

    override func read_e3_e6(_ i: Int) -> String {
        var ret = readChinese(i.E3) + variant.e3
        
        if i.E3x > 0 {
            ret += " "
            if i.E3x < 100 {
                ret += filler
            }
            ret += readChinese(i.E3x)
        }
        return ret
    }
    
    private func readChinese(_ i: Int) -> String {
        var ret = ""
        if i < 10_000 {
            return super.readInteger(i)
        }

        if i < 100_000_000 {
            ret += readInteger(i.E4)
            ret += variant.e4
            if i.E4x > 0 {
                ret += " "
                if i.E4x < 1_000 {
                    ret += filler
                }
                ret += readChinese(i.E4x)
            }
            return ret
        }

        if i < 1_000_000_000_000 {
            ret += readInteger(i.E8)
            ret += variant.e8
            if i.E8x > 0 {
                ret += " "
                if i.E8x < 10_000_000 {
                    ret += filler
                }
                ret += readChinese(i.E8x)
            }
            return ret
        }

        ret += readChinese(i.E12)
        ret += variant.e12
        if i.E12x > 0 {
            ret += " "
            if i.E12x < 100_000_000_000 {
                ret += filler
            }
            ret += readChinese(i.E12x)
        }
        return ret
    }
    
    override func readInteger(_ i: Int) -> String {
        if i >= 10 && i < 20 {
            var ret = ""
            ret = super.readInteger(i)
            ret = String(ret.dropFirst())
            return ret
        } else {
            return readChinese(i)
        }
    }



}
