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
    
    func updateEditingKeys(hasCurrentEntry: Bool, canBack: Bool) {
        let op: ClearOperation = hasCurrentEntry ? .clearEntry : .clear
        clearKey.symbolKey?.op = op
        clearKey.symbolKey?.symbol = op.getRawValue()
        clearKey.symbolKey?.newSize(CGSize(width: clearKey.width, height: clearKey.height))
        for key in keyMatrix.joined() where key.symbolKey?.op.isEqual(to: ClearOperation.back) == true {
            key.isEnabled = canBack
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

    var pressBegan: (KeyAnimation) -> () = { _ in } {
        didSet {
            for row in keyMatrix {
                for key in row {
                    key.pressBegan = pressBegan
                }
            }
        }
    }
}
