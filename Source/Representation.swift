//
//  Representation.swift
//  SwiftGmp
//
//  Created by Joachim Neumann on 25.09.24.
//

import UIKit
import SwiftGmp

func injectGrouping(numberString: String, decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
    if numberString.starts(with: "-") {
        return "-" + nonNegativeInjectGrouping(numberString: String(numberString.dropFirst()), decimalSeparator: decimalSeparator, separateGroups: separateGroups)
    } else {
        return nonNegativeInjectGrouping(numberString: numberString, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
    }
}

private func nonNegativeInjectGrouping(numberString: String, decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
    let parts = numberString.split(separator: decimalSeparator.character)
    if parts.count == 2 {
        return nonNegativeInjectGrouping(
            numberString: String(parts[0]),
            decimalSeparator: decimalSeparator,
            separateGroups: separateGroups) +
            decimalSeparator.rawValue +
        parts[1]
    } else {
        var ret: String = numberString
        if separateGroups {
            var count = ret.count
            while count >= 4 {
                count = count - 3
                ret.insert(decimalSeparator.groupCharacter, at: ret.index(ret.startIndex, offsetBy: count))
            }
        }
        return ret
    }
}

public enum DecimalSeparator: String, Codable, CaseIterable {
    case comma = ","
    case dot = "."
    public var character: Character {
        get {
            switch self {
            case .comma: return ","
            case .dot: return "."
            }
        }
    }
    public var groupCharacter: Character {
        get {
            switch self {
            case .comma: return "."
            case .dot: return ","
            }
        }
    }
}

struct Content {
    let text: String
    let uiFont: UIFont
    init(_ text: String, uiFont: UIFont) {
        self.text = text
        self.uiFont = uiFont
    }
}

struct Number {
    let mantissa: Content
    let exponent: Content?
    init(mantissa: Content, exponent: Content? = nil) {
        self.mantissa = mantissa
        self.exponent = exponent
    }
}

struct Representation {
    var error: Content?
    var number: Number?
    let kerning: CGFloat
    let ePadding: CGFloat
    
    public init() {
        error = nil
        number = Number(mantissa: Content("0", uiFont: .systemFont(ofSize: 40)))
        kerning = 0
        ePadding = 0
    }
    
    init(error: String, uiFont: UIFont) {
        self.error = Content(error, uiFont: uiFont)
        self.number = nil
        kerning = 0
        ePadding = 0
    }

    init(mantissa: String, uiFont: UIFont) {
        self.error = nil
        self.number = Number(mantissa: Content(mantissa, uiFont: uiFont))
        kerning = 0
        ePadding = 0
    }

    public init(mantissaExponent: MantissaExponent, proportionalFont: UIFont, monoSpacedFont: UIFont, ePadding: CGFloat, width: CGFloat) {
        self.error = nil
        self.kerning = 0
        self.ePadding = ePadding
        var mantissa = mantissaExponent.mantissa
        let exponent = mantissaExponent.exponent
        let isNegativeSign: String
        if mantissa.starts(with: "-") {
            isNegativeSign = "-"
            mantissa = String(mantissa.dropFirst())
        } else {
            isNegativeSign = ""
        }

        // Integer representation
        if mantissa.count <= exponent + 1 {
            // Pad mantissa with zeros to match the exponent
            var tempMantissa = mantissa
            tempMantissa = tempMantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
            tempMantissa = isNegativeSign + tempMantissa
            if tempMantissa.textWidth(kerning: kerning, proportionalFont) <= width {
                // the interger fits in the display
                number = Number(mantissa: Content(tempMantissa, uiFont: proportionalFont))
                return
            }
            // the interger is too large: show in scientific notation
            var sciMantissa: String = tempMantissa
            let decimalIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: 1)
            sciMantissa.insert(DecimalSeparator.dot.character, at: decimalIndex)
            if sciMantissa.count == 2 {
                sciMantissa.append("0")
            }
            let exponentString = "e\(exponent)"
            let exponentWidth = exponentString.textWidth(kerning: kerning, monoSpacedFont)
            let remainingMantissaWidth = width - exponentWidth - ePadding
            if sciMantissa.textWidth(kerning: kerning, proportionalFont) < remainingMantissaWidth {
                number = Number(mantissa: Content(sciMantissa, uiFont: proportionalFont), exponent: Content(exponentString, uiFont: monoSpacedFont))
                return
            }
            // truncate!
            var offset = 2
            var sciIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: offset, limitedBy: sciMantissa.endIndex) // including the dot
            var truncatedSciMantissa = String(sciMantissa.prefix(upTo: sciIndex!))
            while true {
                offset += 1
                sciIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: offset, limitedBy: sciMantissa.endIndex)
                truncatedSciMantissa = String(sciMantissa.prefix(upTo: sciIndex!))
                if  truncatedSciMantissa.textWidth(kerning: kerning, proportionalFont) > remainingMantissaWidth {
                    // go one character back
                    offset -= 1
                    sciIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: offset, limitedBy: sciMantissa.endIndex)
                    truncatedSciMantissa = String(sciMantissa.prefix(upTo: sciIndex!))
                    number = Number(mantissa: Content(truncatedSciMantissa, uiFont: proportionalFont), exponent: Content(exponentString, uiFont: monoSpacedFont))
                    return
                }
            }
            if truncatedSciMantissa.textWidth(kerning: kerning, proportionalFont) < remainingMantissaWidth {
                // the mantissa fits :)
                
            }
        }
        if exponent >= 0 {
            // Floating-point representation without scientific notation
            var floatString: String = mantissa
            let decimalIndex = floatString.index(floatString.startIndex, offsetBy: exponent + 1)
            floatString.insert(DecimalSeparator.dot.character, at: decimalIndex)
            floatString = isNegativeSign + floatString
            if floatString.textWidth(kerning: kerning, proportionalFont) <= width {
                number = Number(mantissa: Content(floatString, uiFont: proportionalFont))
                return
            }
            // truncate!
            var offset = 2
            var posAfterDotAndOneDigit = floatString.index(decimalIndex, offsetBy: offset, limitedBy: floatString.endIndex)
            var truncatedFloatString = String(floatString.prefix(upTo: posAfterDotAndOneDigit!))
            if truncatedFloatString.textWidth(kerning: kerning, proportionalFont) <= width {
                // the float fits into the display
                while true {
                    offset += 1
                    posAfterDotAndOneDigit = floatString.index(decimalIndex, offsetBy: offset, limitedBy: floatString.endIndex)
                    truncatedFloatString = String(floatString.prefix(upTo: posAfterDotAndOneDigit!))
                    if  truncatedFloatString.textWidth(kerning: kerning, proportionalFont) > width {
                        // go one character back
                        offset -= 1
                        posAfterDotAndOneDigit = floatString.index(decimalIndex, offsetBy: offset, limitedBy: floatString.endIndex)
                        truncatedFloatString = String(floatString.prefix(upTo: posAfterDotAndOneDigit!))
                        number = Number(mantissa: Content(truncatedFloatString, uiFont: proportionalFont))
                        return
                    }
                }
            }
        }

    }
//        var tempMantissa = mantissa
//        self.error = nil
//        if tempMantissa.starts(with: "-") {
//            self.isNegative = true
//            tempMantissa = String(tempMantissa.dropFirst())
//        } else {
//            self.isNegative = false
//        }
//
//        let isNegativeSign: String = isNegative ? "-" : ""
//        
//        // Integer representation
//        if tempMantissa.count <= exponent + 1 && exponent < maxOutputLength {
//            // Pad mantissa with zeros to match the exponent
//            tempMantissa = tempMantissa.padding(toLength: exponent + 1, withPad: "0", startingAt: 0)
//            self.mantissa = isNegativeSign + tempMantissa
//            self.exponent = nil
//        }
//        // Floating-point representation without scientific notation
//        else if exponent >= 0 && exponent <= maxOutputLength - 3 {
//            var floatString: String = tempMantissa
//            let decimalIndex = floatString.index(floatString.startIndex, offsetBy: exponent + 1)
//            floatString.insert(DecimalSeparator.dot.character, at: decimalIndex)
//            let maxLength: Int = maxOutputLength - isNegativeSign.count
//            self.mantissa = isNegativeSign + String(floatString.prefix(maxLength))
//            self.exponent = nil
//        }
//        // Floating-point representation with leading zeros (exponent is negative)
//        else if exponent < 0 {
//            let zerosToInsert: Int = abs(exponent) - 1
//            let leadingZeros: String = String(repeating: "0", count: zerosToInsert)
//            self.mantissa = isNegativeSign + "0" + DecimalSeparator.dot.rawValue + leadingZeros + tempMantissa
//            let maxLength: Int = maxOutputLength - isNegativeSign.count
//            self.mantissa = String(self.mantissa!.prefix(maxLength))
//            self.exponent = nil
//        }
//        // Scientific notation representation
//        else {
//            var sciMantissa: String = tempMantissa
//            let decimalIndex = sciMantissa.index(sciMantissa.startIndex, offsetBy: 1)
//            sciMantissa.insert(DecimalSeparator.dot.character, at: decimalIndex)
//            if sciMantissa.count == 2 {
//                sciMantissa.append("0")
//            }
//            let exponentString: String = "e\(exponent)"
//            let maxLength: Int = maxOutputLength - isNegativeSign.count - exponentString.count
//            self.mantissa = String(sciMantissa.prefix(maxLength))
//            self.exponent = exponent
//        }
//    }
//
//    func localizedMantissa(decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String? {
//        if var tempMantissa = mantissa {
//            if decimalSeparator != .dot {
//                tempMantissa = tempMantissa.replacingOccurrences(of: DecimalSeparator.dot.rawValue, with: decimalSeparator.rawValue)
//            }
//            tempMantissa = injectGrouping(numberString: tempMantissa, decimalSeparator: decimalSeparator, separateGroups: separateGroups)
//            return tempMantissa
//        }
//        return nil
//    }
//
////    func localizedString(decimalSeparator: DecimalSeparator, separateGroups: Bool) -> String {
////        var tempR = self
////        tempR.mantissa = localizedMantissa(decimalSeparator: decimalSeparator, separateGroups: separateGroups)
////        return tempR.string
////    }
//    
//    public var string: String {
//        guard error == nil else { return error! }
//        if let exponent = exponent {
//            if let mantissa = mantissa {
//                return "\(mantissa)e\(exponent)"
//            } else {
//                return "undefined"
//            }
//        } else {
//            if let mantissa = mantissa {
//                return mantissa
//            } else {
//                return "undefined"
//            }
//        }
//    }
//    
//    public var double: Double {
//        Double(string) ?? Double.nan
//    }

}

//extension String {
//    func before(first delimiter: Character) -> String {
//        if let index = firstIndex(of: delimiter) {
//            let before = prefix(upTo: index)
//            return String(before)
//        }
//        return ""
//    }
//    
//    func after(first delimiter: Character) -> String {
//        if let index = firstIndex(of: delimiter) {
//            let after = suffix(from: index).dropFirst()
//            return String(after)
//        }
//        return ""
//    }
//    
//    func replacingFirstOccurrence(of target: String, with replacement: String) -> String {
//        guard let range = self.range(of: target) else { return self }
//        return self.replacingCharacters(in: range, with: replacement)
//    }
//}
