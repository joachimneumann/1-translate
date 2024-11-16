//
//  Translate_1SelectLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

class Translate_1SelectLanguage: Keyboard {
    let countryKey: Imagekey
    let countryDescriptionKey: TextKey
    init(translate_1Manager: Translate_1Manager, keySpacing: CGFloat, borderColor: Color) {
        countryKey = Imagekey(
            imageName: "",
            borderColor: borderColor)
        countryDescriptionKey = TextKey(top: "", bottom: nil)
        super.init()
        var columnIndex = 1
        var tempRow: [Key] = []
        for language in translate_1Manager.sortedlanguages {
            let tempKey = Imagekey(
                imageName: translate_1Manager.flagname(language),
                borderColor: translate_1Manager.borderColor(language))
            tempRow.append(tempKey)
            columnIndex += 1
            if columnIndex == 5 {
                keyMatrix.append(tempRow)
                tempRow.removeAll()
                columnIndex = 1
            }
        }
        tempRow = []
        tempRow.append(countryKey)
#if TRANSLATE_1
        tempRow.append(countryDescriptionKey)
        tempRow.append(SymbolKey(Translate_1Operation.settings))
#else
        tempRow.append(countryDescriptionKey)
#endif
        keyMatrix.append(tempRow)
    }
}
