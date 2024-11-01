//
//  BasicKeyboard.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

@Observable class Key: Identifiable, Hashable {
    var keySize: CGSize = CGSize(width: 10, height: 10)
    let sixColors: KeyColor.SixColors
    var downTime: Double = 0.15
    var upTime: Double = 0.4
    var isPending: Bool = false
    var borderColor: Color? = nil
    var imageName: String? = nil
    var op: any OpProtocol
    var callback: (Key) -> () = { _ in }
    init(_ op: any OpProtocol) {
        self.op = op
        sixColors = KeyColor.sixColors(op: op)
    }
    
    var id = UUID()
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Key, rhs: Key) -> Bool {
        lhs.id == rhs.id
    }
}

class KeyRow: Identifiable {
    var id = UUID()
    var keys: [Key] = []
    init(_ keys: [Key]) {
        self.keys = keys
    }
}

@Observable class BasicKeyboard {
    var configKey: Key = Key(ConfigOperation.config)
    var rows: [KeyRow] = []
    let clearKey: Key
    var callback: (Key) -> () = { _ in } {
        didSet {
            for r in rows {
                for k in r.keys {
                    k.callback = callback
                }
            }
        }
    }
    
    private var upHasHappended: [Key: Bool] = [:]
    private var downAnimationFinished: [Key: Bool] = [:]
    private let downTime = 0.15
    private let upTime = 0.4
    
    init(keySize: CGSize, list of flags) {
    }
    init(keySize: CGSize) {
        self.clearKey = Key(ClearOperation.clear)
        let changeSignKey = Key(InplaceOperation.changeSign)
        let percentKey = Key(PercentOperation.percent)
        let divideKey = Key(TwoOperantOperation.div)
        rows.append(KeyRow([clearKey, changeSignKey, percentKey, divideKey]))
        let sevenKey = Key(DigitOperation.seven)
        let eightKey = Key(DigitOperation.eight)
        let nineKey = Key(DigitOperation.nine)
        let multiplyKey = Key(TwoOperantOperation.mul)
        rows.append(KeyRow([sevenKey, eightKey, nineKey, multiplyKey]))
        let fourKey = Key(DigitOperation.four)
        let fiveKey = Key(DigitOperation.five)
        let sixKey = Key(DigitOperation.six)
        let subtractKey = Key(TwoOperantOperation.sub)
        rows.append(KeyRow([fourKey, fiveKey, sixKey, subtractKey]))
        let oneKey = Key(DigitOperation.one)
        let twoKey = Key(DigitOperation.two)
        let threeKey = Key(DigitOperation.three)
        let addKey = Key(TwoOperantOperation.add)
        rows.append(KeyRow([oneKey, twoKey, threeKey, addKey]))
        configKey.imageName = "config"
        configKey.borderColor = nil
        let zeroKey = Key(DigitOperation.zero)
        let decimalKey = Key(DigitOperation.dot)
        let equalsKey = Key(EqualOperation.equal)
        rows.append(KeyRow([configKey, zeroKey, decimalKey, equalsKey]))
        
        for r in rows {
            for k in r.keys {
                k.keySize = keySize
            }
        }
    }
    
    func setPending(pendingOperators: [any OpProtocol]) {
        for r in rows {
            for k in r.keys {
                k.isPending = pendingOperators.contains(where: { $0.isEqual(to: k.op) })
            }
        }
    }
    
    func back(_ isBack: Bool) {
        if isBack {
            self.clearKey.op = ClearOperation.back
        } else {
            self.clearKey.op = ClearOperation.clear
        }
    }
    
    
}
