//
//  ArabNumerals.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class ArabicNumeralsImpl: Language {
    init() {
        super.init(
            name: "الترقيم العربي",
            zero: "٠",
            negativeString: "-",
            dotString: ".",
            exponentString: " EE ")
        voiceLanguageCode = "ar"
        nameDescription = "Arabic Numerals"
        speakingPostProcessing = speakingPostProcessing
    }
    
    override func read_positive(_ i: Int) -> String {
        var ret = i.string
        ret = ret.replacingOccurrences(of: "1", with: "١")
        ret = ret.replacingOccurrences(of: "2", with: "٢")
        ret = ret.replacingOccurrences(of: "3", with: "٣")
        ret = ret.replacingOccurrences(of: "4", with: "٤")
        ret = ret.replacingOccurrences(of: "5", with: "٥")
        ret = ret.replacingOccurrences(of: "6", with: "٦")
        ret = ret.replacingOccurrences(of: "7", with: "٧")
        ret = ret.replacingOccurrences(of: "8", with: "٨")
        ret = ret.replacingOccurrences(of: "9", with: "٩")
        return ret
    }
    
    func speakingPostProcessing(_ text: String) -> String {
        var ret = ""
        for letter in text {
            switch letter {
            case ".": ret += "واحدة"
            case "٠": ret += "صفر"
            case "١": ret += "وَاحِد"
            case "٢": ret += "اِثْنَان"
            case "٣": ret += "ثَلَاثَة"
            case "٤": ret += "أَرْبَعَة"
            case "٥": ret += "خَمْسَة"
            case "٦": ret += "سِتَّة"
            case "٧": ret += "سَبْعَة"
            case "٨": ret += "ثَمَانِيَة"
            case "٩": ret += "تِسْعَة"
            case " ": ret += " "
            default: fatalError("speakingPostProcessing: outside range")
            }
            ret += " "
        }
        if ret.count > 0 {
            ret = String(ret.dropLast())
        }
        return ret
    }
}
