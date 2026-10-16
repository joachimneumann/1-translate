//
//  Display.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 27.10.2024.
//

import SwiftGmp
import SwiftUI
import CoreText

class Display: MonoFontDisplay {
    struct Line {
        var mantissa: String
        var exponent: String?
    }

    var groupingCharacter: Character? = nil
    var groupSize: Int
    var separatorCharacter: Character = "."
    let textPadding: CGFloat = 10
    
    private let floatDisplayWidth: CGFloat
    private var narrowestDigitWidth: CGFloat
    let ePadding: CGFloat

    private var uiFont: AppleFont
    public var font: Font
    private let exponentUiFont: AppleFont
    let exponentFont: Font
    let exponentBaselineOffset: CGFloat
    let lineHeight: CGFloat
    let decimalHighlightFont: Font
    let decimalHighlightPadding: CGFloat = 4
    private let decimalHighlightUiFont: AppleFont
    let expandedLineHeight: CGFloat
    let maxLines: Int
    let firstLine: Line?
    let digitLimit: Int?

    init(floatDisplayWidth: CGFloat, font: AppleFont, ePadding: CGFloat, maxLines: Int = 1, firstLine: Line? = nil, digitLimit: Int? = nil) {
        self.floatDisplayWidth = floatDisplayWidth - 2 * textPadding
        self.uiFont = font
        self.font = Font(uiFont)
        self.exponentUiFont = AppleFont.monospacedDigitSystemFont(ofSize: font.pointSize * 0.65, weight: .regular)
        self.exponentFont = Font(exponentUiFont)
        self.exponentBaselineOffset = font.pointSize * 0.4
        self.lineHeight = max(1, ceil(font.ascender - font.descender + font.leading))
        let highlightFont = AppleFont.systemFont(ofSize: font.pointSize * 1.35, weight: .semibold)
        self.decimalHighlightFont = Font(highlightFont)
        self.decimalHighlightUiFont = highlightFont
        self.expandedLineHeight = max(self.lineHeight, ceil(highlightFont.ascender - highlightFont.descender + highlightFont.leading) + 2)
        self.maxLines = max(1, maxLines)
        self.firstLine = firstLine
        self.digitLimit = digitLimit
        self.ePadding = ePadding
        self.groupSize = 3
        
        narrowestDigitWidth = CGFloat.greatestFiniteMagnitude
        for c in 0..<10 {
            let s = String(c)
            let l = s.textWidth(kerning: 0.0, font);
            if l < narrowestDigitWidth { narrowestDigitWidth = l }
        }
        super.init(displayWidth: 0)
    }
    
    override var maxDigits: Int {
        digitLimit ?? Int(floatDisplayWidth / narrowestDigitWidth) * maxLines
    }

    var isScrollable: Bool {
        digitLimit != nil
    }

    var highlightsDecimal: Bool {
        guard !isError, let decimal = left.firstIndex(of: separatorCharacter) else { return false }
        // Count numeric digits only, so signs and grouping do not move the threshold.
        return left[..<decimal].filter(\.isNumber).count >= 5
    }

    func expandedLines(for availableWidth: CGFloat) -> [Line] {
        wrap(left, nil, width: availableWidth, useFirstLine: false, highlightDecimal: highlightsDecimal)
    }

    func expandedTextWidth(_ text: String) -> CGFloat {
        guard highlightsDecimal, let decimal = text.firstIndex(of: separatorCharacter) else {
            return text.textWidth(kerning: 0, uiFont)
        }
        return String(text[..<decimal]).textWidth(kerning: 0, uiFont)
            + String(separatorCharacter).textWidth(kerning: 0, decimalHighlightUiFont) + 2 * decimalHighlightPadding
            + String(text[text.index(after: decimal)...]).textWidth(kerning: 0, uiFont)
    }

    func wrappedLines(for availableWidth: CGFloat) -> [Line] {
        if isScrollable && right != nil {
            // The exponent has its own fixed header; every scrolling row is mantissa.
            return wrap(left, nil, width: availableWidth, useFirstLine: false)
        }
        return wrap(left, right, width: availableWidth)
    }

    var preservesFirstLine: Bool {
        if isScrollable && right != nil { return false }
        guard let firstLine else { return false }
        return left.hasPrefix(firstLine.mantissa) && right == firstLine.exponent
    }

    func continuationInset(for availableWidth: CGFloat, line: Line) -> CGFloat {
        guard let firstLine else { return 0 }
        let scale = scaleFactor(for: availableWidth, line: firstLine)
        let firstOrigin = max(0, availableWidth - textWidth(of: firstLine) * scale)
        return max(0, firstOrigin + glyphAlignmentOffset(for: line, scale: scale))
    }

    func glyphAlignmentOffset(for line: Line, scale: CGFloat) -> CGFloat {
        guard let firstLine else { return 0 }
        return firstGlyphInset(firstLine.mantissa) * scale - firstGlyphInset(line.mantissa)
    }

    private func firstGlyphInset(_ text: String) -> CGFloat {
        guard let character = text.first else { return 0 }
        let attributed = NSAttributedString(string: String(character), attributes: [.font: uiFont])
        let line = CTLineCreateWithAttributedString(attributed)
        return CTLineGetBoundsWithOptions(line, .useGlyphPathBounds).minX
    }

    private func textWidth(of line: Line) -> CGFloat {
        line.mantissa.textWidth(kerning: 0, uiFont)
            + (line.exponent.map { exponentSpacing + exponentWidth($0) } ?? 0)
    }

    var exponentSpacing: CGFloat { isScrollable ? ePadding : uiFont.pointSize * 0.2 }

    func exponentPower(_ exponent: String) -> String {
        String(exponent.dropFirst())
    }

    func exponentWidth(_ exponent: String) -> CGFloat {
        if !isScrollable { return exponent.textWidth(kerning: 0, uiFont) }
        return "× 10".textWidth(kerning: 0, uiFont)
            + exponentPower(exponent).textWidth(kerning: 0, exponentUiFont)
    }

    private func wrap(_ mantissa: String, _ exponent: String?, width: CGFloat, limit: Int? = nil, useFirstLine: Bool = true, alignContinuation: Bool = false, highlightDecimal: Bool = false) -> [Line] {
        if useFirstLine, let firstLine,
           mantissa.hasPrefix(firstLine.mantissa), exponent == firstLine.exponent {
            let remaining = String(mantissa.dropFirst(firstLine.mantissa.count))
            guard !remaining.isEmpty else { return [firstLine] }
            if let limit, limit <= 1 { return [firstLine, Line(mantissa: remaining)] }
            return [firstLine] + wrap(remaining, nil, width: width, limit: limit.map { $0 - 1 }, useFirstLine: false, alignContinuation: true)
        }
        var lines: [Line] = []
        var current = ""
        var inset: CGFloat = 0
        for character in mantissa {
            if current.isEmpty && alignContinuation {
                inset = continuationInset(for: width, line: Line(mantissa: String(character)))
            }
            let candidate = current + String(character)
            let candidateWidth = highlightDecimal ? expandedTextWidth(candidate) : candidate.textWidth(kerning: 0, uiFont)
            if !current.isEmpty && candidateWidth + inset > width {
                lines.append(Line(mantissa: current))
                if let limit, lines.count >= limit { return lines + [Line(mantissa: String(character))] }
                current = String(character)
                if alignContinuation { inset = continuationInset(for: width, line: Line(mantissa: current)) }
            } else {
                current = candidate
            }
        }
        if let exponent,
           !current.isEmpty,
           current.textWidth(kerning: 0, uiFont) + exponentSpacing + exponentWidth(exponent) > width {
            lines.append(Line(mantissa: current))
            current = ""
        }
        lines.append(Line(mantissa: current, exponent: exponent))
        return lines
    }

    func scaleFactor(for availableWidth: CGFloat, line: Line? = nil) -> CGFloat {
        let line = line ?? Line(mantissa: left, exponent: right)
        return min(1.0, max(0.0, availableWidth) / max(1.0, textWidth(of: line)))
    }
    
    override func fits(_ mantissaParameter: String, _ exponentParameter: String? = nil) -> Bool {
        if let digitLimit {
            // A scrolling display is limited by precision rather than its visible height.
            var leadingZeros = 0
            var significantDigits = 0
            for character in mantissaParameter where character.isNumber {
                if significantDigits == 0 && character == "0" {
                    leadingZeros += 1
                    if leadingZeros > digitLimit { return false }
                } else {
                    significantDigits += 1
                    if significantDigits > digitLimit { return false }
                }
            }
            return true
        }
        var w: CGFloat
        var mantissa = mantissaParameter
        if let groupingCharacter = groupingCharacter {
            inject(into: &mantissa, separatorCharacter: separatorCharacter, groupingCharacter: groupingCharacter, groupSize: groupSize)
        }
        w = mantissa.textWidth(kerning: 0.0, uiFont)
        var exponent = exponentParameter
        if var formattedExponent = exponent {
            if let groupingCharacter = groupingCharacter {
                inject(into: &formattedExponent, separatorCharacter: separatorCharacter, groupingCharacter: groupingCharacter, groupSize: groupSize)
            }
            exponent = formattedExponent
            w += exponentSpacing + exponentWidth(formattedExponent)
        }
        if maxLines > 1 {
            let lines = wrap(mantissa, exponent, width: floatDisplayWidth, limit: maxLines)
            let anchored = firstLine.map { mantissa.hasPrefix($0.mantissa) && exponent == $0.exponent } ?? false
            return lines.count <= maxLines && lines.enumerated().allSatisfy { index, line in
                let inset = anchored && index > 0 ? continuationInset(for: floatDisplayWidth, line: line) : 0
                return textWidth(of: line) + inset <= floatDisplayWidth
            }
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
