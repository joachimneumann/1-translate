//
//  BabylonianImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/27/23.
//

import SwiftUI

class BabylonianImpl: Language {
    static let symbolSpace = ""
    static let symbolNone = ""
    static let symbolEmptyColumn = "𒑊"
    static let symbolOne = "𒐕"
    static let symbolTwo = "𒐖"
    static let symbolThree = "𒐗"
    static let symbolFour = "𒐘"
    static let symbolFive = "𒐙"
    static let symbolSix = "𒐚"
    static let symbolSeven = "𒐛"
    static let symbolEight = "𒐜"
    static let symbolNine = "𒐝"
    static let symbolTen = "𒌋"
    static let symbolTwenty = "𒎙"
    static let symbolThirty = "𒌍"
    static let symbolForty = "𒐏"
    static let symbolFifty = "𒐐"
    
    @AppStorage("babylonianEmptyColumn")
    var babylonianEmptyColumn: Bool = true

    var none: String {
        babylonianEmptyColumn ? BabylonianImpl.symbolEmptyColumn : BabylonianImpl.symbolNone
    }
    init() {
        super.init(
            name: "Babylonian",
            zero: nil,
            negativeString: "",
            dotString: "",
            exponentString: "")
        allowNegativeNumbers = false
        allowExponent = false
        allowFraction = false
    }
    
    private func representation(_ i: Int) -> String {
        var ret = ""
        switch i.E1 {
        case 0: break
        case 1: ret += Self.symbolTen
        case 2: ret += Self.symbolTwenty
        case 3: ret += Self.symbolThirty
        case 4: ret += Self.symbolForty
        case 5: ret += Self.symbolFifty
        default: fatalError("representation: outside")
        }
        switch i.E1x {
        case 0: break
        case 1: ret += Self.symbolOne
        case 2: ret += Self.symbolTwo
        case 3: ret += Self.symbolThree
        case 4: ret += Self.symbolFour
        case 5: ret += Self.symbolFive
        case 6: ret += Self.symbolSix
        case 7: ret += Self.symbolSeven
        case 8: ret += Self.symbolEight
        case 9: ret += Self.symbolNine
        default: fatalError("representation: outside")
        }
        return ret
    }
    
    override func read_1_(_ i: Int) -> String {
        if i > 60*60*60*60 {
            return "too big"
        }        
        var value = i
        var ret = ""
        if value >= 60*60*60 {
            let group = value / (60*60*60)
            ret += representation(group)
            value -= 60*60*60 * group
        }
        if value >= 60*60 {
            if ret.count > 0 {  ret += Self.symbolSpace }
            let group = value / (60*60)
            ret += representation(group)
            value -= 60*60 * group
        } else {
            if ret.count > 0 { ret += none }
        }
        if value >= 60 {
            if ret.count > 0 {  ret += Self.symbolSpace }
            let group = value / (60)
            ret += representation(group)
            value -= 60 * group
        } else {
            if ret.count > 0 { ret += none }
        }
        if value > 0 {
            if ret.count > 0 {  ret += Self.symbolSpace }
            ret += representation(value)
        } else {
            if ret.count > 0 { ret += none }
        }
        
        
        while ret.hasSuffix(" ") {
            ret.removeLast()
        }
        while ret.hasSuffix(Self.symbolEmptyColumn) {
            /// sadly, 60 and 1 will have the same value :(
            ret.removeLast(Self.symbolEmptyColumn.count)
        }

        return ret
    }
}
