//
//  Languages.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import SwiftUI
import NumberTranslator

class Languages {
    @AppStorage("firstNameKey") 
    var firstName: String = "English"
    
    @AppStorage("secondNameKey")
    var secondName: String = "German"
    
    @AppStorage("secondLanguageAllowedKey")
    var secondLanguageAllowed: Bool = false
    
    var first: Language
    var second: Language
    var list: [Language] = []
    let arabic: Language? = nil // not working
    let arabicNumerals: Language? = nil
    let armenianNumerals: Language? = nil
    let armenian: Language? = nil
    var babylonian: Language? = nil
    let catalan: Language? = nil
//    let chineseFinancial    = ChineseImpl(variant: .financial)
//    let chineseSimplified   = ChineseImpl(variant: .simplified)
//    let chineseTraditional  = ChineseImpl(variant: .traditional)
    let danish: Language? = nil
    let digits: Language? = nil
    let english: EnglishLanguage
    var esperanto: Language? = nil
    var spanish: Language? = nil
    let finnish: Language? = nil
    let french: Language? = nil
    let german: GermanLanguage
    var hieroglyphs: Language? = nil
    let hindi: Language
    var italian: Language? = nil
    let polish: Language? = nil
//    var portugueseEuropean  = PortugueseImpl(variant: .European)
//    var portugueseBrazil    = PortugueseImpl(variant: .Brazilian)
    let russian: Language? = nil
    let ukrainian: Language? = nil
    let swahili: Language? = nil
    let roman: Language
    let thai: Language? = nil
    let thaiNumerals: Language
    var vietnamese: Language

    init() {
        english      = EnglishLanguage(englishTranslator,      "en", GroupSize.three)
        german       = GermanLanguage( germanTranslator,       "de", GroupSize.three)
        hindi        = Language(       hindiTranslator,        "hi", GroupSize.four)
        roman        = Language(       romanTranslator,        "la", GroupSize.three)
        thaiNumerals = Language(       thaiNumeralsTranslator, "th", GroupSize.three)
        vietnamese   = Language(       vietnameseTranslator,   "vi", GroupSize.three)

        german.capitalisation = true
        english.useAndAfterHundred = true

        hindi.nameDescription = "Hindi"
        thaiNumerals.nameDescription = "Thai Numerals"
        vietnamese.nameDescription = "Vietnamese"

        list.append(english)
        list.append(german)
        list.append(hindi)
        list.append(roman)
        list.append(thaiNumerals)
        list.append(vietnamese)

        first = english
        second = german
    }
        
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
//    static let WordSplitter = "@" 
}
