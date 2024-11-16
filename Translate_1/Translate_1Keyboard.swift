//
//  Translate_1Keyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftGmp
import SwiftUI

@Observable class Translate_1Keyboard: SmallKeyboard {
    let countryKey: Imagekey
    init() {
        countryKey = Imagekey(
            imageName: "",
            borderColor: Color(AppleColor.darkGray))
        super.init(settingsKey: countryKey)
    }
    
    func setSeparatorSymbol(_ symbol: String) {
        separatorKey.symbol = symbol
    }
}
