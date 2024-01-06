//
//  Polish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class PolishImpl: LanguageImpl {
    init() {
        super.init(
            name: "Polski",
            negativeString: "minus",
            dotString: "przecinek",
            exponentString: " razy dziesięć do potęgi ")
        
        voiceLanguageCode = "pl"
        voiceLanguageName = "Polish"
        e2 = "sto"
        e2_one = "sto"
        afterGroup = " "
        tensConnector = " "
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:         return "zero"
        case 1:         return "jeden"
        case 2:         return "dwa"
        case 3:         return "trzy"
        case 4:         return "cztery"
        case 5:         return "pięć"
        case 6:         return "sześć"
        case 7:         return "siedem"
        case 8:         return "osiem"
        case 9:         return "dziewięć"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:         return "dziesięć"
        case 2:         return "dwadzieścia"
        case 3:         return "trzydzieści"
        case 4:         return "czterdzieści"
        case 5:         return "pięćdziesiąt"
        case 6:         return "sześćdziesiąt"
        case 7:         return "siedemdziesiąt"
        case 8:         return "osiemdziesiąt"
        case 9:         return "dziewięćdziesiąt"
        default: return "read_10s outside range"
        }
    }
    
    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "jedenaście" }
        if i == 12 { return "dwanaście" }
        if i == 13 { return "trzynaście" }
        if i == 14 { return "czternaście" }
        if i == 15 { return "piętnaście" }
        if i == 16 { return "szesnaście" }
        if i == 17 { return "siedemnaście" }
        if i == 18 { return "osiemnaście" }
        if i == 19 { return "dziewiętnaście" }
        return super.read_10_99(i)
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        switch i.E2 {
        case 1:
            ret = "sto"
        case 2:
            ret = "dwieście"
        case 3, 4:
            ret = read_0_9(i.E2) + "sta"
        default:
            ret = read_0_9(i.E2) + "set"
        }
        if i.E2x > 0 {
            if ret.count > 0 { ret += " " }
            ret += readInteger(i.E2x)
        }
        return ret
    }
    
    private func use(_ i: Int, _ s1: String, _ s2: String) -> String {
        var use1 = false
        switch i % 10 {
        case 2, 3, 4:
            use1 = true
        default:
            use1 = false
        }
        switch i % 100 {
        case 11, 12, 13, 14:
            use1 = false
        default:
            break
        }
        return use1 ? s1 : s2
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        var ret = readInteger(i.E3) + " " + use(i.E3, "tysiące", "tysięcy")
        if i.E3 == 1 { ret = "tysiąc" }
        if i.E3x > 0 { ret += " " + readInteger(i.E3x) }
        return ret
    }
    
    override func read_e6_e9(_ i: Int) -> String {
        var ret = readInteger(i.E6) + " " + use(i.E6, "miliony", "milionów")
        if i.E6 == 1 { ret = "jeden milion" }
        if i.E6x > 0 { ret += " " + readInteger(i.E6x) }
        return ret
    }
    
    override func read_e9_e12(_ i: Int) -> String {
        var ret = readInteger(i.E9) + " " + use(i.E9, "miliardy", "miliardów")
        if i.E9 == 1 { ret = "jeden miliard" }
        if i.E9x > 0 { ret += " " + readInteger(i.E9x) }
        return ret
    }
    
    override func read_e12_e15(_ i: Int) -> String {
        var ret = readInteger(i.E12) + " " + use(i.E12, "biliony", "bilionów")
        if i.E12 == 1 { ret = "jeden bilion" }
        if i.E12x > 0 { ret += " " + readInteger(i.E12x) }
        return ret
    }
}
