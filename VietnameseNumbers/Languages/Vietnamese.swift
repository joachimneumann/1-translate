//
//  Vietnamese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class Vietnamese: Language {
    init() {
        super.init(
            name: "Tiếng Việt",
            negativeString: "âm",
            dotString: "phẩy",
            exponentString: " nhân mười mũ ",
            groupSeparator: "",
            decimalSeparator: ".")
        e2 = "trăm"
        e3 = "nghìn"
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
            ret = read_0_9(i.E1) + " " + "mươi"
        }
        if i.E1x > 0 {
            ret += " " + read_0_9(i.E1x)
        }

        if ret.hasSuffix("năm") {
            ret = String(ret.dropLast(3))
            ret += "lăm"
        }
        if ret.hasSuffix("một") {
            if i.E1 > 1 {
                ret = String(ret.dropLast(3))
                ret += "mốt"
            }
        }
        return ret
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = super.read_e2_e3(i)
        if i.lastDigit > 0 && i.secondLastDigit == 0 {
            var array = ret.split(separator: " ")
            array.insert("lẻ", at:array.count-1)
            ret = array.joined(separator: " ")
        }
        return ret
    }

    func read_trailing_tens(_ i: Int) -> String {
        var ret = ""
        if i > 0 {
            ret = read(i)
            if i.lastDigit > 0 && i.secondLastDigit == 0 {
                ret = "lẻ" + " " + ret
            }
            ret = " " + ret
        }
        return ret
    }
    
    func read_trailing_3digits(_ i: Int) -> String {
        var ret = ""
        if i > 0 {
            ret = " "
            if i.E2 == 0 {
                ret += "không trăm"
            } else {
                ret += read_0_9(i.E2) + " " + "trăm"
            }
            ret += read_trailing_tens(i.E2x)
        }
        return ret
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        return read(i.E3) + " " + e3! + read_trailing_3digits(i.E3x)
    }

    override func read_e6_e9(_ i: Int) -> String {
        var ret = read(i.E6s) + " " + e6!
        if i.E3s > 0 {
            ret += read_trailing_3digits(i.E3s) + " " + e3!
        }
        ret += read_trailing_3digits(i.E0s)
        return ret
    }
    

}

fileprivate extension Int {
    var E0s: Int { self % 1_000 }
    var E3s: Int { (self / 1_000) % 1_000 }
    var E6s: Int { (self / 1_000_000) % 1_000 }
    var lastDigit: Int { self % 10 }
    var secondLastDigit: Int { (self /  10) % 10 }
    var thirdLastDigit:  Int { (self / 100) % 10 }
}
