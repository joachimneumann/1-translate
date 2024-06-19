//
//  Thai.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class ThaiImpl: LanguageGroup3 {
    init() {
        super.init(
            name: "ภาษาไทย",
            zero: "ศูนย์",
            negativeString: "ลบ",
            dotString: "จุด",
            exponentString: " EE ")

        voiceLanguageCode = "th"
        nameDescription = "Thai"
        afterNegative = Languages.WordSplitter
        use_single_hundreds = true
        before_hundreds = ""
        after_hundreds = ""
        use_single_group = true
        before_groupName = ""
        after_groupName = ""
//        e2 = "ร้อย"
//        e3 = "พัน"
//        e4 = "หมื่น"
//        e5 = "แสน"
//        e6 = "ล้าน"
//        e9 = "พันล้าน"
//        e12 = "ล้านล้าน"
//        eSpace = Languages.WordSplitter
    }
    
    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
        switch groupIndex {
        case 2:
            return "ร้อย"
        case 3:
            return "พัน"
        case 4:
            return "หมื่น"
        case 5:
            return "แสน"
        case 6:
            return "ล้าน"
        case 9:
            return "พันล้าน"
        case 12:
            return "ล้านล้าน"
        default: return nil
        }
    }
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "หนึ่ง" // "เอ็ด"
        case 2: return "สอง"
        case 3: return "สาม"
        case 4: return "สี่"
        case 5: return "ห้า"
        case 6: return "หก"
        case 7: return "เจ็ด"
        case 8: return "แปด"
        case 9: return "เก้า"
        default: return "read_0_9: outside range"
        }
    }
    
    override func _20_99(_ i: Int) -> String {
        let ret = super._20_99(i)
        if i > 1 && ret.hasSuffix("หนึ่ง") {
            return ret.replacingOccurrences(of: "หนึ่ง", with: "เอ็ด")
        }
        return ret
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1:     return "สิบ"
        case 2:     return "ยี่สิบ"
        default: return _0_9(i) + "สิบ"
        }
    }
}
