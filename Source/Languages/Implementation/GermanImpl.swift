//
//  German.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import SwiftUI

extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}


class GermanImpl: Language {
    @AppStorage("germanCaptalisationKey")
    var capitalisation: Bool = true
    
    init() {
        super.init(
            name: "Deutsch",
            negativeString: "minus",
            dotString: "Komma",
            exponentString: " mal zehn hoch ")

        voiceLanguageCode = "de"
        voiceLanguageName = "German"
        e2 = "hundert"
        e3 = "tausend"
        e6 = "Millionen"
        e6_one = "eine Million"
        e9 = "Milliarden"
        e9_one = "eine Milliarde"
        e12 = "Billionen"
        e12_one = "eine Billion"
        afterNegative = " "
        eSpace = ""
        e69Space = " "
        postProcessing = germanPostProcessing
    }
    
    func germanPostProcessing(_ unprocessed: String) -> String {
        var ret = unprocessed
        ret = ret.replacingOccurrences(of: "eins"+Languages.WordSplitter+"und", with: "ein"+Languages.WordSplitter+"und")
        ret = ret.replacingOccurrences(of: "einshundert", with: "einhundert")
        ret = ret.replacingOccurrences(of: "einstausend", with: "eintausend")

        if capitalisation {
            let words = ret.split(separator: " ")
            ret = ""
            for word in words {
                ret += word.prefix(1).uppercased() + word.dropFirst() + " "
            }
            if ret.hasSuffix(" ") {
                ret = String(ret.dropLast())
            }
        }

        return ret
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "null"
        case 1:     return "eins"
        case 2:     return "zwei"
        case 3:     return "drei"
        case 4:     return "vier"
        case 5:     return "fünf"
        case 6:     return "sechs"
        case 7:     return "sieben"
        case 8:     return "acht"
        case 9:     return "neun"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "zehn"
        case 2:     return "zwanzig"
        case 3:     return "dreißig"
        case 4:     return "vierzig"
        case 5:     return "fünfzig"
        case 6:     return "sechzig"
        case 7:     return "siebzig"
        case 8:     return "achtzig"
        case 9:     return "neunzig"
        default: return "read_10s: outside range"
        }
    }
    
    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "elf" }
        if i == 12 { return "zwölf" }
        if i == 13 { return "dreizehn" }
        if i == 14 { return "vierzehn" }
        if i == 15 { return "fünfzehn" }
        if i == 16 { return "sechzehn" }
        if i == 17 { return "siebzehn" }
        if i == 18 { return "achtzehn" }
        if i == 19 { return "neunzehn" }
        // reversed order
        var ret = ""
        if i.E1x > 0 {
            ret = read_0_9(i.E1x)
            ret += Languages.WordSplitter
            ret += "und"
            ret += Languages.WordSplitter
        }
        ret += read_10s(i.E1)
        return ret
        
    }
            
}
