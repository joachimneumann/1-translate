//
//  ThaiNumerals.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 22.08.24.
//

import Foundation

class ThaiNumeralsImplementation: DigitLanguage  {
    override init() {
        super.init()
        name = "แบบดั้งเดิม"
        beforeAndAfterDotString = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
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
        default: return "read_0_9: outside range"
        }
    }
    
}
