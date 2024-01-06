//
//  French.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/21/23.
//

import Foundation

class FrenchImpl: Language {
    init() {
        super.init(
            name: "Française",
            negativeString: "moins",
            dotString: "virgule",
            exponentString: " fois dix à la puissance ")

        voiceLanguageCode = "fr"
        voiceLanguageName = "French"
        e2 = "cent"
        e2_one = "cent"
        e2_cleanPlural = "cents"
        e3 = "mille"
        e3_one = "mille"
        e6 = "millions"
        e6_one = "un million"
        e9 = "milliards"
        e9_one = "un milliard"
        e12 = "billions"
        e12_one = "un billion"

        afterNegative = " "
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
        default: return "read_0_9: outside range"
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
        case 8:     return "quatre-vingt"
        case 9:     return "quatre-vingt-dix"
        default: return "read_10s: outside range "
        }
    }

    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "onze" }
        if i == 12 { return "douze" }
        if i == 13 { return "treize" }
        if i == 14 { return "quatorze" }
        if i == 15 { return "quinze" }
        if i == 16 { return "seize" }
        
        var X0 = i.E1
        var X = i.E1x
        if X0 == 7 || X0 == 9 {
            X0 -= 1
            X += 10
        }
        
        var ret = read_10s(X0)
        if X0 == 8 && X == 0 {
            ret += "s" // quatre-vingts
        }
        if X > 0 {
            let connector = X0 < 8 && (X == 1 || X == 11) ? " et " : "-"
            ret += connector + (X < 10 ? read_0_9(X) : read_10_99(X))

        }
        return ret
    }
    
}
