//
//  KeyboardModelStandard.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI
import SwiftGmp

extension KeyboardModel {
    
    func standardKeyboard(width availableWidth: CGFloat = UIScreen.main.bounds.width, height availableHeight: CGFloat = UIScreen.main.bounds.height) {
        let keySpacingProportion = 0.4

        let changeSignKey = KeyModel(op: InplaceOperation.changeSign)
        let percentKey = KeyModel(op: PercentOperation.percent)
        let divideKey = KeyModel(op: TwoOperantOperation.div)
        
        let sevenKey = KeyModel(op: DigitOperation.seven)
        let eightKey = KeyModel(op: DigitOperation.eight)
        let nineKey = KeyModel(op: DigitOperation.nine)
        let multiplyKey = KeyModel(op: TwoOperantOperation.mul)
        
        let fourKey = KeyModel(op: DigitOperation.four)
        let fiveKey = KeyModel(op: DigitOperation.five)
        let sixKey = KeyModel(op: DigitOperation.six)
        let subtractKey = KeyModel(op: TwoOperantOperation.sub)
        
        let oneKey = KeyModel(op: DigitOperation.one)
        let twoKey = KeyModel(op: DigitOperation.two)
        let threeKey = KeyModel(op: DigitOperation.three)
        let addKey = KeyModel(op: TwoOperantOperation.add)
        
        let zeroKey = KeyModel(op: DigitOperation.zero)
        let equalsKey = KeyModel(op: EqualOperation.equal)
        
        self.keyMatrix.append([clearKey, changeSignKey, percentKey, divideKey])
        self.keyMatrix.append([sevenKey, eightKey, nineKey, multiplyKey])
        self.keyMatrix.append([fourKey, fiveKey, sixKey, subtractKey])
        self.keyMatrix.append([oneKey, twoKey, threeKey, addKey])
        self.keyMatrix.append([settingsKey, zeroKey, separatorKey, equalsKey])
        
        print("standardKeyboard available: \(availableWidth) \(availableHeight)")
        let totalKeysHorizontal = columnCount + keySpacingProportion * (columnCount)
        let diameterHorizontal = availableWidth / totalKeysHorizontal
        let totalKeysVertical = rowCount + keySpacingProportion * (rowCount)
        let diameterVertical = availableHeight / totalKeysVertical
        diameter = min(diameterVertical, diameterHorizontal)
        let spacing = diameter * keySpacingProportion
        padding = spacing * 0.5
        print("standardKeyboard diameter: \(diameter)")
        print("standardKeyboard padding: \(padding)")
        frame = CGSize(
            width: diameter * columnCount + spacing * (columnCount),
            height: diameter * rowCount + spacing * (rowCount))
        print("standardKeyboard actual: \(frame)")

        for row in keyMatrix {
            for k in row {
                k.setDiameter(diameter)
            }
        }

    }
}

