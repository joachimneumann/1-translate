//
//  Swahili.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class SwahiliImplementation: Group3Language  {
    override init() {
        super.init()
        name = "Swahili"
        negativeString = "negativi"
        _20_99_connector = " na "
        afterNegative = " "
        dotString = "nukta"
        before_hundreds = ""
        after_hundreds = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "sifuri"
        case 1: return "moja"
        case 2: return "mbili"
        case 3: return "tatu"
        case 4: return "nne"
        case 5: return "tano"
        case 6: return "sita"
        case 7: return "saba"
        case 8: return "nane"
        case 9: return "tisa"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
        switch i {
        case 1: return "kumi"
        case 2: return "ishirini"
        case 3: return "thelathini"
        case 4: return "arobaini"
        case 5: return "hamsini"
        case 6: return "sitini"
        case 7: return "sabini"
        case 8: return "themanini"
        case 9: return "tisini"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }

    override func _100_999(_ i: UInt) -> String {
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        var ret = "mia " + _0_9(hundreds)
        if below > 0 {
            ret += " na "
            ret += fromUInt(below)
        }
        return ret
    }
    
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 3:
            return "elfu"
        case 6:
            return "milioni"
        case 9:
            return "bilioni"
        case 12:
            return "trilioni"
        default: return nil
        }
    }
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        var ret: String = ""
        if groupIndex == 3 && above >= 100 {
            ret = "laki " + fromUInt(above / 100)
            let below = (above - above / 100 * 100) * 1000 + below
            if below > 0 {
                ret += ", " + fromUInt(below)
            }
            return ret
        } else {
            if let groupName = groupName(groupIndex, above) {
                ret = groupName + after_groupName + fromUInt(above)
            }
        }
        if below > 0 {
            ret += below <= 9 ? " na " : ", "
            ret += fromUInt(below)
        }
        return ret
    }
}
    
