//
//  TranslatorKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftGmp
import SwiftUI

@Observable class Translate_1Keyboard: SmallKeyboard {
    let clearKey: SymbolKey
    let countryKey: FlagKey
    let separatorKey: SymbolKey
    override init(keySize: CGSize) {
        clearKey = SymbolKey(ClearOperation.clear)
        let changeSignKey = SymbolKey(InplaceOperation.changeSign)
        let percentKey = SymbolKey(PercentOperation.percent)
        let divideKey = SymbolKey(TwoOperantOperation.div)
        
        let sevenKey = SymbolKey(DigitOperation.seven)
        let eightKey = SymbolKey(DigitOperation.eight)
        let nineKey = SymbolKey(DigitOperation.nine)
        let multiplyKey = SymbolKey(TwoOperantOperation.mul)
        
        let fourKey = SymbolKey(DigitOperation.four)
        let fiveKey = SymbolKey(DigitOperation.five)
        let sixKey = SymbolKey(DigitOperation.six)
        let subtractKey = SymbolKey(TwoOperantOperation.sub)
        
        let oneKey = SymbolKey(DigitOperation.one)
        let twoKey = SymbolKey(DigitOperation.two)
        let threeKey = SymbolKey(DigitOperation.three)
        let addKey = SymbolKey(TwoOperantOperation.add)
        
        countryKey = FlagKey(flagname: "")
        countryKey.borderColor = Color(UIColor.darkGray)
        countryKey.borderwidth = 5.0
        let zeroKey = SymbolKey(DigitOperation.zero)
        separatorKey = SymbolKey(DigitOperation.dot)
        let equalsKey = SymbolKey(EqualOperation.equal)

        super.init(keySize: keySize)

        appendRow([clearKey, changeSignKey, percentKey, divideKey])
        appendRow([sevenKey, eightKey, nineKey, multiplyKey])
        appendRow([fourKey, fiveKey, sixKey, subtractKey])
        appendRow([oneKey, twoKey, threeKey, addKey])
        appendRow([countryKey, zeroKey, separatorKey, equalsKey])
    }
    
    func setSeparatorSymbol(_ symbol: String) {
        separatorKey.symbol = symbol
    }
    
    func back(_ displayBufferHasDigits: Bool) {
        if displayBufferHasDigits {
            clearKey.op = ClearOperation.back
            clearKey.symbol = ClearOperation.back.getRawValue()
        } else {
            clearKey.op = ClearOperation.clear
            clearKey.symbol = ClearOperation.clear.getRawValue()
        }
    }

}
