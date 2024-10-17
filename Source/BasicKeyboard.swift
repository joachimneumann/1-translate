//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

@Observable class AKey: Identifiable, Hashable {
    var keySize: CGSize = CGSize(width: 10, height: 10)
    let sixColors: KeyColor.SixColors
    var downTime: Double = 0.15
    var isPending: Bool = false
    var upTime: Double = 0.4
    var op: any OpProtocol
    var execute: () -> () = { }
    init(_ op: any OpProtocol) {
        self.op = op
        sixColors = KeyColor.sixColors(op: op)
    }

    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: AKey, rhs: AKey) -> Bool {
        lhs.id == rhs.id
    }
}

class KeyRow: Identifiable {
    var id = UUID()
    var keys: [AKey] = []
    init(_ keys: [AKey]) {
        self.keys = keys
    }
}

class BasicKeyboard {
    let calculator: Calculator
    let spacing: CGFloat
    let keySize: CGSize
    var rows: [KeyRow] = []
    
    private var upHasHappended: [AKey: Bool] = [:]
    private var downAnimationFinished: [AKey: Bool] = [:]
    private let downTime = 0.15
    private let upTime = 0.4

    func execute(_ key: AKey) {
        //print("execute \(key.op.getRawValue())")
        calculator.press(key.op)
        for r in rows {
            for k in r.keys {
                if calculator.pendingOperators.contains(where: { $0.isEqual(to: k.op) } ) {
                    k.isPending = true
                } else {
                    k.isPending = false
                }

            }
        }
        //print(calculator.lr.string)
        back(calculator.displayBufferHasDigits)
    }
    
    init(calculator: Calculator = Calculator(precision: 20), spacing: CGFloat, keySize: CGSize) {
        self.calculator = calculator
        self.spacing = spacing
        self.keySize = keySize
        let clearKey = AKey(ClearOperation.clear)
        let changeSignKey = AKey(InplaceOperation.changeSign)
        let percentKey = AKey(PercentOperation.percent)
        let divideKey = AKey(TwoOperantOperation.div)
        rows.append(KeyRow([clearKey, changeSignKey, percentKey, divideKey]))
        let sevenKey = AKey(DigitOperation.seven)
        let eightKey = AKey(DigitOperation.eight)
        let nineKey = AKey(DigitOperation.nine)
        let multiplyKey = AKey(TwoOperantOperation.mul)
        rows.append(KeyRow([sevenKey, eightKey, nineKey, multiplyKey]))
        let fourKey = AKey(DigitOperation.four)
        let fiveKey = AKey(DigitOperation.five)
        let sixKey = AKey(DigitOperation.six)
        let subtractKey = AKey(TwoOperantOperation.sub)
        rows.append(KeyRow([fourKey, fiveKey, sixKey, subtractKey]))
        let oneKey = AKey(DigitOperation.one)
        let twoKey = AKey(DigitOperation.two)
        let threeKey = AKey(DigitOperation.three)
        let addKey = AKey(TwoOperantOperation.add)
        rows.append(KeyRow([oneKey, twoKey, threeKey, addKey]))
        let settingsKey = AKey(DigitOperation.zero)
        let zeroKey = AKey(DigitOperation.zero)
        let decimalKey = AKey(DigitOperation.dot)
        let equalsKey = AKey(EqualOperation.equal)
        rows.append(KeyRow([settingsKey, zeroKey, decimalKey, equalsKey]))
        
        for r in rows {
            for k in r.keys {
                k.execute = {
                    self.execute(k)
                }
                k.keySize = keySize
            }
        }
    }
    
    func back(_ isBack: Bool) {
        if isBack {
            rows[0].keys[0].op = ClearOperation.back
        } else {
            rows[0].keys[0].op = ClearOperation.clear
        }
    }
    

}
