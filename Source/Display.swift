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
    
    private let floatDisplayWidth: CGFloat
    private var narrowestDigitWidth: CGFloat
    var widestDigitWidth: CGFloat
    let ePadding: CGFloat
    let eDigitWidth: CGFloat
    var rightWidth: CGFloat = 0.0

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
    guard !string.isEmpty else { return }

    // Keep empty subsequences so values like ".5" or "12." remain representable.
    let parts = string.split(separator: ".", maxSplits: 1, omittingEmptySubsequences: false)
    guard let firstPart = parts.first else { return }

    var beforeDecimalPoint = String(firstPart)

    if let groupingCharacter {
        var count = beforeDecimalPoint.count
        if groupSize == 32 {
            if count > 3 {
                count -= 3
                if count >= 0 && count <= beforeDecimalPoint.count {
                    let index = beforeDecimalPoint.index(beforeDecimalPoint.startIndex, offsetBy: count)
                    beforeDecimalPoint.insert(groupingCharacter, at: index)
                }
                while count > 2 {
                    count -= 2
                    if count >= 0 && count <= beforeDecimalPoint.count {
                        let index = beforeDecimalPoint.index(beforeDecimalPoint.startIndex, offsetBy: count)
                        beforeDecimalPoint.insert(groupingCharacter, at: index)
                    } else {
                        break
                    }
                }
            }
        } else {
            while count > 3 {
                count -= 3
                if count >= 0 && count <= beforeDecimalPoint.count {
                    let index = beforeDecimalPoint.index(beforeDecimalPoint.startIndex, offsetBy: count)
                    beforeDecimalPoint.insert(groupingCharacter, at: index)
                } else {
                    break
                }
            }
        }
    }

    if parts.count == 1 {
        string = beforeDecimalPoint
    } else {
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

