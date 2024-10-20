//
//  ViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 1/14/23.
//

import SwiftUI
import NumberTranslator
import SwiftGmp

class ViewModel: ObservableObject {
    let screen: Screen
    var calculator: Calculator
    var basicKeyboard: BasicKeyboard
    
    @Published var R: Representation

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
//            // handle the exponent so that the display does not jump around
//            // when entering digits, e.g., 888888888888
            
            if calculator.displayBuffer.textWidth(kerning: screen.kerning, screen.proportionalFont) < screen.displayWidth {
                R = Representation(mantissa: calculator.displayBuffer, uiFont: screen.proportionalFont)
            } else {
                if let tempMantissaExponent = calculator.mantissaExponent {
                    R = Representation(
                        mantissaExponent: tempMantissaExponent,
                        proportionalFont: screen.proportionalFont,
                        monoSpacedFont: screen.monoSpacedFont,
                        ePadding: screen.ePadding,
                        width: screen.displayWidth)
                } else {
                    R = Representation(mantissa: "0", uiFont: screen.proportionalFont)
                }
            }
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
        } else {
            // from SwiftGmp, no need for special exponent treatment
            if let tempMantissaExponent = calculator.mantissaExponent {
                R = Representation(
                    mantissaExponent: tempMantissaExponent,
                    proportionalFont: screen.proportionalFont,
                    monoSpacedFont: screen.proportionalFont, // monospaced not needed, because the digits will not jump around while typeing
                    ePadding: screen.ePadding,
                    width: screen.displayWidth)
            } else {
                R = Representation(mantissa: "0", uiFont: screen.proportionalFont)
            }
        }
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
        calculator = Calculator(precision: 40)
        R = Representation(mantissa: "0", uiFont: screen.proportionalFont)
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
