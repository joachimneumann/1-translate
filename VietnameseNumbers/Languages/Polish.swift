//
//  Polish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class Polish: Language {
    init() {
        super.init(
            name: "Polski",
            negativeString: "minus",
            dotString: "przecinek",
            exponentString: " razy dziesięć do potęgi ",
            groupSeparator: "",
            decimalSeparator: ".")
        
        e2 = "sto"
        e2_one = "sto"
        afterGroup = " "
        tensConnector = " "
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "zero"
        case 1:     return "jeden"
        case 2:     return "dwa"
        case 3:     return "trzy"
        case 4:     return "cztery"
        case 5:     return "pięć"
        case 6:     return "sześć"
        case 7:     return "siedem"
        case 8:     return "osiem"
        case 9:     return "dziewięć"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "dziesięć"
        case 2:     return "dwadzieścia"
        case 3:     return "trzydzieści"
        case 4:     return "czterdzieści"
        case 5:     return "pięćdziesiąt"
        case 6:     return "sześćdziesiąt"
        case 7:     return "siedemdziesiąt"
        case 8:     return "osiemdziesiąt"
        case 9:     return "dziewięćdziesiąt"
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
        case 0:
            ret = ""
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
            ret += read(i.E2x)
        }
        return ret
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        var ret = ""
        var use_tysiące = false
        switch i.E3 % 10 {
        case 2, 3, 4:
            use_tysiące = true
        default:
            use_tysiące = false
        }
        switch i.E3 % 100 {
        case 11, 12, 13, 14:
            use_tysiące = false
        default:
            break
        }
        ret = read(i.E3) + " " + (use_tysiące ? "tysiące" : "tysięcy")
        if i.E3 == 1 { ret = "tysiąc" }

        if i.E3x > 0 {
            ret += " " + read_e2_e3(i.E3x)
        }
        return ret
    }
}
