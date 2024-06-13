//
//  Vietnamese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import SwiftUI

class VietnameseImpl: LanguageGroup3 {
    
    @AppStorage("VietnameseThousandKey")
    var thousand: VietnameseImpl.Thousand = .nghìn {
        didSet {
            connector_4_3.before = " "
            connector_4_3.name = thousand.rawValue
        }
    }
    
    @AppStorage("VietnameseSecondLastKey")
    var secondLast: VietnameseImpl.SecondLast = .lẻ {
        didSet {
//            connector_2_1.before = " "
//            connector_2_1.name = secondLast.rawValue
//            connector_2_1.after = " "
        }
    }
    
    @AppStorage("VietnameseCompactKey")
    var compact: Bool = false

    enum Thousand: String, Codable, CaseIterable {
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
        
        connector_2_1.after = " "
        connector_3_2.before = " "
        connector_3_2.name = "trăm"
        connector_3_2.after = " "

//        e2 = "trăm"
//        e3 = "nghìn"
//        e6 = "triệu"
//        e9 = "tỷ"
        postProcessing = vietnamesePostProcessing
    }
    
    func vietnamesePostProcessing(_ unprocessed: String) -> String {
        var ret = unprocessed
        ret = ret.replacingOccurrences(of: "mười năm", with: "mười lăm")
        ret = ret.replacingOccurrences(of: "mươi năm", with: "mươi lăm")
        ret = ret.replacingOccurrences(of: "mươi một", with: "mươi mốt")
        return ret
    }
    override func override(_ i: Int) -> String? {
        switch i {
        case 1:  return "một"
        case 2:  return "hai"
        case 3:  return "ba"
        case 4:  return "bốn"
        case 5:  return "năm"
        case 6:  return "sáu"
        case 7:  return "bảy"
        case 8:  return "tám"
        case 9:  return "chín"
        case 10: return "mười"
        default:
            if i > 19 && i <= 99 {
                if compact {
                    connector_2_1.before = ""
                    connector_2_1.name = ""
                } else {
                    connector_2_1.before = " "
                    connector_2_1.name = "mươi"
                }
            }
            return nil
        }
    }
    
//    override func read_10_99(_ i: Int) -> String {
//        var ret = ""
//        if i.E1 == 1 {
//            ret = "mười"
//        } else {
//            ret = read_1_9(i.E1)
//            if !compact || i.E1x == 0 { ret += " mươi" }
//        }
//        if i.E1x > 0 {
//            ret += " " + read_1_9(i.E1x)
//        }
//
//        if ret.hasSuffix("năm") {
//            ret = String(ret.dropLast(3))
//            ret += "lăm"
//        }
//        if i.E1 > 1 && ret.hasSuffix("một") {
//            ret = String(ret.dropLast(3))
//            ret += "mốt"
//        }
//        return ret
//    }
//    
//
//    func read_trailing_tens(_ i: Int) -> String {
//        var ret = ""
//        if i > 0 {
//            ret = read_1_(i)
//            if i.E1x > 0 && i.secondLastDigit == 0 {
//                ret = secondLast.rawValue + " " + ret
//            }
//            ret = " " + ret
//        }
//        return ret
//    }
//    
//    func read_trailing_3digits(_ i: Int, _ name: String = "") -> String {
//        if i < 1 || i > 999 {
//            return "read_trailing_3digits: outside range"
//        }
//        var ret = ""
//        if i > 0 {
//            ret = " "
//            if i.E2 == 0 {
//                ret += "không trăm"
//            } else {
//                ret += read_1_9(i.E2) + " " + "trăm"
//            }
//            ret += read_trailing_tens(i.E2x)
//            ret += name
//        }
//        return ret
//    }
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
