//
//  Thai.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class ThaiImpl: LanguageImpl {
    init() {
        super.init(
            name: "ภาษาไทย",
            negativeString: "ลบ",
            dotString: "จุด",
            exponentString: "e",
            code: "th")
        
        englishName = "Thai"
        e2 = "ร้อย"
        e3 = "พัน"
        e4 = "หมื่น"
        e5 = "แสน"
        e6 = "ล้าน"
        e9 = "พันล้าน"
        e12 = "ล้านล้าน"
        afterNegative = ""
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0: return "ศูนย์"
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
    
    override func read_10_99(_ i: Int) -> String {
        let ret = super.read_10_99(i)
        if i > 1 && ret.hasSuffix("หนึ่ง") {
            return ret.replacingOccurrences(of: "หนึ่ง", with: "เอ็ด")
        }
        return ret
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "สิบ"
        case 2:     return "ยี่สิบ"
        default: return read_0_9(i) + "สิบ"
        }
    }
}
