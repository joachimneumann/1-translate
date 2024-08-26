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
//    var english          = Language(translator: translators.english, groupSize: GroupSize.three)
//    var esperanto           = EsperantoImpl()
//    var spanish             = SpanishImpl()
//    let finnish             = FinnishImpl()
//    let french              = FrenchImpl()
//    var german              = Language(translator: German(), groupSize: GroupSize.three)
//    var hieroglyphs         = HieroglyphsImpl()
//    var hindi               = Language(translator: Hindi(), groupSize: GroupSize.five)
//    var italian             = ItalianImpl()
//    let polish              = PolishImpl()
//    var portugueseEuropean  = PortugueseImpl(variant: .European)
//    var portugueseBrazil    = PortugueseImpl(variant: .Brazilian)
//    let russian             = RussianImpl()
//    let ukrainian           = UkrainianImpl()
//    let swahili             = SwahiliImpl()
//    let roman               = RomanImpl()
//    let thai                = ThaiImpl()
//    let thaiNumerals        =  Language(translator: ThaiNumerals(), groupSize: GroupSize.three)
//    var vietnamese          = VietnameseImpl()

    init() {
//        translators.hindi.nameDescription = "Hindi"
//        translators.thaiNumerals.nameDescription = "Thai Numerals"
        list.append(Language(translator: translators.english,      groupSize: GroupSize.three))
        list.append(Language(translator: translators.german,       groupSize: GroupSize.three))
        list.append(Language(translator: translators.hindi,        groupSize: GroupSize.three))
        list.append(Language(translator: translators.roman,        groupSize: GroupSize.three))
        list.append(Language(translator: translators.thaiNumerals, groupSize: GroupSize.three))

        first = list[0]
        second = list[1]
//        for language in list {
//            if language.name == firstName {
//                first = language
//            }
//            if language.name == secondName {
//                second = language
//            }
//        }
    }
        
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
//    static let WordSplitter = "@" 
}
