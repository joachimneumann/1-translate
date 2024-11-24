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
    init(persistent: TranslatePersistent, toggle: (() -> ())?) {
        countryKey = FlagKey(
            persistent: persistent,
            languageEnum: persistent.currentLanguageEnum,
            toggle: toggle)
        super.init(settingsKey: countryKey)
    }
}

#Preview {
    KeyboardView(spacing: 5.0, keyboard: TranslateKeyboard(persistent: TranslatePersistent(), toggle: nil))
        .frame(height: 300)
}
