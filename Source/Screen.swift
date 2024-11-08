//
//  ScreenModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 12/26/22.
//

import SwiftUI

struct Screen: Equatable {

    static func == (lhs: Screen, rhs: Screen) -> Bool { /// used to detect rotation
        lhs.keySize == rhs.keySize
    }

    static func proportionalFont(ofSize size: CGFloat, weight: AppleFont.Weight) -> AppleFont {
        return AppleFont.systemFont(ofSize: size, weight: weight)
    }

    private let isPad: Bool

    var keyboardHeight5Rows: CGFloat
    var keyboardHeight4Rows: CGFloat
    let keySpacing: CGFloat
    let keySize: CGSize
    let ePadding: CGFloat
    let plusIconSize: CGFloat
    let iconsWidth: CGFloat
    let plusIconTrailingPadding: CGFloat
    var uiFontSize: CGFloat
    var numberDisplayFont: AppleFont
    var translationFont: AppleFont
    let infoUiFont: AppleFont
    let infoUiFontSize: CGFloat
    let displayHorizontalPadding: CGFloat
    let portraitIPhoneDisplayBottomPadding: CGFloat
    let horizontalPadding: CGFloat
    let bottomPadding: CGFloat
    var offsetToVerticallyAlignTextWithkeyboard: CGFloat = 0.0
    var offsetToVerticallyAlignIconWithText: CGFloat = 0.0
    let kerning: CGFloat
    var textHeight: CGFloat = 0.0
    var infoTextHeight: CGFloat = 0.0
    var displayWidth: CGFloat = 0.0
    var maxDigitWidth: CGFloat = 0.0
    var eDigitWidth: CGFloat = 0.0
    var dotDigitWidth: CGFloat = 0.0
    var radWidth: CGFloat = 0.0
    let defaultTextColor: Color
    private let keyWidth: CGFloat
    private var keyHeight: CGFloat

    private let calculatorWidth: CGFloat
        
    mutating func changeKeyboardSize(smaller: Bool) {
        keyHeight = keyWidth * (smaller ? 0.5 : 0.7)
        keyboardHeight5Rows = 5 * keyHeight + 4 * keySpacing
    }

    init() {
        self.init(UIScreen.main.bounds.size)
    }
    init(_ screenSize: CGSize) {
        //print("Screen INIT", screenSize)
        
        defaultTextColor = .white
        isPad = UIDevice.current.userInterfaceIdiom == .pad
        keySpacing = 0.0165 * screenSize.width
        horizontalPadding = 2.2 * keySpacing
        displayHorizontalPadding = 0.0//screenSize.width * 0.035
        
        portraitIPhoneDisplayBottomPadding = 0.0//screenSize.height * 0.048
        
        calculatorWidth = screenSize.width - 2 * horizontalPadding
        
        keyWidth = isPad ? (calculatorWidth - 9.0 * keySpacing) * 0.1 : (calculatorWidth - 3.0 * keySpacing) * 0.25

        let translateNumbersApp = true
        if translateNumbersApp {
            keyHeight = (screenSize.height * 0.4 - 4 * keySpacing) / 5.0 // this simulates the iOS18 calculator
        } else {
            keyHeight = (screenSize.height * 0.568 - 4 * keySpacing) / 5.0 // this simulates the iOS18 calculator
        }
        keyboardHeight5Rows = 5 * keyHeight + 4 * keySpacing
        keyboardHeight4Rows = 4 * keyHeight + 3 * keySpacing
        bottomPadding = isPad ? 0.0 : keyboardHeight5Rows * 0.05

        keySize = CGSize(width: keyWidth, height: keyHeight)
        
        plusIconSize = keyboardHeight5Rows * 0.13
        iconsWidth   = keyboardHeight5Rows * 0.16
        plusIconTrailingPadding = plusIconSize * 0.4
        ePadding = plusIconSize * 0.1
        kerning = 0.0//-0.02 * uiFontSize

        uiFontSize = 0.169 * keyboardHeight5Rows
        numberDisplayFont = Screen.proportionalFont(ofSize: uiFontSize, weight: .regular)
        translationFont = Screen.proportionalFont(ofSize: uiFontSize, weight: .light)
        infoUiFontSize = 16.0
        infoUiFont = Screen.proportionalFont(ofSize: infoUiFontSize, weight: .regular)
        
        
        
        textHeight     = "0".textHeight(kerning: kerning, numberDisplayFont)
        infoTextHeight = "0".textHeight(kerning: 0.0, infoUiFont)
        radWidth       = "Rad".textWidth(kerning: 0.0, infoUiFont)
        maxDigitWidth = 0
        var temp: CGFloat
        temp = "0".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "1".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "2".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "3".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "4".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "5".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "6".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "7".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "8".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        temp = "9".textWidth(kerning: kerning, numberDisplayFont); if temp > maxDigitWidth { maxDigitWidth = temp }
        eDigitWidth = "e".textWidth(kerning: kerning, numberDisplayFont);
        dotDigitWidth = ".".textWidth(kerning: kerning, numberDisplayFont);
        
        offsetToVerticallyAlignTextWithkeyboard =
        CGFloat(screenSize.height) -
        CGFloat(keyboardHeight5Rows) -
        CGFloat(textHeight) -
        CGFloat(infoUiFontSize)

        offsetToVerticallyAlignIconWithText =
        CGFloat(screenSize.height) -
        CGFloat(keyboardHeight5Rows) -
        CGFloat(infoUiFontSize) -
        CGFloat(plusIconSize) +
        CGFloat(numberDisplayFont.descender) -
        CGFloat(0.5 * numberDisplayFont.capHeight) +
        CGFloat(0.5 * plusIconSize)
        displayWidth = calculatorWidth - 2.0 * displayHorizontalPadding

        if translateNumbersApp {
            uiFontSize = 10*0.169 * keyboardHeight5Rows
            numberDisplayFont = Screen.proportionalFont(ofSize: uiFontSize, weight: .regular)
            
            // make sure 100 trillion fits in the display, with group separators
//            while "6,666,666,666,666".textWidth(kerning: kerning, proportionalFont) > displayWidth {
            var w = CGFloat.greatestFiniteMagnitude
            while w > displayWidth {
                /// 6 is the widest digit in the proportional font
                //print(uiFontSize)
                uiFontSize *= 0.99
                numberDisplayFont = Screen.proportionalFont(ofSize: uiFontSize, weight: .regular)
                w = "666,666,666".textWidth(kerning: kerning, numberDisplayFont)
            }
            numberDisplayFont = Screen.proportionalFont(ofSize: uiFontSize, weight: .regular)
        }
    }
}

extension String {
    func before(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let before = prefix(upTo: index)
            return String(before)
        }
        return ""
    }
    
    func after(first delimiter: Character) -> String {
        if let index = firstIndex(of: delimiter) {
            let after = suffix(from: index).dropFirst()
            return String(after)
        }
        return ""
    }

    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
        guard let range = self.range(of: target) else { return self }
        return self.replacingCharacters(in: range, with: replacement)
    }
    
    func textWidth(kerning: CGFloat, _ font: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = font
        return self.size(withAttributes: attributes).width
    }
    
    func textHeight(kerning: CGFloat, _ font: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = font
        return self.size(withAttributes: attributes).height
    }
    
}

