//
//  TranslateNumber.swift
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
    var rightToLeft: Bool { get }
}

protocol English: Language {
    var useAndAfterHundred: Bool { get set }
}
protocol German: Language {
    var capitalisation: Bool { get set }
    var useSoftHyphen: Bool { get set }
}
protocol Vietnamese: Language {
    var thousand: VietnameseImpl.Thousand { get set }
    var secondLast: VietnameseImpl.SecondLast { get set }
    var compact: Bool { get set }
}
protocol Spanish: Language {
    var puntoComma: SpanishImpl.PuntoComma { get set }
}

class TranslateNumber {
    var languages: [Language] = []
    let arabic: Language              = ArabicImpl()
    let arabicNumerals: Language      = ArabicNumeralsImpl()
    let armenianNumerals: Language    = ArmenianNumeralsImpl()
    let armenian: Language            = ArmenianImpl()
    let catalan: Language             = CatalanImpl()
    let chineseFinancial: Language    = ChineseImpl(variant: .financial)
    let chineseSimplified: Language   = ChineseImpl(variant: .simplified)
    let chineseTraditional: Language  = ChineseImpl(variant: .traditional)
    let danish: Language              = DanishImpl()
    let digits: Language              = DigitsImpl()
    var english: English              = EnglishImpl()
    let french: Language              = FrenchImpl()
    var german: German                = GermanImpl()
    let polish: Language              = PolishImpl()
    let roman: Language               = RomanImpl()
    var spanish: Spanish              = SpanishImpl()
    let thai: Language                = ThaiImpl()
    let thaiNumerals: Language        = ThaiNumeralsImpl()
    var vietnamese: Vietnamese        = VietnameseImpl()

    init() {
        languages = [arabicNumerals,
        armenianNumerals,
        armenian,
        catalan,
        chineseFinancial,
        chineseSimplified,
        chineseTraditional,
        danish,
        english,
        french,
        german,
        polish,
        roman,
        spanish,
        thai,
        thaiNumerals,
        vietnamese]
    }
}
