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
    var basicKeyboard: BasicKeyboard
    var separator: Separator
    let intDisplay: IntDisplay
    func execute(_ key: Key) {
        calculator.press(key.op)
        
        /// now, extract the number that shall be displayed using numberDisplayContent
        ///
        /// If its a number in the displayBuffer, then show this number,
        /// but make sure that it can be displayed in the limite dwidth of the display
        /// This must also take into account if mantissa is showed using grouping.
        /// The exponent must be shown left-aligned with a constant width and the
        /// mantissa shall occupy the remaining width
        ///
        /// If the number is a SwiftGmp, just show it.
        
        if calculator.displayBuffer.count > 0 {
            if display.fits(calculator.displayBuffer) {
                display.leftContent = Display.Content(calculator.displayBuffer, Font(screen.proportionalFont))
                display.rightContent = nil
            } else {
                let raw = calculator.raw
                display.update(raw: raw)
                display.leftContent = Display.Content(display.left, Font(screen.proportionalFont))
                if let rightText = display.right {
                    display.rightContent = Display.Content(rightText, Font(screen.monoSpacedFont))
                } else {
                    display.rightContent = nil
                }
            }
        } else {
            let raw = calculator.raw
            display.update(raw: raw)
            display.leftContent = Display.Content(display.left, Font(screen.proportionalFont))
            if let rightText = display.right {
                display.rightContent = Display.Content(rightText, Font(screen.proportionalFont))
            } else {
                display.rightContent = nil
            }
        }

//            // handle the exponent so that the display does not jump around
//            // when entering digits, e.g., 888888888888
//            let withSeparators = injectGrouping(numberString: calculator.displayBuffer, decimalSeparator: decimalSeparator, separateGroups: separateGrouping)
//            if withSeparators.textWidth(kerning: screen.kerning, screen.proportionalFont) < screen.displayWidth {
//                R = Representation(mantissa: withSeparators, appleFont: screen.proportionalFont)
//            } else {
//                if let tempMantissaExponent = calculator.mantissaExponent {
//                    R = Representation(
//                        mantissaExponent: tempMantissaExponent,
//                        proportionalFont: screen.proportionalFont,
//                        monoSpacedFont: screen.monoSpacedFont,
//                        decimalSeparator: decimalSeparator,
//                        separateGroups: separateGrouping,
//                        ePadding: screen.ePadding,
//                        width: screen.displayWidth)
//                } else {
//                    R = Representation(mantissa: "0", appleFont: screen.proportionalFont)
//                }
//            }
//            var tempR = calculator.R
//            
////            let numberOfDigits: Int
////            numberOfDigits = Int(floor(displayWidth / maxDigitWidth))
//
//            let exponentLength: CGFloat
//            if tempR.exponent != nil {
//                exponentLength = screen.eDigitWidth + CGFloat(String(tempR.exponent!).count) * screen.maxDigitWidth
//            } else {
//                exponentLength = 0
//            }
//            if tempR.mantissa != nil {
//                let mantissaLength: CGFloat = screen.displayWidth - exponentLength
//                let numberOfDigitsInMantissa: Int
//                if calculator.separateGroups {
//                    numberOfDigitsInMantissa = Int(floor(mantissaLength / (screen.maxDigitWidth + 0.3 * screen.dotDigitWidth)))
//                } else {
//                    numberOfDigitsInMantissa = Int(floor(mantissaLength / screen.maxDigitWidth))
//                }
//                tempR.mantissa = String(tempR.mantissa!.prefix(numberOfDigitsInMantissa))
//            }
//            numberDisplayContent = tempR
//        } else {
            // from SwiftGmp, no need for special exponent treatment
//            if let tempMantissaExponent = calculator.mantissaExponent {
//                R = Representation(
//                    mantissaExponent: tempMantissaExponent,
//                    proportionalFont: screen.proportionalFont,
//                    monoSpacedFont: screen.proportionalFont, // monospaced not needed, because the digits will not jump around while typing
//                    decimalSeparator: decimalSeparator,
//                    separateGroups: separateGrouping,
//                    ePadding: screen.ePadding,
//                    width: screen.displayWidth)
//            } else {
//                R = Representation(mantissa: "0", appleFont: screen.proportionalFont)
//            }
//        }
        basicKeyboard.back(calculator.privateDisplayBufferHasDigits)
        basicKeyboard.setPending(pendingOperators: calculator.pendingOperators)
    }
    
//    private(set) var _voices: Voices!
//    var numberTranslator: XNumberTranslator
//    var persistent = Persistent()
//
//    var _1Translation: TranslationResult = TranslationResult(displayText: "", overline: nil, spokenText: nil)
//
//    var voices: Voices {
//        return _voices
//    }

    init(screen: Screen) {
        self.screen = screen
        separator = Separator(separatorType: Separator.SeparatorType.comma, groups: true)
        intDisplay = IntDisplay(displayWidth: 10, separator: separator)
        calculator = Calculator(precision: 40)
        display = Display(floatDisplayWidth: screen.displayWidth, proportionalFont: screen.proportionalFont, monoSpacedFont: screen.monoSpacedFont)
        basicKeyboard = BasicKeyboard(keySize: screen.keySize)
        basicKeyboard.callback = execute
//        print("ViewModel init()")
//
//        // Initialize numberTranslator and calculator first
//        numberTranslator = XNumberTranslator()
//
//        // Initialize dependent properties AFTER the first phase is complete
//        _voices = Voices(numberTranslator: numberTranslator)
//
//        calculator.decimalSeparator = persistent.decimalSeparator
//        calculator.separateGroups = persistent.separateGroups
//
//        updateTranslation()
    }


//    var firstFont: Font {
//        Font.largeTitle
//    }
//    
//    func cleanSeparators(_ text: String) -> String {
//        var ret = text
//        if persistent.separateGroups {
//            ret = ret.replacingOccurrences(of: String(persistent.decimalSeparator.groupCharacter), with: "")
//        }
//        if persistent.decimalSeparator != .dot {
//            ret = ret.replacingOccurrences(of: String(persistent.decimalSeparator.character), with: ".")
//        }
//        return ret
//    }
//
//    func updateTranslation() {
//        print("updateTranslation")
//        let allInOneLine = currentLR.string
//        _1Translation = numberTranslator .getResult(allInOneLine)
//    }
//    
//    var lastScreen: Screen? = nil
//    
//    func refreshDisplay() {
//        if let lastScreen {
//            refreshDisplay(screen: lastScreen)
//        }
//    }
//
//    func refreshDisplay(screen: Screen) {
//        print("refreshDisplay")
//        currentLR = calculator.lr
//        currentLRWithSeparators = calculator.addSeparators(lr: currentLR)
//        updateTranslation()
//    }

}


//
//extension String {
//    func textWidth2(kerning: Float, _ font: AppleFont) -> Float {
//        var attributes: [NSAttributedString.Key : Any] = [:]
//        attributes[.kern] = kerning
//        attributes[.font] = font
//        return self.size(withAttributes: attributes).width
//    }
//
//    func textHeight(kerning: Float, _ font: AppleFont) -> Float {
//        var attributes: [NSAttributedString.Key : Any] = [:]
//        attributes[.kern] = kerning
//        attributes[.font] = font
//        return self.size(withAttributes: attributes).height
//    }
//
//}

//    mutating public func setFonts(font: AppleFont, displayBufferExponentFont: AppleFont, errorFont: AppleFont) {
//        self.font = font
//        self.displayBufferExponentFont = displayBufferExponentFont
//        self.errorFont = errorFont
//
//        maxDigitWidth = 0
//        minDigitWidth = Float.greatestFiniteMagnitude
//        var temp: Float
//        temp = "0".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "1".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "2".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "3".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "4".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "5".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "6".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "7".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "8".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//        temp = "9".textWidth(kerning: kerning, font); if temp > maxDigitWidth { maxDigitWidth = temp }; if temp < minDigitWidth { minDigitWidth = temp }
//    }


//#if os(macOS)
//import AppKit
//public typealias AppleFont = NSFont
//#elseif os(iOS) || os(tvOS) || os(watchOS)
//import UIKit
//public typealias AppleFont = UIFont
//#endif
