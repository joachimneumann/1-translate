//
//  German.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import SwiftUI

class GermanImpl: LanguageImplGroup3 {
    @AppStorage("germanCaptalisationKey")
    var capitalisation: Bool = true
    
    init() {
        super.init(
            name: "Deutsch",
            groupSize: GroupSize.three,
            zero: "null",
            negativeString: "minus",
            dotString: "Komma",
            exponentString: " mal zehn hoch ")

        postProcessing = germanPostProcessing
        afterNegative = " "
        voiceLanguageCode = "de"
        _20_99_connector = Languages.WordSplitter + "und"
        before_hundreds = ""
        after_hundreds = ""
        before_groupName = ""
        after_groupName = ""
    }
    
    override func _20_99(_ i: Int) -> String {
        // inverted order in German
        let left = i / 10
        let right = i - left * 10
        var ret = _10s(left)
        if right > 0 {
            ret = _0_9(right) + _20_99_connector + ret
        }
        return ret
    }
    
    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
        switch groupIndex {
        case 2:
            if above == 1 {
                return "einhundert"
            } else {
                return "hundert"
            }
        case 3:
            if above == 1 {
                return "eintausend"
            } else {
                return "tausend"
            }
        case 6:
            if above == 1 {
                return "eine Million"
            } else {
                return " Millionen"
            }
        case 9:
            if above == 1 {
                return "eine Milliarde"
            } else {
                return " Milliarden"
            }
        case 12:
            if above == 1 {
                return "eine Billion"
            } else {
                return " Billionen"
            }
        default: return nil
        }
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        after_groupName = ""
        if groupIndex == 6 {
            after_groupName = " und "
        }
        if groupIndex >= 9 {
            after_groupName = " "
        }
        var ret = super.group(groupIndex, above, below: below)
        ret = ret.replacingOccurrences(of: "einstausend", with: "eintausend")
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
                    ret += word
                } else {
                    ret += word.prefix(1).uppercased() + word.dropFirst()
                }
                ret += " "
            }
            if ret.hasSuffix(" ") {
                ret = String(ret.dropLast())
            }
        }

        return ret
    }

    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "eins"
        case 2: return "zwei"
        case 3: return "drei"
        case 4: return "vier"
        case 5: return "fünf"
        case 6: return "sechs"
        case 7: return "sieben"
        case 8: return "acht"
        case 9: return "neun"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String {
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
    
    override func _11_19(_ i: Int) -> String {
        switch i {
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
