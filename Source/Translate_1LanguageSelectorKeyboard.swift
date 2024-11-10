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
    init(keySize: CGSize, translate_1Manager: Translate_1Manager) {
        super.init(keySize: keySize)
        var columnIndex = 1
        var tempRow: [Key] = []
        for language in translate_1Manager.sortedlanguages {
            let tempKey = Translate_1FlagKey(flagname: translate_1Manager.flagname(language), borderColor: translate_1Manager.borderColor(language))
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
