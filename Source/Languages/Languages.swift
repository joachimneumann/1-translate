//
//  Languages.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import Foundation

protocol Language {
    func read(_ numberString: String) -> String
    func read(_ i: Int) -> String
    var name: String { get }
    var flagName: String { get }
    var englishName: String? { get }
    var voiceLanguageCode: String? { get }
    var voiceLanguageName: String? { get }
}

// Languages with parameters
protocol English: Language {
    var useAndAfterHundred: Bool { get set }
}
protocol German: Language {
    var capitalisation: Bool { get set }
    var useWordSplitter: Bool { get set }
}
protocol Vietnamese: Language {
    var thousand: VietnameseImpl.Thousand { get set }
    var secondLast: VietnameseImpl.SecondLast { get set }
    var compact: Bool { get set }
}
protocol Spanish: Language {
    var puntoComma: SpanishImpl.PuntoComma { get set }
}

class Languages {
    var list: [Language] = []
    let arabic: Language              = ArabicImpl() // not working
    let arabicNumerals: Language      = ArabicNumeralsImpl()
    let armenianNumerals: Language    = ArmenianNumeralsImpl()
    let armenian: Language            = ArmenianImpl()
    let babylonian: Language          = BabylonianImpl()
    let catalan: Language             = CatalanImpl()
    let chineseFinancial: Language    = ChineseImpl(variant: .financial)
    let chineseSimplified: Language   = ChineseImpl(variant: .simplified)
    let chineseTraditional: Language  = ChineseImpl(variant: .traditional)
    let danish: Language              = DanishImpl()
//    let digits: Language              = DigitsImpl()
    var english: English              = EnglishImpl()
    var spanish: Spanish              = SpanishImpl()
    let french: Language              = FrenchImpl()
    var german: German                = GermanImpl()
    var hieroglyphs: Language         = HieroglyphsImpl()
    let polish: Language              = PolishImpl()
    let roman: Language               = RomanImpl()
    let thai: Language                = ThaiImpl()
    let thaiNumerals: Language        = ThaiNumeralsImpl()
    var vietnamese: Vietnamese        = VietnameseImpl()

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
        english,
        spanish,
        french,
        german,
        hieroglyphs,
        polish,
        roman,
        thai,
        thaiNumerals,
        vietnamese]
    }
    
    static let WordSplitter = "\u{200A}" // the SoftHyphen "@\u{00AD}" did not seperate words well
}
