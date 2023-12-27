//
//  HieroglyphsImpl.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/27/23.
//

import Foundation

class HieroglyphsImpl: LanguageImpl {
    static let symbolZero = "\u{13124}"
    static let symbolOne = "\u{133E4}"
    static let symbolTen = "\u{13386}"
    static let symbolHundred = "\u{13362}"
    static let symbolThousand = "\u{131BC}"
    static let symbolTenThousand = "\u{130AD}"
    static let symbolHundredThousand = "\u{13190}"
    static let symbolMillion = "\u{13068}"

    init() {
        super.init(
            name: "Hieroglyphs",
            negativeString: "",
            dotString: "",
            exponentString: "")
        allowNegativeNumbers = false
        allowExponent = false
        allowFraction = false
    }
    
    private func readHieroglyphs(_ i: Int, newLine: String) -> String {
        var ret = ""
        var value = i
        if value >= 1_000_000 {
            for _ in 0..<(value / 1_000_000) {
                ret += HieroglyphsImpl.symbolMillion
                value -= 1_000_000
            }
            ret += newLine
        }
        if value >= 100_000 {
            for _ in 0..<(value / 100_000) {
                ret += HieroglyphsImpl.symbolHundredThousand
                value -= 100_000
            }
            ret += newLine
        }
        if value >= 10_000 {
            for _ in 0..<(value / 10_000) {
                ret += HieroglyphsImpl.symbolTenThousand
                value -= 10_000
            }
            ret += newLine
        }
        if value >= 1_000 {
            for _ in 0..<(value / 1_000) {
                ret += HieroglyphsImpl.symbolThousand
                value -= 1_000
            }
            ret += newLine
        }
        if value >= 100 {
            for _ in 0..<(value / 100) {
                ret += HieroglyphsImpl.symbolHundred
                value -= 100
            }
            ret += newLine
        }
        if value >= 10 {
            for _ in 0..<(value / 10) {
                ret += HieroglyphsImpl.symbolTen
                value -= 10
            }
            ret += newLine
        }
        if value > 0 {
            for _ in 0..<(value) {
                ret += HieroglyphsImpl.symbolOne
                value -= 1
            }
            ret += newLine
        }
        return ret
    }
    
    override func readInteger(_ i: Int) -> String {
        if i > 10_000_000 {
            return "too big"
        }
        if i == 0 {
            return HieroglyphsImpl.symbolZero
        }
        
        let without = readHieroglyphs(i, newLine: "")
        if without.count < 17 {
            return without
        } else {
            return readHieroglyphs(i, newLine: "\n")
        }
    }
}
