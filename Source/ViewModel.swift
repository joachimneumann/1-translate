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
    var display: Display
    let calculator = Calculator(precision: 100)
    var devicePortraitWidth: CGFloat = 100
    var devicePortraitHeight: CGFloat
    var scientificWidth: CGFloat
    var smallKeyboardWidth: CGFloat
    var displayWidth: CGFloat = 0
    let isMac: Bool
    let isTranslator: Bool
    var isScientific: Bool
    
    init(devicePortraitWidth: CGFloat, devicePortraitHeight: CGFloat, isTranslator: Bool = false, isMac: Bool = false, isScientific: Bool = false) {
        self.isTranslator = isTranslator
        self.isMac = isMac
        self.isScientific = isScientific
        self.smallKeyboardWidth = devicePortraitWidth
        if isMac {
            self.scientificWidth = devicePortraitWidth * 2.345
        } else {
            self.scientificWidth = devicePortraitHeight
        }
        self.devicePortraitHeight = devicePortraitHeight
        //print("ViewModel init()")
//        keyboard.standardKeyboard(width: width, height: height * 0.5)
        display = Display(floatDisplayWidth: 0, font: AppleFont.systemFont(ofSize: 0), ePadding: 0)
        display.left = "0"
        //populateKeyboard()
    }
    
    func populateKeyboard() {
        keyboard.keyMatrix.removeAll()
        if isTranslator {
            if isMac {
                devicePortraitWidth = smallKeyboardWidth
                keyboard.translatorKeyboard(width: devicePortraitWidth - 10, height: devicePortraitHeight - 30)
            } else {
                devicePortraitWidth = smallKeyboardWidth
                keyboard.translatorKeyboard(width: devicePortraitWidth, height: devicePortraitHeight * 0.5)
            }
        } else {
            if isMac {
                if isScientific {
                    devicePortraitWidth = scientificWidth
                    keyboard.scientificKeyboard(width: devicePortraitWidth - 10, height: devicePortraitHeight - 30)
                } else {
                    devicePortraitWidth = smallKeyboardWidth
                    keyboard.standardKeyboard(width: devicePortraitWidth - 10, height: devicePortraitHeight - 30)
                }
            } else {
                if isScientific {
                    devicePortraitWidth = smallKeyboardWidth
                    keyboard.scientificKeyboard(width: devicePortraitHeight, height: devicePortraitWidth * 0.8)
                } else {
                    devicePortraitWidth = smallKeyboardWidth
                    keyboard.standardKeyboard(width: devicePortraitHeight, height: devicePortraitWidth)
                }
            }
        }
        displayWidth = keyboard.keyboardFrame.width
        if isMac && isScientific {
            displayWidth = 250.0
        }
        display = Display(floatDisplayWidth: displayWidth - 2 * keyboard.padding, font: AppleFont.systemFont(ofSize: floor(keyboard.keyboardFrame.height / 1.3)), ePadding: 10.0)
        keyboard.callback = execute
    }
    
    func toggleScientific() {
        isScientific.toggle()
        if isMac && isScientific {
            devicePortraitWidth *= 2.345
        }
        if isMac && !isScientific {
            devicePortraitWidth /= 2.345
        }
        populateKeyboard()
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
