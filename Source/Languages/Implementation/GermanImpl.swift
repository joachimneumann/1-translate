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
        
        _11_99_connector = Languages.WordSplitter + "und"
        _11_99_inverted = true

        afterNegative = " "
        postProcessing = germanPostProcessing
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret: String
        if hundreds == 1 {
            ret = "einhundert"
        } else {
            ret = _0_999(hundreds) + "hundert"
        }
        if below > 0 {
            ret += _0_999(below)
        }
        return ret
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = ""
        switch groupIndex {
        case 3:
            ret = _0_999(above) + "tausend"
            if above % 10 == 1 { // also handle 201_000, etc
                ret = ret.replacingOccurrences(of: "einstausend", with: "eintausend")
            }
            if below > 0 {
                ret += _0_999(below)
            }
        case 6:
            if above == 1 {
                ret = "eine Million"
            } else {
                ret = _0_999(above) + " Millionen"
            }
            if below > 0 {
                if below.E3 > 0 {
                    ret += " und " + group(3, below.E3, below: below.E3x)
                } else {
                    ret += " " + _0_999(below)
                }
            }
        case 9:
            if above == 1 {
                ret = "eine Milliarde"
            } else {
                ret = _0_999(above) + " Milliarden"
            }
            if below > 0 {
                if below.E6 > 0 {
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else {
                    ret += " " + _0_999(below)
                }
            }
        case 12:
            if above == 1 {
                ret = "eine Billion"
            } else {
                ret = _0_999(above) + " Billionen"
            }
            if below > 0 {
                if below.E9 > 0 {
                    ret += " " + group(9, below.E9, below: below.E9x)
                } else if below.E6 > 0 {
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else {
                    ret += " " + _0_999(below)
                }
            }
        default:
            fatalError("wrong groupindex \(groupIndex)")
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
