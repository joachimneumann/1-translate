//
//  Display.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 27.10.2024.
//

import SwiftGmp
import SwiftUI

class Display: MonoFontDisplay, ObservableObject {
    var groupingCharacter: Character? = nil
    var separatorCharacter: Character = "."
    
    override var left: String {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }

    override var right: String? {
        didSet {
            DispatchQueue.main.async {
                self.objectWillChange.send()
            }
        }
    }
    @Published var rightWidth: CGFloat?
    
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
        super.init(displayWidth: 0)
    }
    
    override var maxDigits: Int {
        Int(floatDisplayWidth / narrowestDigitWidth)
    }
    
    override func fits(_ mantissaParameter: String, _ exponentParameter: String? = nil) -> Bool {
        var w: CGFloat
        var mantissa = mantissaParameter
        if let groupingCharacter = groupingCharacter {
            mantissa.inject(separatorCharacter: separatorCharacter, groupingCharacter: groupingCharacter)
        }
        w = mantissa.textWidth(kerning: 0.0, uiFont)
        if var exponent = exponentParameter {
            if let groupingCharacter = groupingCharacter {
                exponent.inject(separatorCharacter: separatorCharacter, groupingCharacter: groupingCharacter)
            }
            w += ePadding
            let width = eDigitWidth + widestDigitWidth * CGFloat(exponent.count - 1)
            w += width
        }
        return w <= floatDisplayWidth
    }
}
        
extension String {
    public mutating func inject(separatorCharacter: Character, groupingCharacter: Character?) {
        let parts = self.split(separator: ".")
        var beforeDecimalPoint: String = String(parts[0])
        if let c = groupingCharacter {
            var count = beforeDecimalPoint.count
            while count >= 4 {
                count = count - 3
                beforeDecimalPoint.insert(c, at: beforeDecimalPoint.index(beforeDecimalPoint.startIndex, offsetBy: count))
            }
        }
        if parts.count == 1 {
            if self.hasSuffix(".") {
                self.removeLast()
                self = beforeDecimalPoint + String(separatorCharacter)
            }
            self = beforeDecimalPoint
        }
        if parts.count == 2 {
            self = beforeDecimalPoint + String(separatorCharacter) + String(parts[1])
        }
    }
    public mutating func remove(separatorCharacter: Character, groupingCharacter: Character?) {
        var ret: String = self
        if let gr = groupingCharacter {
            ret = ret.replacingOccurrences(of: String(gr), with: "")
        }
        self = ret.replacingOccurrences(of: String(separatorCharacter), with: ".")
    }
}

