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
    init(keySize: CGSize, borderwidth: CGFloat) {
        countryKey = Imagekey(
            imageName: "",
            borderColor: Color(AppleColor.darkGray),
            borderwidth: borderwidth)
        super.init(keySize: keySize, settingsKey: countryKey)
    }
    
    func setSeparatorSymbol(_ symbol: String) {
        separatorKey.symbol = symbol
    }
    
}
