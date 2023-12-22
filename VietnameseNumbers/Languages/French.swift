//
//  French.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/21/23.
//

import Foundation

class French: Language {
    init() {
        super.init(
            name: "Française",
            negativeString: "moins",
            dotString: "virgule",
            exponentString: " fois dix à la puissance ",
            groupSeparator: "",
            decimalSeparator: ".")

        e2_single = "cent"
        e2 = "cents"
        e3 = "mille"
        e6_single = "million"
        e6 = "millions"
        e9_single = "milliard"
        e9 = "milliards"
        afterNegative = " "
        beforeAndAfterDotString = " "
        tensConnector = "-"
        eSpace = " "
    }

    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "zéro"
        case 1:     return "un"
        case 2:     return "deux"
        case 3:     return "trois"
        case 4:     return "quatre"
        case 5:     return "cinq"
        case 6:     return "six"
        case 7:     return "sept"
        case 8:     return "huit"
        case 9:     return "neuf"
        default: return " translate_0_10: outside range "
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "dix"
        case 2:     return "vingt"
        case 3:     return "trente"
        case 4:     return "quarante"
        case 5:     return "cinquante"
        case 6:     return "soixante"
        case 7:     return "soixante-dix"
        case 8:     return "quatre-vingts"
        case 9:     return "quatre-vingt-dix"
        default: return " 10s outside range "
        }
    }

    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "onze" }
        if i == 12 { return "douze" }
        if i == 13 { return "treize" }
        if i == 14 { return "quatorze" }
        if i == 15 { return "quinze" }
        if i == 16 { return "seize" }
        if i == 17 { return "dix-sept" }
        if i == 18 { return "dix-huit" }
        if i == 19 { return "dix-neuf" }
        var temp = i
        var X = temp % 10
        temp = (temp - X) / 10
        var X0 = temp % 10
        if X0 == 7 || X0 == 9 {
            X0 -= 1
            X += 10
        }
        var tens = read_10s(X0)
        if X0 == 8 && X > 0 {
            tens = "quatre-vingt" // no tailing s
        }
        if X == 0 {
            return tens
        } else if X0 < 8 && (X == 1 || X == 11) {
            return tens + " et " + (X < 10 ? read_0_9(X) : read_10_99(X))
        } else {
            return tens + "-" + (X < 10 ? read_0_9(X) : read_10_99(X))
        }
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        if i == 1_000 { return e3! }
        return super.read_e3_e6(i)
    }

}
