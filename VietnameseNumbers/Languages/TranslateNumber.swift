//
//  TranslateNumber.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import Foundation

class TranslateNumber {
    var languages: [Language2P] = []
    let arabicNumerals      = ArabicNumerals()
    let armenianNumerals    = ArmenianNumerals()
    let armenian            = Armenian()
    let catalan             = Catalan()
    let chineseFinancial    = Chinese(variant: .financial)
    let chineseSimplified   = Chinese(variant: .simplified)
    let chineseTraditional  = Chinese(variant: .traditional)
    let danish              = Danish()
    let digits              = Digits()
    let english: English   = EnglishImpl()
    let french              = French()
    let german              = German()
    let polish              = Polish()
    let roman               = Roman()
    let spanish             = Spanish()
    let thai                = Thai()
    let thaiNumerals        = ThaiNumerals()
    let vietnamese          = Vietnamese()

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
