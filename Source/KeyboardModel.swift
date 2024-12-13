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
    var displayFrame: CGSize = .zero
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
        if showArrow {
            clearKey.symbolKey?.op = ClearOperation.back
            clearKey.symbolKey?.symbol = ClearOperation.back.getRawValue()
        } else {
            clearKey.symbolKey?.op = ClearOperation.clear
            clearKey.symbolKey?.symbol = ClearOperation.clear.getRawValue()
        }
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
