//
//  CalculatorKeyboardViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI


@Observable class CalculatorKeyboardViewModel {
    var keyMatrix: [[KeyModel]] = []
    var keyDiameter: CGFloat = 0
    var recommendedPadding: CGFloat = 0

    func setSize(_ size: CGSize) {
        print("init CalculatorKeyboardViewModel")
        let keySpacingProportion = 0.4

        let keyDiameterHorizontal = size.width / columnCount / (1.0 + keySpacingProportion)
        let keyDiameterVertical = size.height / rowCount / (1.0 + keySpacingProportion)
        keyDiameter = min(keyDiameterVertical, keyDiameterHorizontal)
        recommendedPadding = keyDiameter * (1.0 + keySpacingProportion) * 0.5
        print("keyDiameter \(keyDiameter)")
        print("recommendedPadding \(recommendedPadding)")
//        let height = (keyDiameter + keySpacing) * rowCount
//        let width = (keyDiameter + keySpacing) * columnCount
        for row in keyMatrix {
            for k in row {
                k.setDiameter(keyDiameter)
            }
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
    
//    func setSize(_ size: CGSize) {
//        print("init CalculatorKeyboard")
//        let keySpacingProportion = 0.4
//
//        let keyDiameterHorizontal = size.width / columnCount / (1.0 + keySpacingProportion)
//        let keyDiameterVertical = size.height / rowCount / (1.0 + keySpacingProportion)
//        keyDiameter = min(keyDiameterVertical, keyDiameterHorizontal)
//        keySpacing = keyDiameter * keySpacingProportion
//        print("keyDiameter \(keyDiameter)")
//        print("keySpacing \(keySpacing)")

        //let height = (keyDiameter + keySpacing) * rowCount
        //let width = (keyDiameter + keySpacing) * columnCount
//        for row in keyMatrix {
//            for k in row {
//                k.setDiameter(keyDiameter)
//            }
//        }
//    }
    
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
