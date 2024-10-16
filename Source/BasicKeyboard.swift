//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

@Observable class AKey: Identifiable, Hashable {
    var label: String
    let width: CGFloat
    let height: CGFloat
    var bgColor: Color
    var txtColor: Color
    var op: any OpProtocol
    init(_ op: any OpProtocol) {
        self.label = op.getRawValue()
        self.op = op
        bgColor = KeyColor.backgroundUpColorFor(op: op)
        txtColor = KeyColor.textColorFor(op: op)
        width = 50
        height = 30
    }

    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: AKey, rhs: AKey) -> Bool {
        lhs.id == rhs.id
    }
}

struct KeyRow: Identifiable {
    var id = UUID()
    var keys: [AKey] = []
    init(_ keys: [AKey]) {
        self.keys = keys
    }
}

class BasicKeyboard {
    let calculator: Calculator
    var rows: [KeyRow] = []
    
    private var upHasHappended: [AKey: Bool] = [:]
    private var downAnimationFinished: [AKey: Bool] = [:]
    private let downTime = 0.15
    private let upTime = 0.4

    init(calculator: Calculator = Calculator(precision: 20)) {
        self.calculator = calculator
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
    }
    
    func back(_ isBack: Bool) {
        if isBack {
            rows[0].keys[0].label = "C"
            rows[0].keys[0].op = ClearOperation.back
        } else {
            rows[0].keys[0].label = "AC"
            rows[0].keys[0].op = ClearOperation.clear
        }
    }
    
    
    func keyDown(_ key: AKey) {
        print("keyDown \(key.op.getRawValue())")
        upHasHappended[key] = false
        downAnimationFinished[key] = false
        withAnimation(.easeIn(duration: downTime)) {
            key.bgColor = KeyColor.backgroundDownColorFor(op: key.op)
        }
        Task(priority: .userInitiated) {
            try? await Task.sleep(nanoseconds: UInt64(downTime * 1_000_000_000))
            print("down: upHasHappended \(upHasHappended[key] ?? false)")
//            if upHasHappended[key] ?? false {
                withAnimation(.easeIn(duration: upTime)) {
                    key.bgColor = KeyColor.backgroundUpColorFor(op: key.op)
                }
//            }
            downAnimationFinished[key] = true
        }
    }
    
    func keyUp(_ key: AKey) {
        print("keyUp \(key.op.getRawValue())")
        calculator.press(key.op)
        //updateBackgroundColors(exceptFor: key)
        upHasHappended[key] = true
        print("keyUp downAnimationFinished \(downAnimationFinished[key] ?? false)")
        if downAnimationFinished[key] ?? false {
            withAnimation(.easeIn(duration: upTime)) {
                key.bgColor = KeyColor.backgroundUpColorFor(op: key.op)
            }
        }
        print("\(calculator.lr.string)")
    }

}
