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
        
        _10_99_connector.before = Languages.WordSplitter
        _10_99_connector.name = "und"
        _10_99_connector.before = Languages.WordSplitter
        _11_99_inverted = true

        afterNegative = " "
        postProcessing = germanPostProcessing
    }
    
    override func hundred(_ hundreds: Int, _0_99: Int) -> String {
        var ret: String
        if hundreds == 1 {
            ret = "einhundert"
        } else {
            ret = _1_99(hundreds, isLargestGroup: false) + "hundert"
        }
        if _0_99 > 0 {
            ret += _1_99(_0_99, isLargestGroup: false)
        }
        return ret
    }
    
    func germanPostProcessing(_ unprocessed: String) -> String {
        var ret = unprocessed
        ret = ret.replacingOccurrences(of: "eins"+Languages.WordSplitter+"und", with: "ein"+Languages.WordSplitter+"und")

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

    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "eins"
        case 2:  return "zwei"
        case 3:  return "drei"
        case 4:  return "vier"
        case 5:  return "fünf"
        case 6:  return "sechs"
        case 7:  return "sieben"
        case 8:  return "acht"
        case 9:  return "neun"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String? {
        switch i {
        case 1: return "zehn"
        case 2: return "zwanzig"
        case 3: return "dreißig"
        case 4: return "vierzig"
        case 5: return "fünfzig"
        case 6: return "sechzig"
        case 7: return "siebzig"
        case 8: return "achtzig"
        case 9: return "neunzig"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }
    
    override func _10_19(_ i: Int) -> String? {
        switch i {
        case 10: return _10s(1)
        case 11: return "elf"
        case 12: return "zwölf"
        case 13: return "dreizehn"
        case 14: return "vierzehn"
        case 15: return "fünfzehn"
        case 16: return "sechzehn"
        case 17: return "siebzehn"
        case 18: return "achtzehn"
        case 19: return "neunzehn"
        default:
            fatalError("_11_19() parameter \(i)")
        }
    }
}
