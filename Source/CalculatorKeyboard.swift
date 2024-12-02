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
        let keySpacingProportion = 0.4

        let keyDiameterHorizontal = size.width / columnCount / (1.0 + keySpacingProportion)
        let keyDiameterVertical = size.height / rowCount / (1.0 + keySpacingProportion)
        keyDiameter = min(keyDiameterVertical, keyDiameterHorizontal)
        keySpacing = keyDiameter * keySpacingProportion
        print("keyDiameter \(keyDiameter)")
        print("keySpacing \(keySpacing)")

        //let height = (keyDiameter + keySpacing) * rowCount
        //let width = (keyDiameter + keySpacing) * columnCount
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
