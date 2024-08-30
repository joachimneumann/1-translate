//
//  Finnish.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class FinnishImplementation: Group3Language  {

    override init() {
        super.init()
        name = "Suomalainen"
        englishName = "Finnish"
        code = "fi"
        _20_99_connector = " y "
        negativeString = "miinus"
        afterNegative = " "
        dotString = "pilkku"
        before_hundreds = ""
        after_hundreds = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "nolla"
        case 1: return "yksi"
        case 2: return "kaksi"
        case 3: return "kolme"
        case 4: return "neljä"
        case 5: return "viisi"
        case 6: return "kuusi"
        case 7: return "seitsemän"
        case 8: return "kahdeksan"
        case 9: return "yhdeksän"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
        if i == 1 { return "kymmenen" }
        return _0_9(i) + wordSplitter + "kymmentä"
    }
    
    override func _11_19(_ i: UInt) -> String {
        return _0_9(i - 10) + wordSplitter + "toista"
    }

    override func _20_99(_ i: UInt) -> String {
        let first = i / 10
        let rest = i - 10 * first
        if i == 10 { return "kymmenen" }
        var ret = _10s(first)
        if i < 20 {
            if rest > 0 {
                ret = _0_9(rest) + wordSplitter + ret
            }
        } else {
            if rest > 0 {
                ret += wordSplitter + _0_9(rest)
            }
        }
        return ret
    }
  
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
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
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
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
    
