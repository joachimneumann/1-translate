//
//  Spanish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class Spanish: Language {
    init() {
        super.init(
            name: "Español",
            negativeString: "menos",
            dotString: "coma",
            exponentString: " por diez elevado a ",
            groupSeparator: "",
            decimalSeparator: ".")

        e3 = "mil"
        e3_one = "mil"
        e6_one = "un millón"
        e6 = "millones"
        e9_one = "mil millones"
        e9 = "mil millones"
        e12_one = "un billón"
        e12 = "billiones"
        afterNegative = " "
        beforeAndAfterDotString = " "
        tensConnector = " y "
        eSpace = " "
    }

    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "cero"
        case 1:     return "uno"
        case 2:     return "dos"
        case 3:     return "tres"
        case 4:     return "cuatro"
        case 5:     return "cinco"
        case 6:     return "seis"
        case 7:     return "siete"
        case 8:     return "ocho"
        case 9:     return "nueve"
        default: return " translate_0_10: outside range "
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "diez"
        case 2:     return "veinte"
        case 3:     return "treinta"
        case 4:     return "cuarenta"
        case 5:     return "cincuenta"
        case 6:     return "sesenta"
        case 7:     return "setenta"
        case 8:     return "ochenta"
        case 9:     return "noventa"
        default: return " 10s outside range "
        }
    }

    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "once" }
        if i == 12 { return "doce" }
        if i == 13 { return "trece" }
        if i == 14 { return "catorce" }
        if i == 15 { return "quince" }
        if i == 16 { return "dieciséis" }
        if i == 17 { return "diecisiete" }
        if i == 18 { return "dieciocho" }
        if i == 19 { return "diecinueve" }

        if i == 21 { return "veintiuno" }
        if i == 22 { return "veintidós" }
        if i == 23 { return "veintitrés" }
        if i == 24 { return "veinticuatro" }
        if i == 25 { return "veinticinco" }
        if i == 26 { return "veintiséis" }
        if i == 27 { return "veintisiete" }
        if i == 28 { return "veintiocho" }
        if i == 29 { return "veintinueve" }
        return super.read_10_99(i)
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        switch i.E2 {
        case 1:
            ret = i.E2x == 0 ? "cien" : "ciento"
        case 5:
            ret = "quinientos"
        case 7:
            ret = "setecientos"
        case 9:
            ret = "novecientos"
        default:
            ret = read(i.E2) + "cientos"
        }
        if i.E2x > 0 {
            ret += " " + read(i.E2x)
        }
        return ret
    }
}
