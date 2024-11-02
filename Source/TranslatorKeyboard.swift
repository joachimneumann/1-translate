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
        
        bottomLeftKey.imageName = "English"
        bottomLeftKey.borderColor = Color(UIColor.lightGray)

        let changeSignKey = Key(InplaceOperation.changeSign)
        let percentKey = Key(PercentOperation.percent)
        let divideKey = Key(TwoOperantOperation.div)
        appendRow([clearKey, changeSignKey, percentKey, divideKey])
        
        let sevenKey = Key(DigitOperation.seven)
        let eightKey = Key(DigitOperation.eight)
        let nineKey = Key(DigitOperation.nine)
        let multiplyKey = Key(TwoOperantOperation.mul)
        appendRow([sevenKey, eightKey, nineKey, multiplyKey])
        
        let fourKey = Key(DigitOperation.four)
        let fiveKey = Key(DigitOperation.five)
        let sixKey = Key(DigitOperation.six)
        let subtractKey = Key(TwoOperantOperation.sub)
        appendRow([fourKey, fiveKey, sixKey, subtractKey])
        
        let oneKey = Key(DigitOperation.one)
        let twoKey = Key(DigitOperation.two)
        let threeKey = Key(DigitOperation.three)
        let addKey = Key(TwoOperantOperation.add)
        appendRow([oneKey, twoKey, threeKey, addKey])
        
        let zeroKey = Key(DigitOperation.zero)
        let decimalKey = Key(DigitOperation.dot)
        let equalsKey = Key(EqualOperation.equal)
        appendRow([bottomLeftKey, zeroKey, decimalKey, equalsKey])
    }
}
