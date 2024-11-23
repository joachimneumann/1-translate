//
//  TranslateKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftGmp
import SwiftUI

@Observable class TranslateKeyboard: SmallKeyboard {
    let countryKey: FlagKey
    init(persistent: TranslatePersistent) {
        print("5")
        countryKey = FlagKey(persistent: persistent, languageEnum: persistent.currentLanguageEnum)
        super.init(settingsKey: countryKey)
    }
}

#Preview {
    KeyboardView(spacing: 5.0, keyboard: TranslateKeyboard(persistent: TranslatePersistent()))
        .frame(height: 300)
}
