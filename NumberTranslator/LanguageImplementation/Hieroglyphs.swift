//
//  Hieroglyphs.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class HieroglyphsImplementation: GeneralLanguage  {
    // static, because I will use it in the tests
    static let symbolOne = "\u{133E4}"
    static let symbolTen = "\u{13386}"
    static let symbolHundred = "\u{13362}"
    static let symbolThousand = "\u{131BC}"
    static let symbolTenThousand = "\u{130AD}"
    static let symbolHundredThousand = "\u{13190}"
    static let symbolMillion = "\u{13068}"

    override init() {
        super.init()
        name = "Hieroglyphs"
        allowZero = false
        allowNegative = false
        allowFraction = false
        allowExponent = false
    }

    override func fromUInt(_ i: UInt) -> String {
        if i > 10_000_000 {
            return "too big"
        }
        let without = readHieroglyphs(i, newLine: "")
        if without.count < 17 {
            return without
        } else {
            return readHieroglyphs(i, newLine: "\n")
        }
    }

    private func readHieroglyphs(_ i: UInt, newLine: String) -> String {
        var ret = ""
        var value = i
        if value >= 1_000_000 {
            for _ in 0..<(value / 1_000_000) {
                ret += HieroglyphsImplementation.symbolMillion
                value -= 1_000_000
            }
            ret += newLine
        }
        if value >= 100_000 {
            for _ in 0..<(value / 100_000) {
                ret += HieroglyphsImplementation.symbolHundredThousand
                value -= 100_000
            }
            ret += newLine
        }
        if value >= 10_000 {
            for _ in 0..<(value / 10_000) {
                ret += HieroglyphsImplementation.symbolTenThousand
                value -= 10_000
            }
            ret += newLine
        }
        if value >= 1_000 {
            for _ in 0..<(value / 1_000) {
                ret += HieroglyphsImplementation.symbolThousand
                value -= 1_000
            }
            ret += newLine
        }
        if value >= 100 {
            for _ in 0..<(value / 100) {
                ret += HieroglyphsImplementation.symbolHundred
                value -= 100
            }
            ret += newLine
        }
        if value >= 10 {
            for _ in 0..<(value / 10) {
                ret += HieroglyphsImplementation.symbolTen
                value -= 10
            }
            ret += newLine
        }
        if value > 0 {
            for _ in 0..<(value) {
                ret += HieroglyphsImplementation.symbolOne
                value -= 1
            }
            ret += newLine
        }
        return ret
    }
}
