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
    let countryKey: Imagekey
    init(keySize: CGSize) {
        countryKey = Imagekey(imageName: "")
        countryKey.borderColor = Color(UIColor.darkGray)
        countryKey.borderwidth = 5.0
        super.init(keySize: keySize, settingsKey: countryKey)
    }
}
