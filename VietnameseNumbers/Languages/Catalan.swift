//
//  Catalan.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class Catalan: Language {
    init() {
        super.init(
            name: "Català",
            negativeString: "menys",
            dotString: "coma",
            exponentString: " por diez elevat a ")

        e2 = "cent"
        e2_one = "cent"
        e3 = "mil"
        e3_one = "mil"
        e6_one = "un milió"
        e6 = "milions"
        e9_one = "mil milions"
        e9 = "mil milions"
        e12_one = "un bilió"
        e12 = "bilions"
        afterNegative = " "
        beforeAndAfterDotString = " "
        tensConnector = "-"
        beforeHundred = "-"
        e3Space = " "
        e69Space = " "
    }

    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "zero"
        case 1:     return "u"
        case 2:     return "dos"
        case 3:     return "tres"
        case 4:     return "quatre"
        case 5:     return "cinc"
        case 6:     return "sis"
        case 7:     return "set"
        case 8:     return "vuit"
        case 9:     return "nou"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "deu"
        case 2:     return "vint"
        case 3:     return "trenta"
        case 4:     return "quaranta"
        case 5:     return "cinquanta"
        case 6:     return "seixanta"
        case 7:     return "setanta"
        case 8:     return "vuitanta"
        case 9:     return "noranta"
        default: return "read_10s: outside range"
        }
    }

    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "onze" }
        if i == 12 { return "dotze" }
        if i == 13 { return "tretze" }
        if i == 14 { return "catorze" }
        if i == 15 { return "quinze" }
        if i == 16 { return "setze" }
        if i == 17 { return "disset" }
        if i == 18 { return "divuit" }
        if i == 19 { return "dinou" }
        var ret = super.read_10_99(i)
        ret = ret.replacingOccurrences(of: "vint-", with: "vint-i-")
        return ret
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        if i.E2 == 1 {
            ret = "cent"
        } else {
            ret = read_0_9(i.E2) + "-cents"
        }
        if i.E2x > 0 {
            ret += " " + read(i.E2x)
        }
        return ret
    }
    
}
