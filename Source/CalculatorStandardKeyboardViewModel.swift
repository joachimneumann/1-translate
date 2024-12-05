//
//  CalculatorStandardKeyboardViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI
import SwiftGmp


@Observable class CalculatorStandardKeyboardViewModel: CalculatorKeyboardViewModel {
    let clearKey: KeyModel
    let separatorKey: KeyModel
    
    init(heightProportion: CGFloat, settingsKey: KeyModel = KeyModel(op: InplaceOperation.abs)) {
        clearKey = KeyModel(op: ClearOperation.clear)
        let changeSignKey = KeyModel(op: InplaceOperation.changeSign)
        let percentKey = KeyModel(op: PercentOperation.percent)
        let divideKey = KeyModel(op: TwoOperantOperation.div)
        
        let sevenKey = KeyModel(op: DigitOperation.seven)
        let eightKey = KeyModel(op: DigitOperation.eight)
        let nineKey = KeyModel(op: DigitOperation.nine)
        let multiplyKey = KeyModel(op: TwoOperantOperation.mul)
        
        let fourKey = KeyModel(op: DigitOperation.four)
        let fiveKey = KeyModel(op: DigitOperation.five)
        let sixKey = KeyModel(op: DigitOperation.six)
        let subtractKey = KeyModel(op: TwoOperantOperation.sub)
        
        let oneKey = KeyModel(op: DigitOperation.one)
        let twoKey = KeyModel(op: DigitOperation.two)
        let threeKey = KeyModel(op: DigitOperation.three)
        let addKey = KeyModel(op: TwoOperantOperation.add)
        
        // settingsKey is parameter of init()
        let zeroKey = KeyModel(op: DigitOperation.zero)
        separatorKey = KeyModel(op: DigitOperation.dot)
        let equalsKey = KeyModel(op: EqualOperation.equal)
        
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
