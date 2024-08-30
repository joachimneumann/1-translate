//
//  BabylonianImplementation.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation
import SwiftUI

class BabylonianImplementation: GeneralLanguage, BabylonianParameterProtocol {
    @AppStorage("babylonianAllowEmptyColumn", store: .standard)
    var babylonianAllowEmptyColumn: Bool = false

    let symbolSpace = ""
    let symbolNone = "\u{00a0}"//  " "
    let symbolEmptyColumn = "𒑊"
    let symbolOne = "𒐕"
    let symbolTwo = "𒐖"
    let symbolThree = "𒐗"
    let symbolFour = "𒐘"
    let symbolFive = "𒐙"
    let symbolSix = "𒐚"
    let symbolSeven = "𒐛"
    let symbolEight = "𒐜"
    let symbolNine = "𒐝"
    let symbolTen = "𒌋"
    let symbolTwenty = "𒎙"
    let symbolThirty = "𒌍"
    let symbolForty = "𒐏"
    let symbolFifty = "𒐐"


    var none: String {
        babylonianAllowEmptyColumn ? symbolEmptyColumn : symbolNone
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
        case 1: ret += symbolTen
        case 2: ret += symbolTwenty
        case 3: ret += symbolThirty
        case 4: ret += symbolForty
        case 5: ret += symbolFifty
        default: fatalError("representation: outside")
        }
        switch rest {
        case 0: break
        case 1: ret += symbolOne
        case 2: ret += symbolTwo
        case 3: ret += symbolThree
        case 4: ret += symbolFour
        case 5: ret += symbolFive
        case 6: ret += symbolSix
        case 7: ret += symbolSeven
        case 8: ret += symbolEight
        case 9: ret += symbolNine
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
            if ret.count > 0 {  ret += symbolSpace }
            let group = value / (60*60)
            ret += representation(group)
            value -= 60*60 * group
        } else {
            if ret.count > 0 { ret += none }
        }
        if value >= 60 {
            if ret.count > 0 {  ret += symbolSpace }
            let group = value / (60)
            ret += representation(group)
            value -= 60 * group
        } else {
            if ret.count > 0 { ret += none }
        }
        if value > 0 {
            if ret.count > 0 {  ret += symbolSpace }
            ret += representation(value)
        } else {
            if ret.count > 0 { ret += none }
        }
        
        
//        while ret.hasSuffix(" ") {
//            ret.removeLast()
//        }
        while ret.hasSuffix(symbolEmptyColumn) {
            /// sadly, 60 and 1 will have the same value :(
            ret.removeLast(symbolEmptyColumn.count)
        }

        return ret
    }
    
}
