//
//  FinnishImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/5/24.
//

import Foundation

class FinnishImpl: LanguageGroup3 {
    init() {
        super.init(
            name: "Suomalainen",
            zero: "nolla",
            negativeString: "miinus",
            dotString: "pilkku",
            exponentString: " EE ")
        nameDescription = "Finnish"
        voiceLanguageCode = "fi"
    }


    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "yksi"
        case 2: return "kaksi"
        case 3: return "kolme"
        case 4: return "neljä"
        case 5: return "viisi"
        case 6: return "kuusi"
        case 7: return "seitsemän"
        case 8: return "kahdeksan"
        case 9: return "yhdeksän"
        default: return "read_0_9: outside range"
        }
    }
    
    override func _10s(_ i: Int) -> String {
        if i == 1 { return "toista" } //kymmenen"}
        return _0_9(i) + Languages.WordSplitter + "kymmentä"
    }
    
    override func _20_99(_ i: Int) -> String {
        let first = i / 10
        let rest = i - 10 * first
        if i == 10 { return "kymmenen" }
        var ret = _10s(first)
        if i < 20 {
            if rest > 0 {
                ret = _0_9(rest) + Languages.WordSplitter + ret
            }
        } else {
            if rest > 0 {
                ret += Languages.WordSplitter + _0_9(rest)
            }
        }
        return ret
    }
    
    override func groupName(_ groupIndex: Int, _ above: Int) -> String {
        switch groupIndex {
        case 2:
            if above == 1 {
                return "sata"
            } else {
                return "sataa"
            }
        case 3:
            if above == 1 {
                return "tuhat"
            } else {
                return "tuhatta"
            }
        case 6:
            if above == 1 {
                return "miljoona"
            } else {
                return "miljoonaa"
            }
        case 9:
            if above == 1 {
                return "miljardi"
            } else {
                return "miljardia"
            }
        case 12:
            if above == 1 {
                return "biljoona"
            } else {
                return "biljoonaa"
            }
        default: return "ERROR in Finnish Group"
        }
    }

    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = ""
        
        if above == 1 {
            ret = groupName(groupIndex, above)
        } else {
            ret = read_positive(above)
            if groupIndex >= 6 {
                ret += " "
            }
            ret += groupName(groupIndex, above)
        }
        if below > 0 {
            if groupIndex >= 6 {
                ret += " "
            }
            ret += read_positive(below)
        }
        return ret
    }
}
