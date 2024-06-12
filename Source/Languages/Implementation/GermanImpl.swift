//
//  German.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import SwiftUI

class GermanImpl: LanguageGroup3 {
    @AppStorage("germanCaptalisationKey")
    var capitalisation: Bool = true
    
    init() {
        super.init(
            name: "Deutsch",
            zero: "null",
            negativeString: "minus",
            dotString: "Komma",
            exponentString: " mal zehn hoch ")

        voiceLanguageCode = "de"
        
        connector_2_1.before = Languages.WordSplitter
        connector_2_1.name = "und"
        connector_2_1.before = Languages.WordSplitter
        group_2_inverted = true
        connector_3_2.name = "hundert"
        connector_4_3.name = "tausend"
        connector_7_6.before = " "
        connector_7_6.name = "Millionen"
        connector_7_6.one = "eine Million"
        connector_7_6.after = " und "
        connector_10_9.before = " "
        connector_10_9.name = "Milliarden"
        connector_10_9.one = "eine Milliarde"
        connector_10_9.after = " "
        connector_13_12.before = " "
        connector_13_12.name = "Billionen"
        connector_13_12.one = "eine Billion"
        connector_13_12.after = " "

        afterNegative = " "
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
                if word == "und" {
                    ret += word + " "
                } else {
                    ret += word.prefix(1).uppercased() + word.dropFirst() + " "
                }
            }
            if ret.hasSuffix(" ") {
                ret = String(ret.dropLast())
            }
        }

        return ret
    }
    
    override func override(_ i: Int) -> String? {
        switch i {
        case 1:  return "eins"
        case 2:  return "zwei"
        case 3:  return "drei"
        case 4:  return "vier"
        case 5:  return "fünf"
        case 6:  return "sechs"
        case 7:  return "sieben"
        case 8:  return "acht"
        case 9:  return "neun"
        case 10: return "zehn"
        case 11: return "elf"
        case 12: return "zwölf"
        case 13: return "dreizehn"
        case 14: return "vierzehn"
        case 15: return "fünfzehn"
        case 16: return "sechzehn"
        case 17: return "siebzehn"
        case 18: return "achtzehn"
        case 19: return "neunzehn"
        case 20: return "zwanzig"
        case 30: return "dreißig"
        case 40: return "vierzig"
        case 50: return "fünfzig"
        case 60: return "sechzig"
        case 70: return "siebzig"
        case 80: return "achtzig"
        case 90: return "neunzig"
        default:
            return nil
        }
    }
}
