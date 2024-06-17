//
//  Catalan.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class CatalanImpl: LanguageGroup3 {
    
    init() {
        super.init(
            name: "Català",
            zero: "zero",
            negativeString: "menys",
            dotString: "coma",
            exponentString: " por diez elevat a ")        
        voiceLanguageCode = "ca"
        _20_99_connector = "-"
    }

    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret: String = ""
        switch hundreds {
        case 1:
            ret = hundreds == 1 ? "cent" : "cents"
        default:
            ret = read_positive(hundreds) + "-cents"
        }
        if below > 0 {
            ret += " " + read_positive(below)
        }
        return ret
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = ""
        
        if above == 1 {
            ret = groupName(groupIndex, true)
        } else {
            ret = read_positive(above) + " " + groupName(groupIndex, false)
        }
        if below > 0 {
            ret += groupIndex == 12 ? " y " : " "
            ret += read_positive(below)
        }
        return ret
    }
    
    private func groupName(_ groupIndex: Int, _ isOne: Bool) -> String {
        switch groupIndex {
        case 3:
            return "mil"
        case 6:
            if isOne {
                return "un milió"
            } else {
                return "milions"
            }
        case 9:
            return "mil milions"
        case 12:
            if isOne {
                return "un bilió"
            } else {
                return "bilions"
            }
        default: return "ERROR in Catalan Group"
        }
    }

    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "u"
        case 2:  return "dos"
        case 3:  return "tres"
        case 4:  return "quatre"
        case 5:  return "cinc"
        case 6:  return "sis"
        case 7:  return "set"
        case 8:  return "vuit"
        case 9:  return "nou"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1:  return "deu"
        case 2:  return "vint"
        case 3:  return "trenta"
        case 4:  return "quaranta"
        case 5:  return "cinquanta"
        case 6:  return "seixanta"
        case 7:  return "setanta"
        case 8:  return "vuitanta"
        case 9:  return "noranta"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }

    override func _10_19(_ i: Int) -> String {
        switch i {
        case 10: return _10s(1)
        case 11: return "onze"
        case 12: return "dotze"
        case 13: return "tretze"
        case 14: return "catorze"
        case 15: return "quinze"
        case 16: return "setze"
        case 17: return "disset"
        case 18: return "divuit"
        case 19: return "dinou"
        default:
            fatalError("_10_19() parameter \(i)")
        }
    }
    
    override func _20_99(_ i: Int) -> String {
        return super._20_99(i).replacingOccurrences(of: "vint-", with: "vint-i-")
    }
    
}
