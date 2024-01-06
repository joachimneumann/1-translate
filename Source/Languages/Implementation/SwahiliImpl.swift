//
//  SwahiliImpl.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 1/2/24.
//

import SwiftUI

class SwahiliImpl: Language {
    init() {
        super.init(
            name: "Swahili",
            negativeString: "menos",
            dotString: "kaj",
            exponentString: " EE ")
        tensConnector = " na "
        eSpace = " "
        e6 = "milioni"
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "sifuri"
        case 1:     return "moja"
        case 2:     return "mbili"
        case 3:     return "tatu"
        case 4:     return "nne"
        case 5:     return "tano"
        case 6:     return "sita"
        case 7:     return "saba"
        case 8:     return "nane"
        case 9:     return "tisa"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "kumi"
        case 2:     return "ishirini"
        case 3:     return "thelathini"
        case 4:     return "arobaini"
        case 5:     return "hamsini"
        case 6:     return "sitini"
        case 7:     return "sabini"
        case 8:     return "themanini"
        case 9:     return "tisini"
        default: return "read_10s: outside range"
        }
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = "mia " + read_0_9(i.E2)
        if i.E2x > 0 {
            var leftover = read(i.E2x)
            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
            ret += ", " + leftover
        }
        return ret
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        var ret = ""
        if i.E3 >= 100 {
            ret = "laki " + read(i.E5)
            if i.E5x > 0 {
                var leftover = read(i.E5x)
                if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
                ret += ", " + leftover
            }
        } else {
            ret = "elfu " + read(i.E3)
            if i.E3x > 0 {
                var leftover = read(i.E3x)
                if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
                ret += ", " + leftover
            }
        }
        return ret
    }
    
    override func read_e6_e9(_ i: Int) -> String {
        var ret = ""
        ret = "milioni " + read(i.E6)
        if i.E6x > 0 {
            var leftover = read(i.E6x)
            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
            ret += ", " + leftover
        }
        return ret
    }
    
    override func read_e9_e12(_ i: Int) -> String {
        var ret = ""
        ret = "bilioni " + read(i.E9)
        if i.E9x > 0 {
            var leftover = read(i.E9x)
            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
            ret += ", " + leftover
        }
        return ret
    }

    override func read_e12_e15(_ i: Int) -> String {
        var ret = ""
        ret = "trilioni " + read(i.E12)
        if i.E12x > 0 {
            var leftover = read(i.E12x)
            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
            ret += ", " + leftover
        }
        return ret
    }

}
