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
        var width: CGFloat?
        init(_ text: String, font: UIFont, width: CGFloat?) {
            self.text = text
            self.font = Font(font)
            self.width = width
        }
        var debugDescription: String {
            "\(text)"
        }
    }

    @Published var leftContent: Content
    @Published var rightContent: Content?

    let floatDisplayWidth: CGFloat
    var narrowestDigitWidth: CGFloat
    var widestDigitWidth: CGFloat
    let eDigitWidth: CGFloat
    let dotDigitWidth: CGFloat

    var font: UIFont
    let ePadding: CGFloat

    init(floatDisplayWidth: CGFloat, font: AppleFont, ePadding: CGFloat) {
        self.floatDisplayWidth = floatDisplayWidth
        self.font = font
        self.ePadding = ePadding
        
        narrowestDigitWidth = CGFloat.greatestFiniteMagnitude
        widestDigitWidth = 0.0
        for c in 0..<10 {
            let s = String(c)
            print(s)
            let l = s.textWidth(kerning: 0.0, font);
            if l > widestDigitWidth { widestDigitWidth = l }
            if l < narrowestDigitWidth { narrowestDigitWidth = l }
        }
        eDigitWidth = "e".textWidth(kerning: 0.0, font);
        dotDigitWidth = ".".textWidth(kerning: 0.0, font);
        self.leftContent = Content("0", font: font, width: nil)
        rightContent = nil
        super.init(displayWidth: 0)
        self.leftContent.text = self.left
    }
    
    override var maxDigits: Int {
        Int(floatDisplayWidth / narrowestDigitWidth)
    }
    
    override func fits(_ mantissa: String, _ exponent: String? = nil) -> Bool {
        var w: CGFloat
        w = mantissa.textWidth(kerning: 0.0, font)
        if let exponent = exponent {
            w += ePadding
            let width = eDigitWidth + widestDigitWidth * CGFloat(exponent.count - 1)
            w += width
        }
        return w <= floatDisplayWidth
    }
}
