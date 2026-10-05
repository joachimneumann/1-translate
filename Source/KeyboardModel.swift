//
//  KeyboardModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI
import SwiftGmp

@Observable class KeyboardModel {
    let clearKey: KeyModel
    let separatorKey: KeyModel
    
    var keyMatrix: [[KeyModel]] = []
    var keyboardFrame: CGSize = .zero
    var padding: CGFloat = 0
    var spacing: CGFloat = 0

    init() {
        clearKey = KeyModel(op: ClearOperation.clear)
        separatorKey = KeyModel(op: DigitOperation.dot)
    }
    
    func setSeparatorSymbol(_ symbol: String) {
        separatorKey.symbolKey?.symbol = symbol
    }
    
    func back(_ showArrow: Bool) {
        let hasDeleteKey = keyMatrix.joined().contains { key in
            key !== clearKey && key.symbolKey?.op.isEqual(to: ClearOperation.back) == true
        }
        let op: ClearOperation = showArrow && !hasDeleteKey ? .back : .clear
        clearKey.symbolKey?.op = op
        clearKey.symbolKey?.symbol = op.getRawValue()
    }

    var rowCount: CGFloat {
        CGFloat(keyMatrix.count)
    }
    var columnCount: CGFloat {
        var ret = 0
        for row in keyMatrix {
            if row.count > ret {
                ret = row.count
            }
        }
        return CGFloat(ret)
    }
    
    var callback: (KeyAnimation) -> () = { _ in } {
        didSet {
            for row in keyMatrix {
                for k in row {
                    k.callback = callback
                }
            }
        }
    }
}
