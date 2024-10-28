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
    var _1Translation: TranslationResult = TranslationResult(displayText: "", overline: nil, spokenText: nil)
    var basicKeyboard: BasicKeyboard
    var separator: Separator
    let intDisplay: IntDisplay
    
    
    func process() {
        if calculator.displayBuffer.count > 0 {
            if display.fits(calculator.displayBuffer) {
                display.leftContent = Display.Content(calculator.displayBuffer, font: screen.proportionalFont, width: nil)
                display.rightContent = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                display.leftContent = Display.Content(display.left, font: screen.proportionalFont, width: nil)
                if let rightText = display.right {
                    let width = display.eDigitWidth + display.widestDigitWidth * CGFloat(rightText.count - 1)
                    display.rightContent = Display.Content(rightText, font: screen.proportionalFont, width: width)
                } else {
                    display.rightContent = nil
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            display.leftContent = Display.Content(display.left, font: screen.proportionalFont, width: nil)
            if let rightText = display.right {
                display.rightContent = Display.Content(rightText, font: screen.proportionalFont, width: nil)
            } else {
                display.rightContent = nil
            }
        }
        basicKeyboard.back(calculator.privateDisplayBufferHasDigits)
        basicKeyboard.setPending(pendingOperators: calculator.pendingOperators)
        
        let allInOneLine = display.string
        _1Translation = numberTranslator .getResult(allInOneLine)
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
        display = Display(floatDisplayWidth: screen.displayWidth, font: screen.proportionalFont, ePadding: screen.ePadding)
        basicKeyboard = BasicKeyboard(keySize: screen.keySize)
        numberTranslator = XNumberTranslator()
        basicKeyboard.callback = execute
        process()
    }

}
