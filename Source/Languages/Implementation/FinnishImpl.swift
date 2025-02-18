//
//  FinnishImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/5/24.
//

import Foundation

class FinnishImpl: LanguageImplGroup3 {
    init() {
        super.init(
            name: "Suomalainen",
            groupSize: GroupSize.three,
            zero: "nolla",
            negativeString: "miinus",
            dotString: "pilkku",
            exponentString: " EE ")
        nameDescription = "Finnish"
        voiceLanguageCode = "fi"
        before_hundreds = ""
        after_hundreds = ""
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
        if i == 1 { return "kymmenen" }
        return _0_9(i) + Languages.WordSplitter + "kymmentä"
    }
    
    override func _11_19(_ i: Int) -> String {
        return _0_9(i - 10) + Languages.WordSplitter + "toista"
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
    
    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
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
        default: return nil
        }
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        if groupIndex >= 6 {
            before_groupName = " "
            after_groupName = " "
        } else {
            before_groupName = ""
            after_groupName = ""
        }
        return super.group(groupIndex, above, below: below)
    }
    
}
