//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 06.12.2024.
//

import SwiftUI
import SwiftGmp

enum KeyboardType {
    case standard
    case translator
}

@Observable class ViewModel {
    let keyboard: KeyboardModel = KeyboardModel()
    let display: Display
    let calculator = Calculator(precision: 100)
 
    init(_ keybordType: KeyboardType) {
        //print("ViewModel init()")
        switch keybordType {
            case .standard:
            keyboard.standardKeyboard()
            case .translator:
            keyboard.translatorKeyboard(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height * 0.5)
        }
        let displayWidth: CGFloat = keyboard.frame.width - 2 * keyboard.padding
        display = Display(floatDisplayWidth: displayWidth, font: AppleFont.systemFont(ofSize: floor(keyboard.diameter / 1.3)), ePadding: 10.0)
        display.left = "0"
        keyboard.callback = execute
    }
    
    func process() {
        if calculator.displayBuffer.count > 0 {
            var withGrouping: String = calculator.displayBuffer
            inject(into: &withGrouping, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
            if display.fits(withGrouping) {
                display.left = withGrouping
                display.right = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
                if var right = display.right {
                    inject(into: &right, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
                    display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            if let right = display.right {
                display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
            }

            inject(into: &display.left, separatorCharacter: display.separatorCharacter, groupingCharacter: display.groupingCharacter, groupSize: display.groupSize)
        }
    }

    func execute(_ key: KeyAnimation) {
        if let keyModel = key as? KeyModel {
            if let op = keyModel.symbolKey?.op {
                calculator.press(op)
            }
            process()
            
            // clear button: AC or arrow?
            keyboard.back(calculator.privateDisplayBufferHasDigits)
            
            // pending buttons: text color
            for row in keyboard.keyMatrix {
                for k in row {
                    if let symbolKey = k.symbolKey {
                        if calculator.pendingOperators.contains(where: { $0.isEqual(to: symbolKey.op) }) {
                            symbolKey.textColor = .orange
                        } else {
                            symbolKey.textColor = Color.Neumorphic.text
                        }
                    }
                }
            }
        }
           // keyboard.back(calculator.privateDisplayBufferHasDigits)
//            calculator.press(symbolKey.model.op)
//            if let smallKeyboard = smallKeyboard {
//                smallKeyboard.back(calculator.privateDisplayBufferHasDigits)
//                for row in smallKeyboard.keyMatrix {
//                    for k in row {
//                        if let symbolKey = k as? SymbolKey {
//                            if calculator.pendingOperators.contains(where: { $0.isEqual(to: symbolKey.model.op) }) {
//                                symbolKey.setColors(
//                                    textColor: KeyColor.sixColors(op: symbolKey.model.op).pendingTextColor,
//                                    upColor: KeyColor.sixColors(op: symbolKey.model.op).pendingUpColor,
//                                    downColor: KeyColor.sixColors(op: symbolKey.model.op).pendingDownColor)
//                            } else {
//                                symbolKey.setColors(
//                                    textColor: KeyColor.sixColors(op: symbolKey.model.op).textColor,
//                                    upColor: KeyColor.sixColors(op: symbolKey.model.op).upColor,
//                                    downColor: KeyColor.sixColors(op: symbolKey.model.op).downColor)
//                            }
//                        }
//                    }
//                }
//            }
    }

}
