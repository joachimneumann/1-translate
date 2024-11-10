//
//  LanguageSelectorKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftGmp
import Foundation
import NumberTranslator

class Translate_1LanguageSelectorKeyboard: SmallKeyboard {
    init(keySize: CGSize, translationManager: TranslationManager) {
        super.init(keySize: keySize)
        var columnIndex = 1
        var tempRow: [Key] = []
        for language in translationManager.sortedlanguages {
            let tempKey = FlagKey(flagname: translationManager.flagname(language), borderColor: translationManager.borderColor(language))
            tempRow.append(tempKey)
            columnIndex += 1
            if columnIndex == 5 {
                appendRow(tempRow)
                tempRow.removeAll()
                columnIndex = 1
            }
        }
    }
}
