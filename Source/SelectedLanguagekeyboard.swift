//
//  SelectedLanguagekeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftGmp
import Foundation
import NumberTranslator

class SelectedLanguagekeyboard: SmallKeyboard {
    init(keySize: CGSize, translationManager: TranslationManager, currentLanguage: NumberTranslator.Language) {
        super.init(keySize: keySize)
        let languageConfigKey = FlagKey(flagname: "CONFIG_"+translationManager.flagname(currentLanguage))
        let settingsKey = SymbolKey(ConfigOperation.settings)
        appendRow([languageConfigKey, SymbolKey(ConfigOperation.spacer), settingsKey])
    }
}
