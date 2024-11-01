//
//  LanguageSelectorKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftGmp
import Foundation
import NumberTranslator

class LanguageSelectorKeyboard: SmallKeyboard {
    init(keySize: CGSize, translationManager: TranslationManager) {
        super.init(keySize: keySize)
        scrollAfterRow = 4
        var columnIndex = 1
        var tempRow: [Key] = []
        for flagname in translationManager.implementedFlagnames {
            let tempKey = Key(ConfigOperation.flagname)
            tempKey.imageName = flagname
            tempKey.borderColor = translationManager.borderColor(flagname)
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
