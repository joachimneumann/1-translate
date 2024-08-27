//
//  Italian.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class ItalianImplementation: Group3Language  {
    override init() {
        super.init()
        name = "Italiano"
        code = "it"
        negativeString = "meno"
        afterNegative = " "
        dotString = "virgola"
        before_hundreds = ""
        after_hundreds = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "zero"
        case 1: return "uno"
        case 2: return "due"
        case 3: return "tre"
        case 4: return "quattro"
        case 5: return "cinque"
        case 6: return "sei"
        case 7: return "sette"
        case 8: return "otto"
        case 9: return "nove"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
        switch i {
        case 1: return "dieci"
        case 2: return "venti"
        case 3: return "trenta"
        case 4: return "quaranta"
        case 5: return "cinquanta"
        case 6: return "sessanta"
        case 7: return "settanta"
        case 8: return "ottanta"
        case 9: return "novanta"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }
    
    override func _11_19(_ i: UInt) -> String {
        switch i {
        case 11: return "undici"
        case 12: return "dodici"
        case 13: return "tredici"
        case 14: return "quattordici"
        case 15: return "quindici"
        case 16: return "sedici"
        case 17: return "diciassette"
        case 18: return "diciotto"
        case 19: return "diciannove"
        default:
            fatalError("_11_19() parameter \(i)")
        }
    }

    override func _20_99(_ i: UInt) -> String {
        var ret = super._20_99(i)
        ret = ret.replacingOccurrences(of: "iuno", with: "uno")
        ret = ret.replacingOccurrences(of: "itre", with: "itré")
        ret = ret.replacingOccurrences(of: "iotto", with: "otto")
        ret = ret.replacingOccurrences(of: "auno", with: "uno")
        ret = ret.replacingOccurrences(of: "atre", with: "atré")
        ret = ret.replacingOccurrences(of: "aotto", with: "otto")
        return ret
    }

    override func _100_999(_ i: UInt) -> String {
        var ret = super._100_999(i)
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if hundreds == 1 && below == 0 {
            ret = ret.replacingOccurrences(of: "ciento", with: "cien")
        }
        if ret.hasSuffix("tre") {
            ret = ret.replacingOccurrences(of: "tre", with: "tré")
        }
        ret = ret.replacingOccurrences(of: "oott", with: "ott")
        ret = ret.replacingOccurrences(of: "oundici", with: "undici")
        ret = ret.replacingOccurrences(of: "otrédici", with: "otredici")
        return ret
    }
    
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 2:
            return "cento"
        case 3:
            if above == 1 {
                return "mille"
            } else {
                return "mila"
            }
        case 6:
            if above == 1 {
                return "un milione"
            } else {
                return "milioni"
            }
        case 9:
            if above == 1 {
                return "un miliardo"
            } else {
                return "miliardi"
            }
        case 12:
            if above == 1 {
                return "un bilione"
            } else {
                return "bilioni"
            }
        default: return nil
        }
    }
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        if groupIndex > 3 {
            before_groupName = " "
            after_groupName = " "
        } else {
            before_groupName = ""
            after_groupName = ""
        }
        return super.group(groupIndex, above, below: below)
    }
}
    
