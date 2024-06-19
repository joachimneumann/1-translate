//
//  ThaiTraditional.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class ThaiNumeralsImpl: Language {
    init() {
        super.init(
            name: "แบบดั้งเดิม",
            zero: "๐"+Languages.WordSplitter,
            negativeString: "-",
            dotString: ".",
            exponentString: " EE ")

        voiceLanguageCode = "th"
        nameDescription = "Thai Numerals"
        beforeAndAfterDotString = ""
    }
    
    override func read_positive(_ i: Int) -> String {
        let as_string = i.string
        var ret = ""
        for digit in as_string {
            ret += transformDigit(digit)
        }
        return ret
    }
        
    private func transformDigit(_ digit: Character) -> String {
        switch digit {
        case "0": return "๐"
        case "1": return "๑"
        case "2": return "๒"
        case "3": return "๓"
        case "4": return "๔"
        case "5": return "๕"
        case "6": return "๖"
        case "7": return "๗"
        case "8": return "๘"
        case "9": return "๙"
        case ".": return "."
        default: return ""
        }
    }

}
