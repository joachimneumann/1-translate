//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

@Observable class AKey: Identifiable {
    var id = UUID()
    var label: String
    let width: CGFloat
    let height: CGFloat
    let bgColor: Color
    let txtColor: Color
    var op: any OpProtocol
    init(_ label: String, _ op: any OpProtocol) {
        self.label = label
        self.op = op
        bgColor = .green
        txtColor = .white
        width = 50
        height = 30
    }
}

struct KeyRow: Identifiable {
    var id = UUID()
    var keys: [AKey] = []
    init(_ keys: [AKey]) {
        self.keys = keys
    }
}

struct BasicKeyboard {
    let calculator: Calculator
    var rows: [KeyRow] = []
    init(calculator: Calculator) {
        self.calculator = calculator
        let clearKey = AKey("AC", ClearOperation.clear)
        let changeSignKey = AKey("±", InplaceOperation.changeSign)
        let percentKey = AKey("%", PercentOperation.percent)
        let divideKey = AKey("÷", TwoOperantOperation.div)
        rows.append(KeyRow([clearKey, changeSignKey, percentKey, divideKey]))
        let sevenKey = AKey("7", DigitOperation.seven)
        let eightKey = AKey("8", DigitOperation.eight)
        let nineKey = AKey("9", DigitOperation.nine)
        let multiplyKey = AKey("×", TwoOperantOperation.mul)
        rows.append(KeyRow([sevenKey, eightKey, nineKey, multiplyKey]))
        let fourKey = AKey("4", DigitOperation.four)
        let fiveKey = AKey("5", DigitOperation.five)
        let sixKey = AKey("6", DigitOperation.six)
        let subtractKey = AKey("-", TwoOperantOperation.sub)
        rows.append(KeyRow([fourKey, fiveKey, sixKey, subtractKey]))
        let oneKey = AKey("1", DigitOperation.one)
        let twoKey = AKey("2", DigitOperation.two)
        let threeKey = AKey("3", DigitOperation.three)
        let addKey = AKey("+", TwoOperantOperation.add)
        rows.append(KeyRow([oneKey, twoKey, threeKey, addKey]))
        let settingsKey = AKey("S", DigitOperation.zero)
        let zeroKey = AKey("0", DigitOperation.zero)
        let decimalKey = AKey(".", DigitOperation.dot)
        let equalsKey = AKey("=", EqualOperation.equal)
        rows.append(KeyRow([settingsKey, zeroKey, decimalKey, equalsKey]))
    }
    
    func back(_ isBack: Bool) {
        if isBack {
            print("set to C")
            rows[0].keys[0].label = "C"
            rows[0].keys[0].op = ClearOperation.back
        } else {
            rows[0].keys[0].label = "AC"
            rows[0].keys[0].op = ClearOperation.clear
        }
    }
    
    func keyDownX(_ aKey: AKey) {
        print("down \(aKey.label)")
        
    }
    func keyUpX(_ aKey: AKey) {
        calculator.press(aKey.op)
        back(calculator.displayBufferHasDigits)
        print("\(calculator.lr.string) up   \(aKey.label)")
    }

}
