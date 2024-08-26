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
//    let arabic              = ArabicImpl() // not working
//    let arabicNumerals      = ArabicNumeralsImpl()
//    let armenianNumerals    = ArmenianNumeralsImpl()
//    let armenian            = ArmenianImpl()
//    var babylonian          = BabylonianImpl()
//    let catalan             = CatalanImpl()
//    let chineseFinancial    = ChineseImpl(variant: .financial)
//    let chineseSimplified   = ChineseImpl(variant: .simplified)
//    let chineseTraditional  = ChineseImpl(variant: .traditional)
//    let danish              = DanishImpl()
//    let digits              = DigitsImpl()
    var english: EnglishLanguage
//    var esperanto           = EsperantoImpl()
//    var spanish             = SpanishImpl()
//    let finnish             = FinnishImpl()
//    let french              = FrenchImpl()
    var german: GermanLanguage
//    var hieroglyphs         = HieroglyphsImpl()
    var hindi: Language
//    var italian             = ItalianImpl()
//    let polish              = PolishImpl()
//    var portugueseEuropean  = PortugueseImpl(variant: .European)
//    var portugueseBrazil    = PortugueseImpl(variant: .Brazilian)
//    let russian             = RussianImpl()
//    let ukrainian           = UkrainianImpl()
//    let swahili             = SwahiliImpl()
    let roman: Language
//    let thai                = ThaiImpl()
    let thaiNumerals: Language
//    var vietnamese          = VietnameseImpl()

    init() {
        english      = EnglishLanguage(englishTranslator,      "en", GroupSize.three)
        german       = GermanLanguage( germanTranslator,       "de", GroupSize.three)
        hindi        = Language(       hindiTranslator,        "hi", GroupSize.four)
        roman        = Language(       romanTranslator,        "la", GroupSize.three)
        thaiNumerals = Language(       thaiNumeralsTranslator, "th", GroupSize.three)

        german.capitalisation = true
        english.useAndAfterHundred = true

        hindi.nameDescription = "Hindi"
        thaiNumerals.nameDescription = "Thai Numerals"

        list.append(english)
        list.append(german)
        list.append(hindi)
        list.append(roman)
        list.append(thaiNumerals)

        first = english
        second = german
    }
        
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
//    static let WordSplitter = "@" 
}
