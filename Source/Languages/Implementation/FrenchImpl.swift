//
//  French.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/21/23.
//

import Foundation

class FrenchImpl: LanguageGroup3 {
    init() {
        super.init(
            name: "Française",
            zero: "zéro",
            negativeString: "moins",
            dotString: "virgule",
            exponentString: " fois dix à la puissance ")

        voiceLanguageCode = "fr"
        afterNegative = " "
        _20_99_connector = "-"
    }

    override func groupName(_ groupIndex: Int, _ above: Int) -> String {
        switch groupIndex {
        case 2:
            if above == 1 {
                return "cent"
            } else {
                return "cents"
            }
        case 3:
            return "mille"
        case 6:
            if above == 1 {
                return "un million"
            } else {
                return "millions"
            }
        case 9:
            if above == 1 {
                return "un milliard"
            } else {
                return "milliards"
            }
        case 12:
            if above == 1 {
                return "un billion"
            } else {
                return "billions"
            }
        default: return "ERROR in English Group"
        }
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        super.group(groupIndex, above, below: below)
        
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "un"
        case 2: return "deux"
        case 3: return "trois"
        case 4: return "quatre"
        case 5: return "cinq"
        case 6: return "six"
        case 7: return "sept"
        case 8: return "huit"
        case 9: return "neuf"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1: return "dix"
        case 2: return "vingt"
        case 3: return "trente"
        case 4: return "quarante"
        case 5: return "cinquante"
        case 6: return "soixante"
        case 7: return "soixante-dix"
        case 8: return "quatre-vingt"
        case 9: return "quatre-vingt-dix"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }

    override func _11_19(_ i: Int) -> String {
        if i == 11 { return "onze" }
        if i == 12 { return "douze" }
        if i == 13 { return "treize" }
        if i == 14 { return "quatorze" }
        if i == 15 { return "quinze" }
        if i == 16 { return "seize" }
        return _10s(1) + "-" + _0_9(i - 10)
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = super._100_999(hundreds, below: below)
        if below > 0 {
            ret = ret.replacingOccurrences(of: "cents", with: "cent")
        }
        return ret
    }
    
    override func _20_99(_ i: Int) -> String {
        if i == 71 { return "soixante-et-onze" }
        if i == 80 { return "quatre-vingts" }
        if i == 81 { return "quatre-vingt-un" }
        var left = i / 10
        var right = i - left * 10
        if left == 7 || left == 9 {
            left -= 1
            right += 10
        }
        if right == 1 {
            _20_99_connector = " et "
        } else {
            _20_99_connector = "-"
        }
        var ret = _10s(left)
        if right > 0 {
            ret += _20_99_connector + read_positive(right)
        }
        return ret
    }

}
