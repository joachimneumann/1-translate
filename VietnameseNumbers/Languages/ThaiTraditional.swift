//
//  ThaiTraditional.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class ThaiTraditional: TenBasedLanguage {
    var negativeString = "-"
    var dotString = "."
    var exponentString = "e"
    var name: String = "แบบดั้งเดิม"
    
//    override init() {
//        super.init()
//        englishName = "trad. Thai"
//        afterNegative = ""
//    }
    
    func read_0_9(_ i: Int) -> String {
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
