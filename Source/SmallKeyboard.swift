//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp


@Observable class SmallKeyboard: Keyboard {
    let clearKey: SymbolKey
    let separatorKey: SymbolKey
    
    init(settingsKey: Key) {
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
        
        // settingsKey is parameter of init()
        let zeroKey = SymbolKey(DigitOperation.zero)
        separatorKey = SymbolKey(DigitOperation.dot)
        let equalsKey = SymbolKey(EqualOperation.equal)
        
        super.init()
        keyMatrix.append([clearKey, changeSignKey, percentKey, divideKey])
        keyMatrix.append([sevenKey, eightKey, nineKey, multiplyKey])
        keyMatrix.append([fourKey, fiveKey, sixKey, subtractKey])
        keyMatrix.append([oneKey, twoKey, threeKey, addKey])
        keyMatrix.append([settingsKey, zeroKey, separatorKey, equalsKey])
    }
    
    func back(_ displayBufferHasDigits: Bool) {
        if displayBufferHasDigits {
            clearKey.model.op = ClearOperation.back
            clearKey.model.symbol = ClearOperation.back.getRawValue()
        } else {
            clearKey.model.op = ClearOperation.clear
            clearKey.model.symbol = ClearOperation.clear.getRawValue()
        }
    }

    func setSeparatorSymbol(_ symbol: String) {
        separatorKey.model.symbol = symbol
    }
}
