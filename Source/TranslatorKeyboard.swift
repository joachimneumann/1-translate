//
//  TranslatorKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 01.11.2024.
//

import SwiftGmp
import SwiftUI

class TranslatorKeyboard: SmallKeyboard {
    override init(keySize: CGSize) {
        super.init(keySize: keySize)
        
        let changeSignKey = SymbolKey(InplaceOperation.changeSign)
        let percentKey = SymbolKey(PercentOperation.percent)
        let divideKey = SymbolKey(TwoOperantOperation.div)
        appendRow([clearKey, changeSignKey, percentKey, divideKey])
        
        let sevenKey = SymbolKey(DigitOperation.seven)
        let eightKey = SymbolKey(DigitOperation.eight)
        let nineKey = SymbolKey(DigitOperation.nine)
        let multiplyKey = SymbolKey(TwoOperantOperation.mul)
        appendRow([sevenKey, eightKey, nineKey, multiplyKey])
        
        let fourKey = SymbolKey(DigitOperation.four)
        let fiveKey = SymbolKey(DigitOperation.five)
        let sixKey = SymbolKey(DigitOperation.six)
        let subtractKey = SymbolKey(TwoOperantOperation.sub)
        appendRow([fourKey, fiveKey, sixKey, subtractKey])
        
        let oneKey = SymbolKey(DigitOperation.one)
        let twoKey = SymbolKey(DigitOperation.two)
        let threeKey = SymbolKey(DigitOperation.three)
        let addKey = SymbolKey(TwoOperantOperation.add)
        appendRow([oneKey, twoKey, threeKey, addKey])
        
        let zeroKey = SymbolKey(DigitOperation.zero)
        let decimalKey = SymbolKey(DigitOperation.dot)
        let equalsKey = SymbolKey(EqualOperation.equal)
        appendRow([bottomLeftKey, zeroKey, decimalKey, equalsKey])
    }
}
