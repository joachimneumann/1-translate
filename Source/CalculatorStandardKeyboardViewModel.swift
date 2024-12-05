//
//  CalculatorStandardKeyboardViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI
import SwiftGmp


@Observable class CalculatorStandardKeyboardViewModel: CalculatorKeyboardViewModel {
    let clearKey: CalculatorKey
    let separatorKey: CalculatorKey
    
    init(heightProportion: CGFloat, settingsKey: CalculatorKey = CalculatorKey(op: InplaceOperation.abs)) {
        clearKey = CalculatorKey(op: ClearOperation.clear)
        let changeSignKey = CalculatorKey(op: InplaceOperation.changeSign)
        let percentKey = CalculatorKey(op: PercentOperation.percent)
        let divideKey = CalculatorKey(op: TwoOperantOperation.div)
        
        let sevenKey = CalculatorKey(op: DigitOperation.seven)
        let eightKey = CalculatorKey(op: DigitOperation.eight)
        let nineKey = CalculatorKey(op: DigitOperation.nine)
        let multiplyKey = CalculatorKey(op: TwoOperantOperation.mul)
        
        let fourKey = CalculatorKey(op: DigitOperation.four)
        let fiveKey = CalculatorKey(op: DigitOperation.five)
        let sixKey = CalculatorKey(op: DigitOperation.six)
        let subtractKey = CalculatorKey(op: TwoOperantOperation.sub)
        
        let oneKey = CalculatorKey(op: DigitOperation.one)
        let twoKey = CalculatorKey(op: DigitOperation.two)
        let threeKey = CalculatorKey(op: DigitOperation.three)
        let addKey = CalculatorKey(op: TwoOperantOperation.add)
        
        // settingsKey is parameter of init()
        let zeroKey = CalculatorKey(op: DigitOperation.zero)
        separatorKey = CalculatorKey(op: DigitOperation.dot)
        let equalsKey = CalculatorKey(op: EqualOperation.equal)
        
        let screenSize = UIScreen.main.bounds
        let width = screenSize.width
        let height = screenSize.height * heightProportion

        super.init(size: CGSize(width: width, height: height))
        keyMatrix.append([clearKey, changeSignKey, percentKey, divideKey])
        keyMatrix.append([sevenKey, eightKey, nineKey, multiplyKey])
        keyMatrix.append([fourKey, fiveKey, sixKey, subtractKey])
        keyMatrix.append([oneKey, twoKey, threeKey, addKey])
        keyMatrix.append([settingsKey, zeroKey, separatorKey, equalsKey])
    }
        
    func back(_ displayBufferHasDigits: Bool) {
        if displayBufferHasDigits {
//            clearKey.op = ClearOperation.back
//            clearKey.symbol = ClearOperation.back.getRawValue()
        } else {
//            clearKey.model.op = ClearOperation.clear
//            clearKey.model.symbol = ClearOperation.clear.getRawValue()
        }
    }

    func setSeparatorSymbol(_ symbol: String) {
//        separatorKey.model.symbol = symbol
    }
}
