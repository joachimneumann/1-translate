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
        let languageConfigKey = Key(ConfigOperation.bottomLeft)
        languageConfigKey.imageName = translationManager.flagname(currentLanguage)
        languageConfigKey.borderColor = translationManager.borderColor(currentLanguage)
        let settingsKey = Key(ConfigOperation.settings)
        appendRow([languageConfigKey, Key(ConfigOperation.spacer), settingsKey])
    }
}
