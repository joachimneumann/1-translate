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
        var font: AppleFont
        init(_ text: String, _ font: AppleFont) {
            self.text = text
            self.font = font
        }
        var debugDescription: String {
            "\(text)"
        }

    }
    struct Number: CustomDebugStringConvertible {
        var debugDescription: String {
            "\(mantissa.debugDescription) \(exponent != nil ? exponent!.debugDescription : "")"
        }
        
        let mantissa: Content
        let exponent: Content?
        init(_ mantissaText: String, _ font: AppleFont) {
            mantissa = Content(mantissaText, font)
            exponent = nil
        }
    }

    let error: Content? = nil
    @Published var number: Number? = nil

    let displayWidth: CGFloat
    var narrowestDigit: String
    var widestDigit: String
    let eDigitWidth: CGFloat
    let dotDigitWidth: CGFloat

    var proportionalFont: AppleFont
    var monoSpacedFont: AppleFont


    init(displayWidth: CGFloat, proportionalFont: AppleFont, monoSpacedFont: AppleFont) {
        self.displayWidth = displayWidth
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
        number = Number("0", proportionalFont)
        super.init(displayWidth: 0)
    }
    
    func fits(_ s: String) -> Bool {
        s.textWidth(kerning: 0.0, proportionalFont) <= displayWidth
    }
    
    func update(raw: Raw, isDisplayBuffer: Bool) {
        super.update(raw: raw)
        
    }
}
