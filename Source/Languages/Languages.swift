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
    
    let translators = Translators()
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
    var english: Language
//    var esperanto           = EsperantoImpl()
//    var spanish             = SpanishImpl()
//    let finnish             = FinnishImpl()
//    let french              = FrenchImpl()
    var german :Language
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
        english = Language(translator: translators.english,      groupSize: GroupSize.three)
        german = Language(translator: translators.german,       groupSize: GroupSize.three)
        hindi = Language(translator: translators.hindi,        groupSize: GroupSize.three)
        roman = Language(translator: translators.roman,        groupSize: GroupSize.three)
        thaiNumerals = Language(translator: translators.thaiNumerals, groupSize: GroupSize.three)
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
