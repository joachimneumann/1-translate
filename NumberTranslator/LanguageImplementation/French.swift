//
//  French.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class FrenchImplementation: Group3Language  {
    override init() {
        super.init()
        name = "Française"
        code = "fr"
        _20_99_connector = "-"
        negativeString = "moins"
        afterNegative = " "
        dotString = "virgule"
        exponentString = " fois dix à la puissance "
        after_hundreds = " "
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "zéro"
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
    
    override func _10s(_ i: UInt) -> String {
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
    
    override func _11_19(_ i: UInt) -> String {
        switch i {
        case 11: return "onze"
        case 12: return "douze"
        case 13: return "treize"
        case 14: return "quatorze"
        case 15: return "quinze"
        case 16: return "seize"
        default:
            return _10s(1) + "-" + _0_9(i - 10)
        }
    }

    override func _20_99(_ i: UInt) -> String {
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
            ret += _20_99_connector + fromUInt(right)
        }
        return ret
    }

    override func _100_999(_ i: UInt) -> String {
        var ret = super._100_999(i)
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if below > 0 {
            ret = ret.replacingOccurrences(of: "cents", with: "cent")
        }
        return ret
    }

    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
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
        default: return nil
        }
    }
    
}
    
