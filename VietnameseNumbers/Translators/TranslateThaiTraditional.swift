//
//  TranslateThaiTraditional.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/17/23.
//

import SwiftUI

class TranslateThaiTraditional: BasicTranslator {
    
    init() {
        super.init(language: "แบบดั้งเดิม",
                   languageEnglish: "trad. Thai",
                   dotString: "",
                   negativeString: "",
                   exponentString: "")
    }
    
    override func translate(_ s: String) -> String? {
        var clean = s
        if groupSeparator != "" {
            clean = clean.replacingOccurrences(of: groupSeparator, with: "")
        }
        if clean.count > 20 {
            clean = String(clean.prefix(20))
        }
        var res = ""
        for digit in clean {
            switch digit {
            case "0": res += "๐"
            case "1": res += "๑"
            case "2": res += "๒"
            case "3": res += "๔"
            case "4": res += "๔"
            case "5": res += "๕"
            case "6": res += "๖"
            case "7": res += "๗"
            case "8": res += "๘"
            case "9": res += "๙"
            case Character(decimalSeparator): res += "จุด"
            case "e": res += "e"
            case "-": res += "-"
            default: res += " not implemented "
            }
        }
        
        return res
    }
}

