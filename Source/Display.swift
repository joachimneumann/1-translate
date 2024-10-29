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
        var width: CGFloat?
        init(_ text: String, width: CGFloat? = nil) {
            self.text = text
            self.width = width
        }
        var debugDescription: String {
            "\(text)"
        }
    }

    @Published var leftContent: Content
    @Published var rightContent: Content?

    private let floatDisplayWidth: CGFloat
    private var narrowestDigitWidth: CGFloat
    var widestDigitWidth: CGFloat
    let ePadding: CGFloat
    let eDigitWidth: CGFloat

    private var uiFont: UIFont
    public var font: Font

    init(floatDisplayWidth: CGFloat, font: AppleFont, ePadding: CGFloat) {
        self.floatDisplayWidth = floatDisplayWidth
        self.uiFont = font
        self.font = Font(uiFont)
        self.ePadding = ePadding
        
        narrowestDigitWidth = CGFloat.greatestFiniteMagnitude
        widestDigitWidth = 0.0
        for c in 0..<10 {
            let s = String(c)
            let l = s.textWidth(kerning: 0.0, font);
            if l > widestDigitWidth { widestDigitWidth = l }
            if l < narrowestDigitWidth { narrowestDigitWidth = l }
        }
        eDigitWidth = "e".textWidth(kerning: 0.0, font);
        self.leftContent = Content("0", width: nil)
        rightContent = nil
        super.init(displayWidth: 0)
        self.leftContent.text = self.left
    }
    
    override var maxDigits: Int {
        Int(floatDisplayWidth / narrowestDigitWidth)
    }
    
    override func fits(_ mantissa: String, _ exponent: String? = nil) -> Bool {
        var w: CGFloat
        w = mantissa.textWidth(kerning: 0.0, uiFont)
        if let exponent = exponent {
            w += ePadding
            let width = eDigitWidth + widestDigitWidth * CGFloat(exponent.count - 1)
            w += width
        }
        return w <= floatDisplayWidth
    }
}
