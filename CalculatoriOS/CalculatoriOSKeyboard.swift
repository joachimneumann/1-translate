//
//  CalculatoriOSKeyboard.swift
//  Calculator
//
//  Created by Joachim Neumann on 11.11.2024.
//

import SwiftGmp
import SwiftUI

@Observable class CalculatoriOSKeyboard: SmallKeyboard {
    let settingskey: SymbolKey
    init(keySize: CGSize) {
        settingskey = SymbolKey(CalculatoriOSOperation.settings)
        super.init(keySize: keySize, settingsKey: settingskey)
    }
    
    func setSeparatorSymbol(_ symbol: String) {
        separatorKey.symbol = symbol
    }
    
}
