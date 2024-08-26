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
    let finnish: Language
    let french: Language
    let german: GermanLanguage
    var hieroglyphs: Language? = nil
    let hindi: Language
    var italian: Language
    let polish: Language
    var portugueseEuropean: Language
    var portugueseBrazilian: Language
    let roman: Language
    let russian: Language
    var spanish: Language
    let swahili: Language
    let thai: Language
    let thaiNumerals: Language
    let ukrainian: Language
    var vietnamese: Language

    init() {
        arabicNumerals      = Language(          arabicNumeralsTranslator,      "ar", GroupSize.three)
        armenian            = Language(          armenianTranslator,            "hy", GroupSize.three)
        armenianNumerals    = Language(          armenianNumeralsTranslator,    "hy", GroupSize.three)
        babylonian          = BabylonianLanguage(babylonianTranslator,           nil, GroupSize.three)
        catalan             = Language(          catalanTranslator,             "hi", GroupSize.four)
        chineseFinancial    = Language(          chineseFinancialTranslator,    "zh", GroupSize.three)
        chineseSimplified   = Language(          chineseSimplifiedTranslator,   "zh", GroupSize.three)
        chineseTraditional  = Language(          chineseTraditionalTranslator,  "zh", GroupSize.three)
        danish              = Language(          danishTranslator,              "hi", GroupSize.four)
        english             = EnglishLanguage(   englishTranslator,             "en", GroupSize.three)
        esperanto           = Language(          esperantoTranslator,           "eo", GroupSize.three)
        finnish             = Language(          finnishTranslator,             "fi", GroupSize.three)
        french              = Language(          frenchTranslator,              "fr", GroupSize.three)
        german              = GermanLanguage(    germanTranslator,              "de", GroupSize.three)
        hindi               = Language(          hindiTranslator,               "hi", GroupSize.four)
        italian             = Language(          italianTranslator,             "it", GroupSize.four)
        polish              = Language(          polishTranslator,              "pl", GroupSize.four)
        portugueseEuropean  = Language(          portugueseEuropeanTranslator,  "pt", GroupSize.four)
        portugueseBrazilian = Language(          portugueseBrazilianTranslator, "pt", GroupSize.four)
        roman               = Language(          romanTranslator,               "la", GroupSize.three)
        russian             = Language(          russianTranslator,             "ru", GroupSize.three)
        spanish             = Language(          spanishTranslator,             "es", GroupSize.three)
        swahili             = Language(          swahiliTranslator,             "tz", GroupSize.three)
        thai                = Language(          thaiTranslator,                "th", GroupSize.three)
        thaiNumerals        = Language(          thaiNumeralsTranslator,        "th", GroupSize.three)
        ukrainian           = Language(          ukrainianTranslator,           "uk", GroupSize.three)
        vietnamese          = Language(          vietnameseTranslator,          "vi", GroupSize.three)

        arabicNumerals.nameDescription = "Arabic Numerals"
        armenian.nameDescription = "Armenian"
        armenianNumerals.nameDescription = "Armenian Numerals"
        babylonian.allowEmptyColumn = false
        chineseFinancial.nameDescription = "Financial Chinese"
        chineseSimplified.nameDescription = "Simplified Chinese"
        chineseTraditional.nameDescription = "Traditional Chinese"
        english.useAndAfterHundred = true
        finnish.nameDescription = "Finnish"
        german.capitalisation = true
        hindi.nameDescription = "Hindi"
        russian.nameDescription = "Russian"
        thai.nameDescription = "Thai"
        thaiNumerals.nameDescription = "Thai Numerals"
        ukrainian.nameDescription = "Ukrainian"
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
        list.append(finnish)
        list.append(french)
        list.append(german)
        list.append(hindi)
        list.append(italian)
        list.append(polish)
        list.append(portugueseEuropean)
        list.append(portugueseBrazilian)
        list.append(roman)
        list.append(russian)
        list.append(spanish)
        list.append(swahili)
        list.append(thai)
        list.append(thaiNumerals)
        list.append(ukrainian)
        list.append(vietnamese)

        first = english
        second = german
    }
        
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
//    static let WordSplitter = "@" 
}
