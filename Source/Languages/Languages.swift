//
//  Languages.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import SwiftUI

class Languages {
    @AppStorage("firstNameKey") 
    var firstName: String = "English"
    
    @AppStorage("secondNameKey")
    var secondName: String = "German"
    
    @AppStorage("secondLanguageAllowedKey")
    var secondLanguageAllowed: Bool = false
    
    var first: Language!
    var second: Language!
    var list: [Language] = []
    let arabic              = ArabicImpl() // not working
    let arabicNumerals      = ArabicNumeralsImpl()
    let armenianNumerals    = ArmenianNumeralsImpl()
    let armenian            = ArmenianImpl()
    var babylonian          = BabylonianImpl()
    let catalan             = CatalanImpl()
    let chineseFinancial    = ChineseImpl(variant: .financial)
    let chineseSimplified   = ChineseImpl(variant: .simplified)
    let chineseTraditional  = ChineseImpl(variant: .traditional)
    let danish              = DanishImpl()
    let digits              = DigitsImpl()
    var english             = EnglishImpl()
    var esperanto           = EsperantoImpl()
    var spanish             = SpanishImpl()
    let finnish             = FinnishImpl()
    let french              = FrenchImpl()
    var german              = GermanImpl()
    var hieroglyphs         = HieroglyphsImpl()
    var hindi               = HindiImpl()
    let polish              = PolishImpl()
    let russian             = RussianImpl()
    let ukrainian           = UkrainianImpl()
    let swahili             = SwahiliImpl()
    let roman               = RomanImpl()
    let thai                = ThaiImpl()
    let thaiNumerals        = ThaiNumeralsImpl()
    var vietnamese    = VietnameseImpl()

    init() {
        list = [
        //arabic,
        arabicNumerals,
        armenianNumerals,
        armenian,
        babylonian,
        catalan,
        chineseFinancial,
        chineseSimplified,
        chineseTraditional,
        danish,
        // digits,
        english,
        esperanto,
        finnish,
        french,
        spanish,
        german,
        hieroglyphs,
        hindi,
        polish,
        roman,
        russian,
        ukrainian,
        swahili,
        thai,
        thaiNumerals,
        vietnamese]
        
        first = english
        second = german
        for language in list {
            if language.name == firstName {
                first = language
            }
            if language.name == secondName {
                second = language
            }
        }
    }
        
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
//    static let WordSplitter = "@" 
}
