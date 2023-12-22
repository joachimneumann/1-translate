//
//  Danish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class Danish: Language {

    init() {
        super.init(
            name: "Dansk",
            negativeString: "minus",
            dotString: "komma",
            exponentString: " gange ti i ",
            groupSeparator: "",
            decimalSeparator: ".")
        
        e2 = "hundrede"
        e2_one = "hundred"
        afterGroup = " og"
        e3 = "tusind"
        e3_one = "ettusind"
        e6 = "million"
        e9 = "milliard"
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

}

