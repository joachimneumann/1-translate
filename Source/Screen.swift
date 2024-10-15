//
//  ScreenModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 12/26/22.
//

import SwiftUI

struct Screen: Equatable, DisplayLengthLimiter {

    static func == (lhs: Screen, rhs: Screen) -> Bool { /// used to detect rotation
        lhs.keySize == rhs.keySize
    }
    static func appleFont(ofSize size: CGFloat, weight: AppleFont.Weight) -> AppleFont {
        return AppleFont.monospacedDigitSystemFont(ofSize: size, weight: weight)
    }
    
    private let isPad: Bool

    var keyboardHeight: CGFloat
    let keySpacing: CGFloat
    let keySize: CGSize
    var ePadding: CGFloat /// var and not let, because it is set to 0.0 in the tests
    let plusIconSize: CGFloat
    let iconsWidth: CGFloat
    let plusIconTrailingPadding: CGFloat
    var uiFontSize: CGFloat
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
    var digitWidth: CGFloat = 0.0
    var radWidth: CGFloat = 0.0
    var eWidth: CGFloat = 0.0
    let defaultTextColor: Color
    private let keyWidth: CGFloat
    private var keyHeight: CGFloat

    let appleFont: AppleFont
    private let calculatorWidth: CGFloat
        
    mutating func changeKeyboardSize(smaller: Bool) {
        keyHeight = keyWidth * (smaller ? 0.5 : 0.7)
        keyboardHeight = 5 * keyHeight + 4 * keySpacing
    }

    init(_ screenSize: CGSize) {
        //print("Screen INIT", screenSize)
        
        defaultTextColor = .white
        isPad = UIDevice.current.userInterfaceIdiom == .pad
        keySpacing = 0.016 * screenSize.width
        horizontalPadding = keySpacing
        displayHorizontalPadding = screenSize.width * 0.035
        
        portraitIPhoneDisplayBottomPadding = screenSize.height * 0.05
        
        calculatorWidth = screenSize.width - 2 * horizontalPadding
        
        keyWidth = isPad ? (calculatorWidth - 9.0 * keySpacing) * 0.1 : (calculatorWidth - 3.0 * keySpacing) * 0.25
        keyHeight = (screenSize.height * 0.565 - 4 * keySpacing) / 5.0
//        if screenSize.height < screenSize.width * 1.8 {
//            // on less tall phones, show a smaller keyboard
//            keyHeight = keyWidth * 0.4
//        } else {
//            keyHeight = keyWidth
//        }
        keyboardHeight = 5 * keyHeight + 4 * keySpacing
        bottomPadding = isPad ? 0.0 : keyboardHeight * 0.055

        keySize = CGSize(width: keyWidth, height: keyHeight)
        
        plusIconSize = keyboardHeight * 0.13
        iconsWidth   = keyboardHeight * 0.16
        plusIconTrailingPadding = plusIconSize * 0.4
        ePadding = plusIconSize * 0.1
        uiFontSize = 0.17 * keyboardHeight
        infoUiFontSize = 16.0
        appleFont = Self.appleFont(ofSize: uiFontSize, weight: .black)
        infoUiFont = Screen.appleFont(ofSize: infoUiFontSize, weight: .regular)

        kerning = -0.02 * uiFontSize
        
        textHeight     = "0".textHeight(kerning: kerning, appleFont: appleFont)
        infoTextHeight = "0".textHeight(kerning: 0.0, appleFont: infoUiFont)
        radWidth       = "Rad".textWidth(kerning: 0.0, appleFont: infoUiFont)
        digitWidth     = "0".textWidth(kerning: kerning, appleFont: appleFont)

        offsetToVerticallyAlignTextWithkeyboard =
        CGFloat(screenSize.height) -
        CGFloat(keyboardHeight) -
        CGFloat(textHeight) -
        CGFloat(infoUiFontSize)

        offsetToVerticallyAlignIconWithText =
        CGFloat(screenSize.height) -
        CGFloat(keyboardHeight) -
        CGFloat(infoUiFontSize) -
        CGFloat(plusIconSize) +
        CGFloat(appleFont.descender) -
        CGFloat(0.5 * appleFont.capHeight) +
        CGFloat(0.5 * plusIconSize)
        displayWidth = calculatorWidth - 2.0 * displayHorizontalPadding
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
    
    func textWidth(kerning: CGFloat, appleFont: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = appleFont
        return self.size(withAttributes: attributes).width
    }
    
    func textHeight(kerning: CGFloat, appleFont: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = appleFont
        return self.size(withAttributes: attributes).height
    }

}

