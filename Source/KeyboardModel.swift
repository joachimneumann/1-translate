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
    let settingsKey: KeyModel
    
    var keyMatrix: [[KeyModel]] = []
    var diameter: CGFloat = 0
    var frame: CGSize = .zero
    var padding: CGFloat = 0

    init() {
        clearKey = KeyModel(op: ClearOperation.clear)
        separatorKey = KeyModel(op: DigitOperation.dot)
        settingsKey = KeyModel(op: InplaceOperation.abs)
    }
    
    func setSeparatorSymbol(_ symbol: String) {
        separatorKey.symbolKeyViewModel?.symbol = symbol
    }
    
    func back(_ showArrow: Bool) {
        if showArrow {
            clearKey.symbolKeyViewModel?.op = ClearOperation.back
            clearKey.symbolKeyViewModel?.symbol = ClearOperation.back.getRawValue()
        } else {
            clearKey.symbolKeyViewModel?.op = ClearOperation.clear
            clearKey.symbolKeyViewModel?.symbol = ClearOperation.clear.getRawValue()
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
    
    var calculatorCallback: (KeyModel) -> () = { _ in } {
        didSet {
            for row in keyMatrix {
                for k in row {
                    k.calculatorCallback = calculatorCallback
                }
            }
        }
    }
}
