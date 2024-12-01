//
//  CalculatorKeyboard.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI


@Observable class CalculatorKeyboard {
    var keyMatrix: [[CalculatorKey]] = []
    var keyDiameter: CGFloat = 0
    var keySpacing: CGFloat = 0

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
    
    func setSize(_ size: CGSize) {
        keySpacing = min(size.height, size.width) / rowCount * 0.4

        print("keySpacing \(keySpacing)")
        print("size.width = \(size.width)")
        print("columnCount = \(columnCount)")
        print("rowCount = \(rowCount)")
        let keyDiameterWidth = (size.width - (columnCount) * keySpacing) / columnCount
        print("keyDiameterWidth = \(keyDiameterWidth)")
        let keyDiameterHeight = (size.height - (rowCount) * keySpacing) / rowCount
        print("keyDiameterHeight = \(keyDiameterHeight)")
        let height = (keyDiameter + keySpacing) * rowCount
        let width = (keyDiameter + keySpacing) * columnCount
        print("CalculatorKeyboard width = \(width)")
        print("CalculatorKeyboard height = \(height)")
        print("CalculatorKeyboard diameter = \(keyDiameter)")

        if keyDiameterWidth < keyDiameterHeight {
            keyDiameter = keyDiameterWidth
        } else {
            keyDiameter = keyDiameterHeight
        }

        for row in keyMatrix {
            for k in row {
                k.setDiameter(keyDiameter)
            }
        }
    }
    
    var calculatorCallback: (CalculatorKey) -> () = { _ in } {
        didSet {
            for row in keyMatrix {
                for k in row {
                    k.calculatorCallback = calculatorCallback
                }
            }
        }
    }
}
