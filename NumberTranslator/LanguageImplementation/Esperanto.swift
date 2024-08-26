//
//  Esperanto.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class EsperantoImplementation: Group3Language  {
    override init() {
        super.init()
        name = "Esperanto"
        _20_99_connector = " "
        negativeString = "minus"
        afterNegative = " "
        dotString = "kaj"
        beforeAndAfterDotString = " "
        before_hundreds = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "nul"
        case 1: return "unu"
        case 2: return "du"
        case 3: return "tri"
        case 4: return "kvar"
        case 5: return "kvin"
        case 6: return "ses"
        case 7: return "sep"
        case 8: return "ok"
        case 9: return "naŭ"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
        if i == 1 { return "dek"}
        return _0_9(i) + "dek"
    }
    
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
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
        default: return nil
        }
    }
}
    
