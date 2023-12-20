//
//  ThaiTraditional.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class ThaiTraditional: TenBasedLanguage {
    init() {
        super.init(
            name: "แบบดั้งเดิม",
            negativeString: "-",
            dotString: ".",
            exponentString: "e",
            groupSeparator: "",
            decimalSeparator: ".")
    }
    
    override func readPeriod(_ p: Period) -> String {
        var ret = ""
        let allDigits = !p.isLargest
        if p.x__ > 0 || allDigits {
            ret += read_0_9(p.x__)
        }
        if p._x_ > 0 || p.x__ > 0 || allDigits {
            ret += read_0_9(p._x_)
        }
        if p.value > 0 || allDigits {
            ret += read_0_9(p.__x)
        }
        return ret
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0: return "๐"
        case 1: return "๑"
        case 2: return "๒"
        case 3: return "๓"
        case 4: return "๔"
        case 5: return "๕"
        case 6: return "๖"
        case 7: return "๗"
        case 8: return "๘"
        case 9: return "๙"
        default: return " translate_0_10: outside range "
        }
    }
}
