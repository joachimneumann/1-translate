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
    init(keySize: CGSize, translationManager: TranslationManager) {
        super.init(keySize: keySize)
        let languageConfigKey = Key(ConfigOperation.config)
        languageConfigKey.imageName = translationManager.flagname
        languageConfigKey.borderColor = translationManager.borderColor(translationManager.flagname)
        let settingsKey = Key(ConfigOperation.settings)
        appendRow([languageConfigKey, Key(ConfigOperation.spacer), settingsKey])
    }
}
