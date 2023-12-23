//
//  Vietnamese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class Vietnamese: Language {
    
    enum Thousand: String, Codable, CaseIterable {
        case ngàn
        case nghìn
    }

    enum SecondLast: String, Codable, CaseIterable {
        case linh
        case lẻ
    }
    
    var compact: Bool = false
    var secondLast: SecondLast = .lẻ
    var thousand: Thousand = .nghìn

    init() {
        super.init(
            name: "Tiếng Việt",
            negativeString: "âm",
            dotString: "phẩy",
            exponentString: " nhân mười mũ ",
            groupSeparator: "",
            decimalSeparator: ".")
        e2 = "trăm"
        e3 = thousand.rawValue
        e6 = "triệu"
        e9 = "tỷ"
        afterNegative = " "
        beforeAndAfterDotString = " "
        eSpace = " "
        englishName = "Vietnamese"
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "không"
        case 1:     return "một"
        case 2:     return "hai"
        case 3:     return "ba"
        case 4:     return "bốn"
        case 5:     return "năm"
        case 6:     return "sáu"
        case 7:     return "bảy"
        case 8:     return "tám"
        case 9:     return "chín"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10_99(_ i: Int) -> String {
        var ret = ""
        if i.E1 == 1 {
            ret = "mười"
        } else {
            ret = read_0_9(i.E1)
            if !compact || i.E1x == 0 { ret += " mươi" }
        }
        if i.E1x > 0 {
            ret += " " + read_0_9(i.E1x)
        }

        if ret.hasSuffix("năm") {
            ret = String(ret.dropLast(3))
            ret += "lăm"
        }
        if i.E1 > 1 && ret.hasSuffix("một") {
            ret = String(ret.dropLast(3))
            ret += "mốt"
        }
        return ret
    }
    

    func read_trailing_tens(_ i: Int) -> String {
        var ret = ""
        if i > 0 {
            ret = read(i)
            if i.lastDigit > 0 && i.secondLastDigit == 0 {
                ret = secondLast.rawValue + " " + ret
            }
            ret = " " + ret
        }
        return ret
    }
    
    func read_trailing_3digits(_ i: Int, _ name: String = "") -> String {
        var ret = ""
        if i > 0 {
            ret = " "
            if i.E2 == 0 {
                ret += "không trăm"
            } else {
                ret += read_0_9(i.E2) + " " + "trăm"
            }
            ret += read_trailing_tens(i.E2x)
            ret += name
        }
        return ret
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        return read_0_9(i.E2) + " trăm" + read_trailing_tens(i.E2x)
    }

    override func read_e3_e6(_ i: Int) -> String {
        return read(i.E3) + " " + e3! + read_trailing_3digits(i.E3x)
    }

    override func read_e6_e9(_ i: Int) -> String {
        var ret = read(i.E6s) + " " + e6!
        ret += read_trailing_3digits(i.E3s, " " + thousand.rawValue)
        ret += read_trailing_3digits(i.E0s)
        return ret
    }
    

}

fileprivate extension Int {
    var E0s: Int { self % 1_000 }
    var E3s: Int { (self / 1_000) % 1_000 }
    var E6s: Int { (self / 1_000_000) % 1_000 }
    var lastDigit: Int { self % 10 }
    var thirdLastDigit:  Int { (self / 100) % 10 }
}
