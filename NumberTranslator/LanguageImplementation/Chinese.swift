//
//  Chinese.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class ChineseImplementation: Group3Language  {
    var secondLast = "零"
    let variant: Variant
    
    init(variant: Variant) {
        self.variant = variant
        super.init()
        name = variant.name
        use_single_hundreds = true
        use_single_group = true
        before_hundreds = ""
        negativeString = "负"
        dotString = "点"
        exponentString = " 乘以 十的 "
    }
    
    override func _0_9(_ i: UInt) -> String {
        return variant._0_9(i)
    }
    
    override func _10s(_ i: UInt) -> String {
        return _0_9(i) + variant.e1
    }
    
    override func fromUInt(_ i: UInt) -> String {
        return fromUInt(i, is_largest_group: true)
    }
    
    private func fromUInt(_ i: UInt, is_largest_group: Bool) -> String {
        var ret = ""
        if i <= 999 {
            return ret + _0_999(i, is_largest_group: is_largest_group)
        }

        if i <= 9_999 {
            let left = i / 1_000
            let right = i - left * 1_000
            ret = _0_9(left) + variant.e3
            if right > 0 {
                ret += " "
                if right < 100 {
                    ret += secondLast
                }
                ret += _0_999(right, is_largest_group: false)
            }
            return ret
        }

        if i <= 99_999_999 {
            let left = i / 10_000
            let right = i - left * 10_000
            ret = fromUInt(left, is_largest_group: is_largest_group) + variant.e4
            if right > 0 {
                ret += " "
                if right < 1000 {
                    ret += secondLast
                }
                ret += fromUInt(right, is_largest_group: false)
            }
            return ret
        }
        
        if i <= 9999_9999_9999 {
            let left = i / 1_0000_0000
            let right = i - left * 1_0000_0000
            ret = fromUInt(left, is_largest_group: is_largest_group) + variant.e8
            if right > 0 {
                ret += " "
                if right < 1000_0000 {
                    ret += secondLast
                }
                ret += fromUInt(right, is_largest_group: false)
            }
            return ret
        }

        let left = i / 1_0000_0000_0000
        let right = i - left * 1_0000_0000_0000
        ret = fromUInt(left, is_largest_group: is_largest_group) + variant.e12
        if right > 0 {
            ret += " "
            if right < 1000_0000_0000 {
                ret += secondLast
            }
            ret += fromUInt(right, is_largest_group: false)
        }
        return ret
    }
    
    override func _100_999(_ i: UInt) -> String {
        after_hundreds = " "
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if below > 0 {
            if below <= 9 {
                after_hundreds = " " + secondLast
            }
        }
        return super._100_999(i)
    }
    
    private func _0_999(_ i: UInt, is_largest_group: Bool) -> String {
        var ret = ""
        if i <= 9 {
            ret += variant._0_9(i)
            return ret
        }
        
        if i <= 19 {
            if !is_largest_group {
                ret += variant._0_9(1)
            }
            ret += variant.e1
            if i % 10 > 0 {
                ret += variant._0_9(i % 10)
            }
            return ret
        }
        
        if i <= 99 {
            ret += _20_99(i)
            return ret
        }
        
        return _100_999(i)//.E(2), below: i.Ex(2))
        
    }
    
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 0:
            return ""
        case 2:
            return variant.e2
        case 3:
            return variant.e3
        case 8:
            return variant.e8
        case 12:
            return variant.e12
        default: return nil
        }
    }
    
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
        var zero: String? {
            switch self {
            case .traditional, .financial: "零"
            case .simplified:  "〇"
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
        func _0_9(_ i: UInt) -> String {
            switch i {
            case 0:
                zero!
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
            default:
                fatalError("Variant _0_9() parameter \(i)")
            }
        }
    }
}
    
