//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI
import SwiftGmp

public typealias AppleFont = UIFont

class ViewModel: ObservableObject {
    var screen: Screen
    var calculator: Calculator
    @Published var display: Display
    let smallKeyboard: SmallKeyboard
    
    init(screen: Screen = Screen()) {
        self.screen = screen
        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.numberDisplayFont, ePadding: screen.ePadding)
        smallKeyboard = SmallKeyboard(keySize: screen.keySize)
    }
    
    func process() {
        display.separatorCharacter = "."
        display.groupingCharacter = nil
        if calculator.displayBuffer.count > 0 {
            var withGrouping: String = calculator.displayBuffer
            inject(into: &withGrouping, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
            if display.fits(withGrouping) {
                display.left = withGrouping
                display.right = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
                if var right = display.right {
                    inject(into: &right, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
                    display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter)
        }
        
        smallKeyboard.back(calculator.privateDisplayBufferHasDigits)
    }
    
    func execute(_ key: Key) {
        if let symbolKey = key as? SymbolKey {
            calculator.press(symbolKey.op)
            for row in smallKeyboard.keyMatrix {
                for k in row {
                    if let symbolKey = k as? SymbolKey {
                        if calculator.pendingOperators.contains(where: { $0.isEqual(to: symbolKey.op) }) {
                            symbolKey.setColors(
                                upColor: KeyColor.sixColors(op: symbolKey.op).pendingUpColor,
                                downColor: KeyColor.sixColors(op: symbolKey.op).pendingDownColor)
                        } else {
                            symbolKey.setColors(
                                upColor: KeyColor.sixColors(op: symbolKey.op).upColor,
                                downColor: KeyColor.sixColors(op: symbolKey.op).downColor)
                        }
                    }
                }
            }
            process()
        }
    }
}
