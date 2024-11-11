//
//  LanguageSelectorKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

class Translate_1LanguageSelectorKeyboard: Keyboard {
    let countryKey: Imagekey
    let countryDescriptionKey: TextKey
    init(keySize: CGSize, translate_1Manager: Translate_1Manager, keySpacing: CGFloat) {
        countryKey = Imagekey(imageName: "")
        countryKey.borderColor = Color(UIColor.darkGray)
        countryKey.borderwidth = 5.0
        countryDescriptionKey = TextKey(top: "", bottom: nil)
        super.init(keySize: keySize)
        var columnIndex = 1
        var tempRow: [Key] = []
        for language in translate_1Manager.sortedlanguages {
            let tempKey = Imagekey(imageName: translate_1Manager.flagname(language), borderColor: translate_1Manager.borderColor(language))
            tempRow.append(tempKey)
            columnIndex += 1
            if columnIndex == 5 {
                appendRow(tempRow)
                tempRow.removeAll()
                columnIndex = 1
            }
        }
        let settingsKey: SymbolKey = SymbolKey(Translate_1Operation.settings)
        tempRow = []
        tempRow.append(countryKey)
        tempRow.append(countryDescriptionKey)
        tempRow.append(settingsKey)
        appendRow(tempRow)
        countryDescriptionKey.width = keySize.width * 2 + keySpacing
//        countryKey.borderColor = Color(UIColor.darkGray)
//        countryKey.borderwidth = 5.0
        
//        super.init(keySize: keySize, settingsKey: countryKey)
    }
}
