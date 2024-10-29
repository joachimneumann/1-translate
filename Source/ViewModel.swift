//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

class ViewModel {
    let screen: Screen
    var calculator: Calculator
    var display: Display
    var numberTranslator: XNumberTranslator
    var basicKeyboard: BasicKeyboard
    var separator: Separator
    let intDisplay: IntDisplay
    
    
    func process() {
        if calculator.displayBuffer.count > 0 {
            if display.fits(calculator.displayBuffer) {
                display.left = calculator.displayBuffer
                display.right = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                if let right = display.right {
                    display.rightWidth = display.eDigitWidth + display.widestDigitWidth * CGFloat(right.count - 1)
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
        }
        basicKeyboard.back(calculator.privateDisplayBufferHasDigits)
        basicKeyboard.setPending(pendingOperators: calculator.pendingOperators)
        
        let allInOneLine = display.string
        numberTranslator.getResult(allInOneLine)
        //print(numberTranslator.translationResult)
    }

    func execute(_ key: Key) {
        calculator.press(key.op)
        process()
    }
    
//    private(set) var _voices: Voices!
//    var persistent = Persistent()
//
//
//    var voices: Voices {
//        return _voices
//    }

    init(screen: Screen) {
        self.screen = screen
        separator = Separator(separatorType: Separator.SeparatorType.comma, groups: true)
        intDisplay = IntDisplay(displayWidth: 10, separator: separator)
        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.numberDisplayFont, ePadding: screen.ePadding)
        basicKeyboard = BasicKeyboard(keySize: screen.keySize)
        numberTranslator = XNumberTranslator()
        basicKeyboard.callback = execute
        process()
    }

}
