//
//  LanguageSelectionKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import SwiftGmp
import NumberTranslator


class LanguageSelectionKeyboard: Keyboard {
    let countryKey: FlagKey
    let countryDescriptionKey: TextKey
    init(translate_1Manager: TranslateManager, keySpacing: CGFloat, borderColor: Color) {
        countryKey = FlagKey("")
        countryDescriptionKey = TextKey(top: "", bottom: nil)
        super.init()
        var columnIndex = 1
        var tempRow: [Key] = []
        for language in translate_1Manager.sortedlanguages {
            let tempKey = FlagKey(translate_1Manager.flagname(language))
            tempKey.selectLanguage = EmptySelectLanguageProtocol()
            tempRow.append(tempKey)
            columnIndex += 1
            if columnIndex == 5 {
                keyMatrix.append(tempRow)
                tempRow.removeAll()
                columnIndex = 1
            }
        }
        if tempRow.count > 0 {
            keyMatrix.append(tempRow)
        }
        tempRow = []
        tempRow.append(countryKey)
#if TRANSLATE_IOS
        tempRow.append(countryDescriptionKey)
        tempRow.append(SymbolKey(TranslateOperation.settings))
#else
        tempRow.append(countryDescriptionKey)
#endif
        keyMatrix.append(tempRow)
    }
    
    func setSelectLanguage(_ selectLanguage: SelectLanguageProtocol) {
        countryKey.selectLanguage = selectLanguage
        countryKey.isToggleButton = true

        for row in keyMatrix {
            for key in row {
                if let flagKey = key as? FlagKey {
                    flagKey.selectLanguage = selectLanguage
                }
            }
        }
    }
}
