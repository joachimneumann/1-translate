//
//  EsperantoImpl.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 1/2/24.
//

import Foundation

class EsperantoImpl: Language {
    init() {
        super.init(
            name: "Esperanto",
            negativeString: "minus",
            dotString: "kaj",
            exponentString: " EE ")
        tensConnector = " "
        e2 = "cent"
        e2_one = e2
        eSpace = " "
        e3 = "mil"
        e3_one = e3
        e6 = "milionoj"
        e6_one = "miliono"
        e9 = "miliardoj"
        e9_one = "miliardo"
        e12 = "bilionoj"
        e12_one = "biliono"
        afterNegative = " "
    }

    
    override func read_0_9(_ i: Int) -> String {
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
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        if i == 1 { return "dek"}
        return read_0_9(i) + "dek"
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = super.read_e2_e3(i)
        ret = ret.replacingOccurrences(of: " cent", with: "cent")
        return ret
    }
    
}
