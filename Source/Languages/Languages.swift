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
    let arabicNumerals: Language
    let armenian: Language
    let armenianNumerals: Language
    var babylonian: BabylonianLanguage
    let catalan: Language
    let chineseFinancial: Language
    let chineseSimplified: Language
    let chineseTraditional: Language
    let danish: Language
    let english: EnglishLanguage
    var esperanto: Language
    var spanish: Language
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
        arabicNumerals     = Language(          arabicNumeralsTranslator,     "ar", GroupSize.three)
        armenian           = Language(          armenianTranslator,           "hy", GroupSize.three)
        armenianNumerals   = Language(          armenianNumeralsTranslator,   "hy", GroupSize.three)
        babylonian         = BabylonianLanguage(babylonianTranslator,          nil, GroupSize.three)
        catalan            = Language(          catalanTranslator,            "hi", GroupSize.four)
        chineseFinancial   = Language(          chineseFinancialTranslator,   "zh", GroupSize.three)
        chineseSimplified  = Language(          chineseSimplifiedTranslator,  "zh", GroupSize.three)
        chineseTraditional = Language(          chineseTraditionalTranslator, "zh", GroupSize.three)
        danish             = Language(          danishTranslator,             "hi", GroupSize.four)
        english            = EnglishLanguage(   englishTranslator,            "en", GroupSize.three)
        esperanto          = Language(          esperantoTranslator,          "eo", GroupSize.three)
        german             = GermanLanguage(    germanTranslator,             "de", GroupSize.three)
        hindi              = Language(          hindiTranslator,              "hi", GroupSize.four)
        spanish            = Language(          spanishTranslator,            "es", GroupSize.three)
        roman              = Language(          romanTranslator,              "la", GroupSize.three)
        thaiNumerals       = Language(          thaiNumeralsTranslator,       "th", GroupSize.three)
        vietnamese         = Language(          vietnameseTranslator,         "vi", GroupSize.three)

        arabicNumerals.nameDescription = "Arabic Numerals"
        armenian.nameDescription = "Armenian"
        armenianNumerals.nameDescription = "Armenian Numerals"
        babylonian.allowEmptyColumn = false
        chineseFinancial.nameDescription = "Financial Chinese"
        chineseSimplified.nameDescription = "Simplified Chinese"
        chineseTraditional.nameDescription = "Traditional Chinese"
        english.useAndAfterHundred = true
        german.capitalisation = true
        hindi.nameDescription = "Hindi"
        thaiNumerals.nameDescription = "Thai Numerals"
        vietnamese.nameDescription = "Vietnamese"

        list.append(arabicNumerals)
        list.append(armenian)
        list.append(armenianNumerals)
        list.append(babylonian)
        list.append(catalan)
        list.append(chineseFinancial)
        list.append(chineseSimplified)
        list.append(chineseTraditional)
        list.append(danish)
        list.append(english)
        list.append(esperanto)
        list.append(german)
        list.append(hindi)
        list.append(spanish)
        list.append(roman)
        list.append(thaiNumerals)
        list.append(vietnamese)

        first = english
        second = german
    }
        
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
//    static let WordSplitter = "@" 
}
