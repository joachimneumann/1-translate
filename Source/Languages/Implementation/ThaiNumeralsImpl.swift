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
        voiceLanguageName = "Thai"
        nameDescription = "Thai Numerals"
    }
        
    override func read_1_(_ i: Int) -> String {
        var ret = i.string
        ret = ret.replacingOccurrences(of: "1", with: "๑"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "2", with: "๒"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "3", with: "๓"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "4", with: "๔"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "5", with: "๕"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "6", with: "๖"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "7", with: "๗"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "8", with: "๘"+Languages.WordSplitter)
        ret = ret.replacingOccurrences(of: "9", with: "๙"+Languages.WordSplitter)
        return ret
    }

}
