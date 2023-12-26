//
//  TranslateNumber.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import Foundation

class TranslateNumber: TranslateNumberP {
    var decimalSeparator: DecimalSeparator
    var groupSeparator: GroupSeparator
    var languages: [LanguageP] = []

    func english() -> EnglishP { language("English")! as! EnglishP }
    func german() -> GermanP { language("German")! as! GermanP }
    
    
    func language(_ l: String) -> LanguageP? {
        var ret: LanguageP? = nil
        for language in languages {
            if ret == nil &&
                l == language.name || (
                language.englishName != nil && l == language.englishName! ) {
                ret = language
            }
            switch l {
            case "English":
                return language as? EnglishP
            case "German":
                return language as? GermanP
            default: return language
            }
        }
        return nil
    }
    
    func names() -> [String] {
        var ret: [String] = []
        for language in languages { ret.append(language.name) }
        return ret
    }
    
    init(decimalSeparator: DecimalSeparator, groupSeparator: GroupSeparator) {
        self.decimalSeparator = decimalSeparator
        self.groupSeparator = groupSeparator
//        self.languages.append(ArabicNumerals())
//        self.languages.append(ArmenianNumerals())
//        self.languages.append(Armenian())
//        self.languages.append(Catalan())
//        self.languages.append(Chinese(variant: .financial))
//        self.languages.append(Chinese(variant: .simplified))
//        self.languages.append(Chinese(variant: .traditional))
//        self.languages.append(Danish())
//        self.languages.append(Digits())
//        self.languages.append(English())
//        self.languages.append(French())
//        self.languages.append(German())
//        self.languages.append(Polish())
//        self.languages.append(Roman())
//        self.languages.append(Spanish())
//        self.languages.append(Thai())
//        self.languages.append(ThaiNumerals())
//        self.languages.append(Vietnamese())
    }
}
