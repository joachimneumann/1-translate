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
    var groupSize: Int
    var separatorCharacter: Character = "."
    let textPadding: CGFloat = 10
    
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

    private var uiFont: AppleFont
    public var font: Font

    init(floatDisplayWidth: CGFloat, font: AppleFont, ePadding: CGFloat) {
        self.floatDisplayWidth = floatDisplayWidth - 2 * textPadding
        self.uiFont = font
        self.font = Font(uiFont)
        self.ePadding = ePadding
        self.groupSize = 3
        
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
            inject(into: &mantissa, separatorCharacter: separatorCharacter, groupingCharacter: groupingCharacter, groupSize: groupSize)
        }
        w = mantissa.textWidth(kerning: 0.0, uiFont)
        if var exponent = exponentParameter {
            if let groupingCharacter = groupingCharacter {
                inject(into: &exponent, separatorCharacter: separatorCharacter, groupingCharacter: groupingCharacter, groupSize: groupSize)
            }
            w += ePadding
            let width = eDigitWidth + widestDigitWidth * CGFloat(exponent.count - 1)
            w += width
        }
        return w <= floatDisplayWidth
    }
}

func inject(into string: inout String, separatorCharacter: Character, groupingCharacter: Character?, groupSize: Int) {
    let parts = string.split(separator: ".")
    var beforeDecimalPoint: String = String(parts[0])

    // Insert grouping character if provided
    if let c = groupingCharacter {
        var count = beforeDecimalPoint.count
        if groupSize == 32 {
            if count > 3 {
                count -= 3
                beforeDecimalPoint.insert(c, at: beforeDecimalPoint.index(beforeDecimalPoint.startIndex, offsetBy: count))
                while count > 2 {
                    count -= 2
                    beforeDecimalPoint.insert(c, at: beforeDecimalPoint.index(beforeDecimalPoint.startIndex, offsetBy: count))
                }
            }
        } else {
            while count > 3 {
                count -= 3
                beforeDecimalPoint.insert(c, at: beforeDecimalPoint.index(beforeDecimalPoint.startIndex, offsetBy: count))
            }
        }
    }

    if parts.count == 1 {
        // No decimal part, reassign self with the grouped integer part
        string = beforeDecimalPoint
    } else if parts.count == 2 {
        // Decimal part exists, reassemble with separator and decimal portion
        let afterDecimalPoint = String(parts[1])
        string = beforeDecimalPoint + String(separatorCharacter) + afterDecimalPoint
    }
}

extension String {
    
    public mutating func remove(separatorCharacter: Character, groupingCharacter: Character?) {
        var ret: String = self
        if let gr = groupingCharacter {
            ret = ret.replacingOccurrences(of: String(gr), with: "")
        }
        self = ret.replacingOccurrences(of: String(separatorCharacter), with: ".")
    }
}

