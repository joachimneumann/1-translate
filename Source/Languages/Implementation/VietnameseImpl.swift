//
//  Vietnamese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import SwiftUI

class VietnameseImpl: LanguageGroup3 {
    
    @AppStorage("VietnameseThousandKey")
    var vietnameseThousand: VietnameseImpl.VietnameseThousand = .nghìn
    
    @AppStorage("VietnameseSecondLastKey")
    var secondLast: VietnameseImpl.SecondLast = .lẻ
    
    @AppStorage("VietnameseCompactKey")
    var compact: Bool = false

    enum VietnameseThousand: String, Codable, CaseIterable {
        case ngàn
        case nghìn
    }

    enum SecondLast: String, Codable, CaseIterable {
        case linh
        case lẻ
    }
    
    init() {
        super.init(
            name: "Tiếng Việt",
            zero: "không",
            negativeString: "âm",
            dotString: "phẩy",
            exponentString: " nhân mười mũ ")
        voiceLanguageCode = "vi"
        afterNegative = " "
        nameDescription = "Vietnamese"
        _11_99_connector.before = " "
        secondLast = secondLast

//        e2 = "trăm"
//        e3 = "nghìn"
//        e6 = "triệu"
//        e9 = "tỷ"
        postProcessing = vietnamesePostProcessing
    }
    
    override func hundred(_ hundreds: Int, below: Int) -> String {
        var ret = _1_99(hundreds, isLargestGroup: true) + " trăm"
        if below > 0 {
            ret += " " + _1_99(below, isLargestGroup: false)
        }
        return ret
    }
    
    override func thousand(_ thousands: Int, below: Int) -> String {
        var ret = _0_999(thousands, isLargestGroup: false) + " " + vietnameseThousand.rawValue
        if below > 0 {
            ret += " " + _0_999(below, isLargestGroup: false)
        }
        return ret
    }
    
    override func _1_99(_ i: Int, isLargestGroup: Bool) -> String {
        var ret = super._1_99(i, isLargestGroup: isLargestGroup)
        if i <= 9 && !isLargestGroup {
            ret = secondLast.rawValue + " " + ret
        }
        return ret
    }

    
    func vietnamesePostProcessing(_ unprocessed: String) -> String {
        var ret = unprocessed
        ret = ret.replacingOccurrences(of: "mười năm", with: "mười lăm")
        ret = ret.replacingOccurrences(of: "mươi năm", with: "mươi lăm")
        ret = ret.replacingOccurrences(of: "mươi một", with: "mươi mốt")
        return ret
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "một"
        case 2:  return "hai"
        case 3:  return "ba"
        case 4:  return "bốn"
        case 5:  return "năm"
        case 6:  return "sáu"
        case 7:  return "bảy"
        case 8:  return "tám"
        case 9:  return "chín"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10_19(_ i: Int) -> String? {
        var ret = "mười"
        if i.E1x > 0 {
            ret += " " + _0_9(i.E1x)
        }
        return ret
    }
    
    override func _10s(_ i: Int) -> String? {
        if i == 1 { return _10_19(10) }
        return _0_9(i) + " mươi"
    }
    
//    
//    override func read_e2_e3(_ i: Int) -> String {
//        return read_1_9(i.E2) + " trăm" + read_trailing_tens(i.E2x)
//    }
//
//    override func read_e3_e6(_ i: Int) -> String {
//        var ret = read_1_(i.E3) + " " + e3!
//        if i.E3x > 0 {
//            ret += read_trailing_3digits(i.E3x)
//        }
//        return ret
//    }
//
//    override func read_e6_e9(_ i: Int) -> String {
//        var ret = read_1_(i.E6) + " " + e6!
//        let thousands = i.E6x - i.E3x
//        if thousands > 0 {
//            ret += read_trailing_3digits(thousands.E3, " " + e3!)
//        }
//        let lastThree = i.E3x
//        if lastThree > 0 {
//            ret += read_trailing_3digits(lastThree)
//        }
//        return ret
//    }
//    
//    override func read_e9_e12(_ i: Int) -> String {
//        var ret = read_1_(i.E9) + " " + e9!
//        let millions = i.E9x - i.E6x
//        if millions > 0 {
//            ret += read_trailing_3digits(millions.E6, " " + e6!)
//        }
//        let thousands = i.E6x - i.E3x
//        if thousands > 0 {
//            ret += read_trailing_3digits(thousands.E3, " " + e3!)
//        }
//        let lastThree = i.E3x
//        if lastThree > 0 {
//            ret += read_trailing_3digits(lastThree)
//        }
//        return ret
//    }
//
//    override func read_e12_e15(_ i: Int) -> String {
//        var ret = ""
//        ret = read_1_(i.E12) + " " + e3! + " " + e9!
//        let billions = i.E12x - i.E9x
//        if billions > 0 {
//            ret += read_trailing_3digits(billions.E9, " " + e9!)
//        }
//        let millions = i.E9x - i.E6x
//        if millions > 0 {
//            ret += read_trailing_3digits(millions.E6, " " + e6!)
//        }
//        let thousands = i.E6x - i.E3x
//        if thousands > 0 {
//            ret += read_trailing_3digits(thousands.E3, " " + e3!)
//        }
//        let lastThree = i.E3x
//        if lastThree > 0 {
//            ret += read_trailing_3digits(lastThree)
//        }
//        return ret
//    }
}
