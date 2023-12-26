//
//  ThaiTraditional.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class ThaiNumerals: Language {
    init() {
        super.init(
            name: "แบบดั้งเดิม",
            negativeString: "-",
            dotString: ".",
            exponentString: "e")
        englishName = "Thai Numerals"
    }
        
    override func read(_ i: Int) -> String {
        var ret = i.string
        ret = ret.replacingOccurrences(of: "0", with: "๐")
        ret = ret.replacingOccurrences(of: "1", with: "๑")
        ret = ret.replacingOccurrences(of: "2", with: "๒")
        ret = ret.replacingOccurrences(of: "3", with: "๓")
        ret = ret.replacingOccurrences(of: "4", with: "๔")
        ret = ret.replacingOccurrences(of: "5", with: "๕")
        ret = ret.replacingOccurrences(of: "6", with: "๖")
        ret = ret.replacingOccurrences(of: "7", with: "๗")
        ret = ret.replacingOccurrences(of: "8", with: "๘")
        ret = ret.replacingOccurrences(of: "9", with: "๙")
        return ret
    }

}
