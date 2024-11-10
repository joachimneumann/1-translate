//
//  Translate_1SelectedLanguagekeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

class Translate_1SelectedLanguagekeyboard: SmallKeyboard {
    let countryKey: Translate_1FlagKey
    override init(keySize: CGSize) {
        countryKey = Translate_1FlagKey(flagname: "")
        countryKey.borderColor = Color(UIColor.darkGray)
        countryKey.borderwidth = 5.0
        let settingsKey = SymbolKey(Translate_1Operation.settings)
        super.init(keySize: keySize)
        appendRow([countryKey, SymbolKey(Translate_1Operation.spacer), settingsKey])
    }
}
