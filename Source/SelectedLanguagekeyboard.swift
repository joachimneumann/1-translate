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
    let countryKey: FlagKey
    init(keySize: CGSize, translationManager: TranslationManager, currentLanguage: NumberTranslator.Language) {
        countryKey = FlagKey(flagname: "CONFIG_"+translationManager.flagname(currentLanguage))
        countryKey.borderColor = .gray
        countryKey.borderwidth = 5.0
        let settingsKey = SymbolKey(ConfigOperation.settings)
        super.init(keySize: keySize)
        appendRow([countryKey, SymbolKey(ConfigOperation.spacer), settingsKey])
    }
}
