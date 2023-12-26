//
//  ArabNumerals.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class ArabicNumerals: Language {
    init() {
        super.init(
            name: "الترقيم العربي",
            negativeString: "-",
            dotString: ".",
            exponentString: "e")
        englishName = "Arabic Numerals"
    }
    
    override func read(_ i: Int) -> String {
        var ret = i.string
        ret = ret.replacingOccurrences(of: "0", with: "٠")
        ret = ret.replacingOccurrences(of: "1", with: "١")
        ret = ret.replacingOccurrences(of: "2", with: "٢")
        ret = ret.replacingOccurrences(of: "3", with: "٣")
        ret = ret.replacingOccurrences(of: "4", with: "٤‎")
        ret = ret.replacingOccurrences(of: "5", with: "٥‎")
        ret = ret.replacingOccurrences(of: "6", with: "٦‎")
        ret = ret.replacingOccurrences(of: "7", with: "٧‎")
        ret = ret.replacingOccurrences(of: "8", with: "٨‎")
        ret = ret.replacingOccurrences(of: "9", with: "٩")
        return ret
    }

}
