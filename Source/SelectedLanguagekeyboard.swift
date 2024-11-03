//
//  SelectedLanguagekeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

class SelectedLanguagekeyboard: SmallKeyboard {
    let countryKey: FlagKey
    override init(keySize: CGSize) {
        countryKey = FlagKey(flagname: "")
        countryKey.borderColor = Color(UIColor.darkGray)
        countryKey.borderwidth = 5.0
        let settingsKey = SymbolKey(ConfigOperation.settings)
        super.init(keySize: keySize)
        appendRow([countryKey, SymbolKey(ConfigOperation.spacer), settingsKey])
    }
}
