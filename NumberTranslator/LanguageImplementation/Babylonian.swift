//
//  BabylonianImplementation.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class BabylonianImplementation: GeneralLanguage, BabylonianParameterProtocol {
    var allowEmptyColumn: Bool = false

    static let symbolSpace = ""
    static let symbolNone = "\u{00a0}"//  " "
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


    var none: String {
        allowEmptyColumn ? BabylonianImplementation.symbolEmptyColumn : BabylonianImplementation.symbolNone
    }
    
    override init() {
        super.init()
        name = "Babylonian"
        allowNegative = false
        allowFraction = false
        allowExponent = false
    }
    
    private func representation(_ i: UInt) -> String {
        let first = i / 10
        let rest = i - 10 * first
        var ret = ""
        switch first {
        case 0: break
        case 1: ret += Self.symbolTen
        case 2: ret += Self.symbolTwenty
        case 3: ret += Self.symbolThirty
        case 4: ret += Self.symbolForty
        case 5: ret += Self.symbolFifty
        default: fatalError("representation: outside")
        }
        switch rest {
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
    override func fromUInt(_ i: UInt) -> String {
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
        
        
//        while ret.hasSuffix(" ") {
//            ret.removeLast()
//        }
        while ret.hasSuffix(Self.symbolEmptyColumn) {
            /// sadly, 60 and 1 will have the same value :(
            ret.removeLast(Self.symbolEmptyColumn.count)
        }

        return ret
    }
    
}
