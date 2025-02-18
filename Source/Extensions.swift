//
//  Extensions.swift
//  bg
//
//  Created by Joachim Neumann on 11/27/22.
//

import SwiftUI

#if CALCULATOR_MAC || TRANSLATE_MAC
public typealias AppleFont = NSFont
public typealias AppleColor = NSColor
public typealias AppleImage = NSImage
#else
public typealias AppleFont = UIFont
public typealias AppleColor = UIColor
public typealias AppleImage = UIImage
#endif

extension Int {
    var useWords: String {
        func remainderInWords(_ remainder: String) -> String {
            if remainder == "1" { return "one" }
            if remainder == "10" { return "ten" }
            return remainder
        }

        let asString = String(self)
        if asString.hasSuffix("000000000000") {
            let remainder = String(asString.dropLast(12))
            if remainder.count < 4 {
                return remainderInWords(remainder) + " trillion"
            } else {
                return asString
            }
        }
        if asString.hasSuffix("000000000") {
            let remainder = String(asString.dropLast(9))
            if remainder.count < 4 {
                return remainderInWords(remainder) + " billion"
            } else {
                return asString
            }
        }
        if asString.hasSuffix("000000") {
            let remainder = String(asString.dropLast(6))
            if remainder.count < 4 {
                return remainderInWords(remainder) + " million"
            } else {
                return asString
            }
        }
        if asString.hasSuffix("000") {
            let remainder = String(asString.dropLast(3))
            if remainder.count < 4 {
                return remainderInWords(remainder) + " thousand"
            } else {
                return asString
            }
        }
        return asString
    }
}

extension GeometryProxy {
    var notZero: Bool {
        self.size.width > 0 && self.size.height > 0
    }
}

extension Double {
    var asTime: String {
        if self < 1.0e-6 {
            return String(format: "%.1f microseconds", 1.0e6 * self)
        }
        if self < 1.0e-4 {
            return String(format: "%.1f microseconds", 1.0e6 * self)
        }
        if self < 0.1 {
            return String(format: "%.1f milliseconds", 1.0e3 * self)
        }
        if self < 0.0 {
            return String(format: "%.3f seconds", self)
        }
        if self < 10.0 {
            return String(format: "%.1f seconds", self)
        }
        if self < 60.0 {
            return String(format: "%.0f seconds", self)
        }
        return String(format: "%.1f hours", self/3600.0)
    }
}

extension String {
    func textWidth(kerning: CGFloat, _ font: AppleFont) -> CGFloat {
        var attributes: [NSAttributedString.Key : Any] = [:]
        attributes[.kern] = kerning
        attributes[.font] = font
        let notCeil = self.size(withAttributes: attributes).width
        return ceil(notCeil)
    }
}
