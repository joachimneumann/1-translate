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
    var englishName: String? { get }
    var rightToLeft: Bool { get }
}
protocol English: Language {
    var afterHundred: String { get set }
}
protocol German: Language {
    var capitalisation: Bool { get set }
}
protocol Vietnamese: Language {
    var thousand: VietnameseImpl.Thousand { get set }
    var secondLast: VietnameseImpl.SecondLast { get set }
    var compact: Bool { get set }
}

class TranslateNumber {
    var languages: [Language] = []
    let arabic: Language              = ArabicImpl()
    let arabicNumerals: Language      = ArabicNumeralsImpl()
    let armenianNumerals: Language    = ArmenianNumerals()
    let armenian: Language            = ArmenianImpl()
    let catalan: Language             = CatalanImpl()
    let chineseFinancial: Language    = ChineseImpl(variant: .financial)
    let chineseSimplified: Language   = ChineseImpl(variant: .simplified)
    let chineseTraditional: Language  = ChineseImpl(variant: .traditional)
    let danish: Language              = DanishImpl()
    let digits: Language              = DigitsImpl()
    let english: English              = EnglishImpl()
    let french: Language              = FrenchImpl()
    let german: German                = GermanImpl()
    let polish: Language              = PolishImpl()
    let roman: Language               = RomanImpl()
    let spanish: Language             = SpanishImpl()
    let thai: Language                = ThaiImpl()
    let thaiNumerals: Language        = ThaiNumeralsImpl()
    let vietnamese: Vietnamese        = VietnameseImpl()

    init() {
        languages.append(arabicNumerals)
        languages.append(armenianNumerals)
        languages.append(armenian)
        languages.append(catalan)
        languages.append(chineseFinancial)
        languages.append(chineseSimplified)
        languages.append(chineseTraditional)
        languages.append(danish)
        languages.append(english)
        languages.append(french)
        languages.append(german)
        languages.append(polish)
        languages.append(roman)
        languages.append(spanish)
        languages.append(thai)
        languages.append(thaiNumerals)
        languages.append(vietnamese)
    }
}
