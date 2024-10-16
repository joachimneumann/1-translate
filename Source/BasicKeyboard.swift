//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

struct AKey: Identifiable {
    var id: String { label }
    var label: String
    let width: CGFloat
    let height: CGFloat
    let bgColor: Color
    let txtColor: Color
    init(_ label: String) {
        self.label = label
        bgColor = .green
        txtColor = .white
        width = 50
        height = 30
    }
}

struct KeyRow: Identifiable {
    var id: String { keys.map { $0.label }.joined(separator: "-") }
    var keys: [AKey] = []
    init(_ keys: [AKey]) {
        self.keys = keys
    }
}

struct BasicKeyboard {
    var rows: [KeyRow] = []
    init() {
        let clearKey = AKey("AC")
        let changeSignKey = AKey("±")
        let percentKey = AKey("%")
        let divideKey = AKey("÷")
        rows.append(KeyRow([clearKey, changeSignKey, percentKey, divideKey]))
        let sevenKey = AKey("7")
        let eightKey = AKey("8")
        let nineKey = AKey("9")
        let multiplyKey = AKey("×")
        rows.append(KeyRow([sevenKey, eightKey, nineKey, multiplyKey]))
        let fourKey = AKey("4")
        let fiveKey = AKey("5")
        let sixKey = AKey("6")
        let subtractKey = AKey("-")
        rows.append(KeyRow([fourKey, fiveKey, sixKey, subtractKey]))
        let oneKey = AKey("1")
        let twoKey = AKey("2")
        let threeKey = AKey("3")
        let addKey = AKey("+")
        rows.append(KeyRow([oneKey, twoKey, threeKey, addKey]))
        let settingsKey = AKey("settings")
        let zeroKey = AKey("0")
        let decimalKey = AKey(".")
        let equalsKey = AKey("=")
        rows.append(KeyRow([settingsKey, zeroKey, decimalKey, equalsKey]))
    }
    
    mutating func back(_ isBack: Bool) {
        if isBack {
            rows[0].keys[0].label = "C"
        } else {
            rows[0].keys[0].label = "AC"
        }
    }
}
