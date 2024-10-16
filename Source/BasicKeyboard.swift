//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI

@Observable class AKey: Identifiable {
    var id = UUID()
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

class KeyRow: Identifiable {
    var id = UUID()
    var keys: [AKey] = []
    init(_ keys: [AKey]) {
        self.keys = keys
    }
}

class BasicKeyboard {
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
    
    func back(_ isBack: Bool) {
        if isBack {
            print("set to C")
            rows[0].keys[0].label = "C"
        } else {
            rows[0].keys[0].label = "AC"
        }
    }
    
    func keyDownX(_ aKey: AKey) {
        print("keyDownX rows[0].keys[0].label = \(rows[0].keys[0].label)")
        if aKey.label == "AC" {
            print("AC!")
            back(true)
        }
        print("down \(aKey.label)")
    }
    func keyUpX(_ aKey: AKey) {
        print("up   \(aKey.label)")
    }

}
