//
//  EsperantoImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/2/24.
//

import Foundation

class EsperantoImpl: LanguageGroup3 {
    init() {
        super.init(
            name: "Esperanto",
            zero: "nul",
            negativeString: "minus",
            dotString: "kaj",
            exponentString: " EE ")
        _20_99_connector = " "
        after_hundreds = " "
//        tensConnector = " "
//        e2 = "cent"
//        e2_one = e2
//        eSpace = " "
//        e3 = "mil"
//        e3_one = e3
//        e6 = "milionoj"
//        e6_one = "miliono"
//        e9 = "miliardoj"
//        e9_one = "miliardo"
//        e12 = "bilionoj"
//        e12_one = "biliono"
        afterNegative = " "
    }

    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "unu"
        case 2: return "du"
        case 3: return "tri"
        case 4: return "kvar"
        case 5: return "kvin"
        case 6: return "ses"
        case 7: return "sep"
        case 8: return "ok"
        case 9: return "naŭ"
        default: return "read_0_9: outside range"
        }
    }
    
    override func _10s(_ i: Int) -> String {
        if i == 1 { return "dek"}
        return _0_9(i) + "dek"
    }
    
    override func groupName(_ groupIndex: Int, _ above: Int) -> String {
        switch groupIndex {
        case 2:
            return "cent"
        case 3:
            return "mil"
        case 6:
            if above == 1 {
                return "miliono"
            } else {
                return "milionoj"
            }
        case 9:
            if above == 1 {
                return "miliardo"
            } else {
                return "miliardoj"
            }
        case 12:
            if above == 1 {
                return "biliono"
            } else {
                return "bilionoj"
            }
        default: return "ERROR in Esperanto Group"
        }
    }

    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = ""
        
        if above == 1 {
            ret = groupName(groupIndex, above)
        } else {
            ret = read_positive(above) + " " + groupName(groupIndex, above)
        }
        if below > 0 {
            ret += " " + read_positive(below)
        }
        return ret
    }

}
