//
//  Chinese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/23/23.
//

import Foundation

class ChineseImpl: LanguageImplGroup3 {

    var secondLast = "零"
    
    let variant: Variant

    init(variant: Variant) {
        self.variant = variant
        super.init(
            name: variant.name,
            groupSize: GroupSize.three,
            zero: variant.zero,
            negativeString: "负",
            dotString: "点",
            exponentString: " 乘以 十的 ")

        voiceLanguageCode = "zh"
        nameDescription = variant.englishName
        _20_99_connector = " "
        use_single_hundreds = true
        before_hundreds = ""
        use_single_group = true
        before_groupName = ""
    }
    
    private func _0_999(_ i: Int, is_largest_group: Bool) -> String {
        var ret = ""
        if !is_largest_group && i < 100 {
            ret += secondLast
        }
        if i <= 9 {
            ret += variant._0_9(i)
            return ret
        }
        
        if i <= 19 {
            if !is_largest_group {
                ret += variant._0_9(1)
            }
            ret += "十"
            if i % 10 > 0 {
                ret += variant._0_9(i % 10)
            }
            return ret
        }
        
        if i <= 99 {
            ret += _20_99(i)
            return ret
        }
        
        return _100_999(i.E(2), below: i.Ex(2))
        
    }
    
    override func read_positive(_ i: Int) -> String {
        if i <= 999 {
            return _0_999(i, is_largest_group: true)
        }
        if i <= 9_999 {
            let left = i / 1_000
            let right = i - left * 1_000
            var ret = _0_9(left) + "千"
            if right > 0 {
                ret += " " + _0_999(right, is_largest_group: false)
            }
            return ret
        }

        if i <= 99_999 {
            let left = i / 10_000
            let right = i - left * 10_000
            var ret = _0_9(left) + "万"
            if right > 0 {
                ret += " "
                if right < 1_000 {
                    ret += secondLast
                }
                ret += read_positive(right)
            }
            return ret
        }
        
        return "XX"
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        after_hundreds = " "
        if below > 0 {
            if below <= 9 {
                after_hundreds = " " + secondLast
            }
        }
        return super._100_999(hundreds, below: below)
    }

    private func not_largest_group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        return ""
    }
    
    private func _0_999(_ i: Int) -> String {
        if i <= 9 {
            return _0_9(i) // implemented in Language
        }
        
        if i <= 19 {
            return _11_19(i)
        }
        
        if i <= 99 {
            return _20_99(i)
        }
        
        return _100_999(i.E(2), below: i.Ex(2))
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        after_groupName = " "
        if below > 0 {
            if below <= 99 {
                after_groupName = " " + secondLast
            }
        }

        var ret: String = ""

        if above > 1 || use_single_group {
            ret = _0_999(above) + before_groupName
        }
        if let groupName = groupName(groupIndex, above) {
            ret += groupName
        }

        if below > 0 {
            ret += after_groupName + read_positive(below)
        }
        return ret
    }
    
    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
        switch groupIndex {
        case 0:
            return ""
        case 2:
            return "百"
        case 3:
            return "千"
        case 6:
            return "triệu"
        case 9:
            return "亿"
        case 12:
            return "兆"
        default: return nil
        }
    }
        
    override func _20_99(_ i: Int) -> String {
        let left = i / 10
        let right = i - left * 10
        var ret = _0_9(left)
        ret += "十"
        if right > 0 {
            ret += _0_9(right)
        }
        return ret
    }
    
    override func _0_9(_ i: Int) -> String {
        return variant._0_9(i)
    }
    
    override func _11_19(_ i: Int) -> String {
        let left = i / 10
        let right = i - left * 10

        var ret = "一十"
        if right > 0 {
            ret += _0_9(right)
        }
        return ret
    }
    
    override func _10s(_ i: Int) -> String {
        return _0_9(i) + "十"
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
        func _0_9(_ i: Int) -> String {
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
//
//    let variant: Variant
//    let filler = "零"
//    
//    init(variant: Variant) {
//        self.variant = variant
//        
//        super.init(
//            name: variant.name,
//            groupSize: GroupSize.three,
//            zero: variant.zero,
//            negativeString: "负",
//            dotString: "点",
//            exponentString: " 乘以 十的 ")
//        voiceLanguageCode = "zh"
//        nameDescription = variant.englishName
//        use_single_hundreds = true
//        before_hundreds = ""
//    }
//    
//    override func _0_9(_ i: Int) -> String {
//        return variant._0_9(i)
//    }
//    
//    override func _10s(_ i: Int) -> String {
//        return _0_9(i) + variant.e1
//    }
//    
//    func read_trailing_tens(_ i: Int) -> String {
//        var ret = readChinese(i)
//        if i.E1 == 1 {
//            ret = readChinese(1) + ret
//        }
//        return ret
//    }
//    
//    override func _11_19(_ i: Int) -> String {
//        var ret = ""
//        if i.E1 > 0 {
//            ret = _0_9(i.E1)
//        }
//        ret += variant.e1
//        if i.E1x > 0 {
//            ret += _0_9(i.E1x)
//        }
//        return ret
//    }
//    
//    override func _20_99(_ i: Int) -> String {
//        return _11_19(i)
//    }
//
//    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
//        switch groupIndex {
//        case 2:
//            return "百"
//        case 3:
//            return "thousand"
//        case 6:
//            return "million"
//        case 9:
//            return "billion"
//        case 12:
//            return "trillion"
//        default: return nil
//        }
//    }
//    
////    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
////        var ret = read_positive(above)
////        if let groupName = groupName(groupIndex, above) {
////            ret += groupName
////        }
////        if below > 0 {
////            ret += notLargestGroup(groupIndex - 3, below)
////        }
////        return ret
////    }
//    
//    private func notLargestGroup(_ groupIndex: Int, _ i: Int) -> String {
//        var ret = ""
//        let above = i.E(groupIndex)
//        let below = i.Ex(groupIndex)
//        if above == 0 {
//            ret += notLargestGroup(groupIndex - 3, i)
//        } else {
//            if above <= 99 {
//                ret += " 零"
//            }
//            ret += read_positive(above)
//            if let groupName = groupName(groupIndex, above) {
//                ret += groupName
//            }
//            if groupIndex >= 3 && below > 0 {
//                ret += notLargestGroup(groupIndex - 3, below)
//            }
//        }
//        return ret
//    }
//    
////    override func read_e2_e3(_ i: Int) -> String {
////        var ret = _0_9(i.E2) + variant.e2
////        
////        if i.E2x > 0 {
////            ret += " "
////            if i.E2x < 10 {
////                ret += filler
////            }
////            ret += readChinese(i.E2x)
////        }
////        return ret
////    }
////
////    override func read_e3_e6(_ i: Int) -> String {
////        var ret = readChinese(i.E3) + variant.e3
////        
////        if i.E3x > 0 {
////            ret += " "
////            if i.E3x < 100 {
////                ret += filler
////            }
////            ret += readChinese(i.E3x)
////        }
////        return ret
////    }
//    
//    private func readChinese(_ i: Int) -> String {
//        var ret = ""
////        if i < 1000 {
////            return group(3, 0, below: i)
////        }
//        if i < 10_000 {
//            var ret = readChinese(i.E2) + variant.e2
//
//            if i.E2x > 0 {
//                ret += " "
//                if i.E2x < 10 {
//                    ret += filler
//                }
//                ret += readChinese(i.E2x)
//            }
//            return ret
//        }
//        if i < 10_000 {
//            return super.read_positive(i)
//        }
//
//        if i < 100_000_000 {
//            ret += read_positive(i.E4)
//            ret += variant.e4
//            if i.E4x > 0 {
//                ret += " "
//                if i.E4x < 1_000 {
//                    ret += filler
//                }
//                ret += readChinese(i.E4x)
//            }
//            return ret
//        }
//
//        if i < 1_000_000_000_000 {
//            ret += read_positive(i.E8)
//            ret += variant.e8
//            if i.E8x > 0 {
//                ret += " "
//                if i.E8x < 10_000_000 {
//                    ret += filler
//                }
//                ret += readChinese(i.E8x)
//            }
//            return ret
//        }
//
//        ret += readChinese(i.E12)
//        ret += variant.e12
//        if i.E12x > 0 {
//            ret += " "
//            if i.E12x < 100_000_000_000 {
//                ret += filler
//            }
//            ret += readChinese(i.E12x)
//        }
//        return ret
//    }
//    
//    override func read_positive(_ i: Int) -> String {
//        if i == 10 {
//            return variant.e1
//        }
//        if i > 10 && i <= 19 {
//            return variant.e1 + _0_9(i % 10)
//        }
//        return readChinese(i)
//    }
//
//    enum Variant {
//        case traditional
//        case simplified
//        case financial
//        var name: String {
//            switch self {
//            case .traditional: "傳統中國"
//            case .simplified:  "简体中文"
//            case .financial:   "金融的"
//            }
//        }
//        var englishName: String {
//            switch self {
//            case .traditional: "Traditional Chinese"
//            case .simplified:  "Simplified Chinese"
//            case .financial:   "Financial Chinese"
//            }
//        }
//        var zero: String? {
//            switch self {
//            case .traditional, .financial: "零"
//            case .simplified:  "〇"
//            }
//        }
//        var e1: String {
//            switch self {
//            case .traditional, .simplified:  "十"
//            case .financial:   "拾"
//            }
//        }
//        var e2: String {
//            switch self {
//            case .traditional, .simplified:  "百"
//            case .financial:   "佰"
//            }
//        }
//        var e3: String {
//            switch self {
//            case .traditional, .simplified:  "千"
//            case .financial:   "仟"
//            }
//        }
//        var e4: String {
//            switch self {
//            case .traditional: "萬"
//            case .simplified:  "万"
//            case .financial:   "萬"
//            }
//        }
//        var e8: String {
//            switch self {
//            case .traditional, .financial: "億"
//            case .simplified:  "亿"
//            }
//        }
//        var e12: String {
//           "兆"
//        }
//        func _0_9(_ i: Int) -> String {
//            switch i {
//            case 1:
//                switch self {
//                case .traditional, .simplified: "一"
//                case .financial:   "壹"
//                }
//            case 2:
//                switch self {
//                case .traditional, .simplified: "二"
//                case .financial:   "壹"
//                }
//            case 3:
//                switch self {
//                case .traditional, .simplified: "三"
//                case .financial:   "叁"
//                }
//            case 4:
//                switch self {
//                case .traditional, .simplified: "四"
//                case .financial:   "肆"
//                }
//            case 5:
//                switch self {
//                case .traditional, .simplified: "五"
//                case .financial:   "伍"
//                }
//            case 6:
//                switch self {
//                case .traditional, .simplified: "六"
//                case .financial:   "陆"
//                }
//            case 7:
//                switch self {
//                case .traditional, .simplified: "七"
//                case .financial:   "柒"
//                }
//            case 8:
//                switch self {
//                case .traditional, .simplified: "八"
//                case .financial:   "捌"
//                }
//            case 9:
//                switch self {
//                case .traditional, .simplified: "九"
//                case .financial:   "玖"
//                }
//            default: "not implemented"
//            }
//        }
//    }
//    
//
//
//}
