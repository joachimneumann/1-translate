//
//  Hieroglyphs.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class HieroglyphsImplementation: GeneralLanguage  {
    let symbolOne = "\u{133E4}"
    let symbolTen = "\u{13386}"
    let symbolHundred = "\u{13362}"
    let symbolThousand = "\u{131BC}"
    let symbolTenThousand = "\u{130AD}"
    let symbolHundredThousand = "\u{13190}"
    let symbolMillion = "\u{13068}"

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
                ret += symbolMillion
                value -= 1_000_000
            }
            ret += newLine
        }
        if value >= 100_000 {
            for _ in 0..<(value / 100_000) {
                ret += symbolHundredThousand
                value -= 100_000
            }
            ret += newLine
        }
        if value >= 10_000 {
            for _ in 0..<(value / 10_000) {
                ret += symbolTenThousand
                value -= 10_000
            }
            ret += newLine
        }
        if value >= 1_000 {
            for _ in 0..<(value / 1_000) {
                ret += symbolThousand
                value -= 1_000
            }
            ret += newLine
        }
        if value >= 100 {
            for _ in 0..<(value / 100) {
                ret += symbolHundred
                value -= 100
            }
            ret += newLine
        }
        if value >= 10 {
            for _ in 0..<(value / 10) {
                ret += symbolTen
                value -= 10
            }
            ret += newLine
        }
        if value > 0 {
            for _ in 0..<(value) {
                ret += symbolOne
                value -= 1
            }
            ret += newLine
        }
        return ret
    }
}
