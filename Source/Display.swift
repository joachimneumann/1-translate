//
//  Display.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 27.10.2024.
//

import SwiftGmp
import SwiftUI

class Display: IntDisplay, ObservableObject {

    struct Content: CustomDebugStringConvertible {
        var text: String
        var font: Font
        init(_ text: String, _ font: Font) {
            self.text = text
            self.font = font
        }
        var debugDescription: String {
            "\(text)"
        }

    }

    @Published var leftContent: Content
    @Published var rightContent: Content?

    let floatDisplayWidth: CGFloat
    var narrowestDigit: String
    var widestDigit: String
    let eDigitWidth: CGFloat
    let dotDigitWidth: CGFloat

    var proportionalFont: AppleFont
    var monoSpacedFont: AppleFont


    init(floatDisplayWidth: CGFloat, proportionalFont: AppleFont, monoSpacedFont: AppleFont) {
        self.floatDisplayWidth = floatDisplayWidth
        self.proportionalFont = proportionalFont
        self.monoSpacedFont = monoSpacedFont
        self.narrowestDigit = "0"
        self.widestDigit = "0"
        
        var widestDigitWidth: CGFloat = 0.0
        var narrowestDigitWidth: CGFloat = CGFloat.greatestFiniteMagnitude
        for c in 0..<10 {
            let s = String(c)
            print(s)
            let l = s.textWidth(kerning: 0.0, proportionalFont);
            if l > widestDigitWidth { widestDigitWidth = l; widestDigit = s }
            if l < narrowestDigitWidth { narrowestDigitWidth = l; narrowestDigit = s }
        }
        eDigitWidth = "e".textWidth(kerning: 0.0, proportionalFont);
        dotDigitWidth = ".".textWidth(kerning: 0.0, proportionalFont);
        self.leftContent = Content("0", Font(proportionalFont))
        rightContent = nil
        super.init(displayWidth: 0)
        self.leftContent.text = self.left
    }
    
    override var maxDigits: Int {
        Int(floatDisplayWidth / narrowestDigit.textWidth(kerning: 0.0, proportionalFont))
    }
    
    override func fits(_ mantissa: String, _ exponent: String? = nil) -> Bool {
        var w: CGFloat
        w = mantissa.textWidth(kerning: 0.0, proportionalFont)
        if let exponent = exponent {
            w += exponent.textWidth(kerning: 0.0, monoSpacedFont)
        }
        return w <= floatDisplayWidth
    }
}
