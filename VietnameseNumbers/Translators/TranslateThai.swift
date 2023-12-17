//
//  TranslateThai.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/16/23.
//

import SwiftUI

class TranslateThai: TwentyBasedTranslator {
    var useSoftHyphen: Bool = true
    var capitalisation: Bool = true

    init() {
        super.init(
            language: "ภาษาไทย",
            dotString: "XXX",
            negativeString: "XXX",
            andSoOn: "XXX",
            exponentString: "XXX",
            hundred: "ร้อย",
            thousand: "พัน",
            _e6: "XXX",
            _e9: "XXX")
        beforeOneChunk = "หนึ่ง"
        onlyOne = "หนึ่ง"
        tenThousand = "หมื่น"
        hundredThousand = "แสน"
    }
    
    override func translate_0_20(_ intValue: Int) -> String {
        switch intValue {
        case 0:     return "ศูนย์"
        case 1:     return "เอ็ด"
        case 2:     return "สอง"
        case 3:     return "สาม"
        case 4:     return "สี่"
        case 5:     return "ห้า"
        case 6:     return "หก"
        case 7:     return "เจ็ด"
        case 8:     return "แปด"
        case 9:     return "เก้า"
        case 10:    return "สิบ"
        case 11:    return "สิบเอ็ด"
        case 12:    return "สิบสอง"
        case 13:    return "สิบสาม"
        case 14:    return "สิบสี่"
        case 15:    return "สิบห้า"
        case 16:    return "สิบหก"
        case 17:    return "สิบเจ็ด"
        case 18:    return "สิบแปด"
        case 19:    return "สิบเก้า"
        case 20:    return "ยี่สิบ"
        default: return " 10s outside range "
        }
    }
    
    override func translate_10s(_ intValue: Int) -> String {
        switch intValue {
        case 1:     return "สิบ"
        case 2:     return "ยี่สิบ"
        case 3:     return "สามสิบ"
        case 4:     return "สี่สิบ"
        case 5:     return "ห้าสิบ"
        case 6:     return "หกสิบ"
        case 7:     return "เจ็ดสิบ"
        case 8:     return "แปดสิบ"
        case 9:     return "เก้าสิบ"
        default: return " 10s outside range "
        }
    }

//    override func translate_0_20(_ i: Int) -> String? {
//        if i == 1 {
//            return "หนึ่ง"
//        }
//        if i <= 20 {
//            return translate_0_20(i)
//        }
//        var temp = i
//        let X = temp % 10
//        temp = (temp - X) / 10
//        let X0 = temp % 10
//        if X == 0 {
//            return tens(X0)!
//        } else {
//            return tens(X0)! + translate_0_20(X)!
//        }
//    }
}

