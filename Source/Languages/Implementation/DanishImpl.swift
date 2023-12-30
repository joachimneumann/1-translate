//
//  Danish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class DanishImpl: LanguageImpl {

    init() {
        super.init(
            name: "Dansk",
            negativeString: "minus",
            dotString: "komma",
            exponentString: " gange ti i ")
        
        voiceLanguageCode = "da"
        voiceLanguageName = "Danish"
        e2 = "hundrede"
        e2_one = "hundred"
        afterGroup = " og"
        e3 = "tusinde"
        e3_one = "ettusind"
        e6 = "millioner"
        e6_one = "en million"
        e9 = "milliarder"
        e9_one = "en milliard"
        e12 = "billioner"
        e12_one = "en billion"
        eSpace = " "
        beforeAndAfterDotString = " "
    }

    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "nul"
        case 1:     return "en"
        case 2:     return "to"
        case 3:     return "tre"
        case 4:     return "fire"
        case 5:     return "fem"
        case 6:     return "seks"
        case 7:     return "syv"
        case 8:     return "otte"
        case 9:     return "ni"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "ti"
        case 2:     return "tyve"
        case 3:     return "tredive"
        case 4:     return "fyrre"
        case 5:     return "halvtreds"
        case 6:     return "tres"
        case 7:     return "halvfjerds"
        case 8:     return "firs"
        case 9:     return "halvfems"
        default: return "read_10s: outside range"
        }
    }

    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "elleve" }
        if i == 12 { return "tolv" }
        if i == 13 { return "tretten" }
        if i == 14 { return "fjorten" }
        if i == 15 { return "femten" }
        if i == 16 { return "seksten" }
        if i == 17 { return "sytten" }
        if i == 18 { return "atten" }
        if i == 19 { return "nitten" }
        // reversed order
        return (i.E1x > 0 ? read_0_9(i.E1x) + "og" : "") + read_10s(i.E1)
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        var ret = ""
        if i.E3 == 1 {
            ret = e3_one!
        } else {
            ret = readInteger(i.E3)
            if i.E3 >= 100 && i.E3 < 200 {
                ret += "e"
            }
            ret += " " + e3!
        }
        if i.E3x > 0 {
            ret += " og " + readInteger(i.E3x)
        }
        return ret
    }

    override func read_e6_e9(_ i: Int) -> String {
        var ret = ""
        if i.E6 == 1 {
            ret = e6_one!
        } else {
            ret = readInteger(i.E6)
            if i.E6 >= 100 && i.E6 < 200 {
                ret += "e"
            }
            ret += " " + e6!
        }
        if i.E6x > 0 {
            ret += " og " + readInteger(i.E6x)
        }
        return ret
    }

    override func read_e9_e12(_ i: Int) -> String {
        var ret = ""
        if i.E9 == 1 {
            ret = e9_one!
        } else {
            ret = readInteger(i.E9)
            if i.E9 >= 100 && i.E9 < 200 {
                ret += "e"
            }
            ret += " " + e9!
        }
        if i.E9x > 0 {
            ret += " og " + readInteger(i.E9x)
        }
        return ret
    }
    
    override func read_e12_e15(_ i: Int) -> String {
        var ret = ""
        if i.E12 == 1 {
            ret = e12_one!
        } else {
            ret = readInteger(i.E12)
            if i.E12 >= 100 && i.E12 < 200 {
                ret += "e"
            }
            ret += " " + e12!
        }
        if i.E12x > 0 {
            ret += " og " + readInteger(i.E12x)
        }
        return ret
    }
}

