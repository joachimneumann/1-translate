//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 06.12.2024.
//

import SwiftUI
import SwiftGmp

@Observable class ViewModel {
    
    enum RadDeg {
        case rad
        case deg
    }
    var radDeg: RadDeg = .deg
    var second: Bool = false
    let keyboard: KeyboardModel = KeyboardModel()
    var displayFrame: CGSize = .zero
    var display: Display
    let calculator = Calculator(precision: 100)
    var width: CGFloat = 100
    var height: CGFloat = 100
    let isMac: Bool
    let isTranslator: Bool
    var isScientific: Bool
    var isPortrait: Bool = true
    
    init(width: CGFloat, height: CGFloat, isTranslator: Bool = false, isMac: Bool = false) {
        self.isTranslator = isTranslator
        self.isMac = isMac
        self.width = width
        self.height = height
        self.isScientific = !isTranslator && (width > height)
        display = Display(floatDisplayWidth: 0, font: AppleFont.systemFont(ofSize: 0), ePadding: 0)
        display.left = "0"
        setWidth()
    }
    
    func setWidth() {
        let displayFontSize: CGFloat
        if isTranslator {
            keyboard.translatorKeyboard(width: width - 10, height: height * 0.5)
            displayFrame.width = keyboard.keyboardFrame.width
            displayFrame.height = keyboard.keyboardFrame.height * 0.22
            displayFontSize = floor(displayFrame.width * 0.15)
        } else {
            if isScientific {
                keyboard.scientificKeyboard(width: width, height: height * 0.75)
                displayFrame.width = keyboard.keyboardFrame.width
                displayFrame.height = keyboard.keyboardFrame.height * 0.2
                displayFontSize = floor(displayFrame.width * 0.04)
            } else {
                keyboard.calculatorKeyboard(width: width, height: height * 0.75)
                displayFrame.width = keyboard.keyboardFrame.width
                displayFrame.height = keyboard.keyboardFrame.height * 0.22
                displayFontSize = floor(displayFrame.width * 0.15)
            }
        }
//        print(displayFontSize)
        if isMac && isScientific {
            displayFrame.width = 250.0
        }
        display = Display(floatDisplayWidth: displayFrame.width - 2 * keyboard.padding, font: AppleFont.systemFont(ofSize: displayFontSize), ePadding: 10.0)
        keyboard.callback = execute
    }
    
    func toggleScientific() {
        isScientific.toggle()
        setWidth()
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
                if op.isEqual(to: ControlOperation.calc) {
                    toggleScientific()
                } else if op.isEqual(to: ControlOperation.rad) {
                    radDeg = .deg
                    keyModel.symbolKey!.op = ControlOperation.deg
                    keyModel.symbolKey!.symbol = keyModel.symbolKey!.op.getRawValue()
                } else if op.isEqual(to: ControlOperation.deg) {
                    radDeg = .rad
                    keyModel.symbolKey!.op = ControlOperation.rad
                    keyModel.symbolKey!.symbol = keyModel.symbolKey!.op.getRawValue()
                } else if op.isEqual(to: ControlOperation.second) {
                    second.toggle()
                    for row in keyboard.keyMatrix {
                        for k in row {
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.asin) || k.symbolKey!.op.isEqual(to: InplaceOperation.sin) {
                                k.symbolKey!.op = second ? InplaceOperation.asin : InplaceOperation.sin
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.acos) || k.symbolKey!.op.isEqual(to: InplaceOperation.cos) {
                                k.symbolKey!.op = second ? InplaceOperation.acos : InplaceOperation.cos
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.atan) || k.symbolKey!.op.isEqual(to: InplaceOperation.tan) {
                                k.symbolKey!.op = second ? InplaceOperation.atan : InplaceOperation.tan
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.asinh) || k.symbolKey!.op.isEqual(to: InplaceOperation.sinh) {
                                k.symbolKey!.op = second ? InplaceOperation.asinh : InplaceOperation.sinh
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.acosh) || k.symbolKey!.op.isEqual(to: InplaceOperation.cosh) {
                                k.symbolKey!.op = second ? InplaceOperation.acosh : InplaceOperation.cosh
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.atanh) || k.symbolKey!.op.isEqual(to: InplaceOperation.tanh) {
                                k.symbolKey!.op = second ? InplaceOperation.atanh : InplaceOperation.tanh
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: TwoOperantOperation.powyx) || k.symbolKey!.op.isEqual(to: InplaceOperation.exp) {
                                k.symbolKey!.op = second ? TwoOperantOperation.powyx : InplaceOperation.exp
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.exp2) || k.symbolKey!.op.isEqual(to: InplaceOperation.exp10) {
                                k.symbolKey!.op = second ? InplaceOperation.exp2 : InplaceOperation.exp10
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: TwoOperantOperation.logy) || k.symbolKey!.op.isEqual(to: InplaceOperation.ln) {
                                k.symbolKey!.op = second ? TwoOperantOperation.logy : InplaceOperation.ln
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                            if k.symbolKey!.op.isEqual(to: InplaceOperation.log2) || k.symbolKey!.op.isEqual(to: InplaceOperation.log10) {
                                k.symbolKey!.op = second ? InplaceOperation.log2 : InplaceOperation.log10
                                k.symbolKey!.symbol = k.symbolKey!.op.getRawValue()
                            }
                        }
                    }
                } else {
                    if radDeg == .deg {
                        switch op {
                        case InplaceOperation.sin:  calculator.press(InplaceOperation.sind)
                        case InplaceOperation.cos:  calculator.press(InplaceOperation.cosd)
                        case InplaceOperation.tan:  calculator.press(InplaceOperation.tand)
                        case InplaceOperation.asin: calculator.press(InplaceOperation.asind)
                        case InplaceOperation.acos: calculator.press(InplaceOperation.acosd)
                        case InplaceOperation.atan: calculator.press(InplaceOperation.atand)
                        default:
                            calculator.press(op)
                        }
                    } else {
                        calculator.press(op)
                    }
                }
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
                        if symbolKey.op.isEqual(to: ControlOperation.second) {
                            if second {
                                symbolKey.textColor = .orange
                            } else {
                                symbolKey.textColor = Color.Neumorphic.text
                            }
                        }
                    }
                }
            }
        }
    }

}
