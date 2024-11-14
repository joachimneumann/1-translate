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
    init(keySize: CGSize, translate_1Manager: Translate_1Manager, keySpacing: CGFloat, borderColor: Color, borderWidth: CGFloat) {
        countryKey = Imagekey(
            imageName: "",
            borderColor: borderColor,
            borderwidth: borderWidth)
        countryDescriptionKey = TextKey(top: "", bottom: nil)
        super.init(keySize: keySize)
        var columnIndex = 1
        var tempRow: [Key] = []
        for language in translate_1Manager.sortedlanguages {
            let tempKey = Imagekey(
                imageName: translate_1Manager.flagname(language),
                borderColor: translate_1Manager.borderColor(language),
                borderwidth: borderWidth)
            tempRow.append(tempKey)
            columnIndex += 1
            if columnIndex == 5 {
                appendRow(tempRow)
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
        appendRow(tempRow)
#if TRANSLATE_1
        countryDescriptionKey.width = keySize.width * 2 + keySpacing
#else
        countryDescriptionKey.width = keySize.width * 3 + 2 * keySpacing
#endif
    }
}
