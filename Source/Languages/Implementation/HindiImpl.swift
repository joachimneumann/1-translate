//
//  HindiImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/5/24.
//

import Foundation

class HindiImpl: LanguageImpl {
    
    init() {
        super.init(
            name: "हिंदी",
            groupSize: GroupSize.four,
            zero: "शून्य",
            negativeString: "शून्य से",
            dotString: "बिंदु",
            exponentString: " EE ")
        nameDescription = "Hindi"
        voiceLanguageCode = "hi"
    }
    
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 1:     return "एक"
        case 2:     return "दो"
        case 3:     return "तीन"
        case 4:     return "चार"
        case 5:     return "पांच"
        case 6:     return "छः"
        case 7:     return "सात"
        case 8:     return "आठ"
        case 9:     return "नौ"
        default: return "read_0_9: outside range"
        }
    }
    
    func read_10_99(_ i: Int) -> String {
        switch i {
        case 10: return "दश"
        case 11: return "ग्यारह"
        case 12: return "बारह"
        case 13: return "तेरह"
        case 14: return "चौदह"
        case 15: return "पंद्रह"
        case 16: return "सोलह"
        case 17: return "सत्रह"
        case 18: return "अट्ठारह"
        case 19: return "उन्नीस"
        case 20: return "बीस"
        case 21: return "इक्कीस"
        case 22: return "बाईस"
        case 23: return "तेईस"
        case 24: return "चौबिस"
        case 25: return "पच्चीस"
        case 26: return "छब्बीस"
        case 27: return "सत्ताईस"
        case 28: return "अट्ठाईस"
        case 29: return "उनतीस"
        case 30: return "तीस"
        case 31: return "इकतीस"
        case 32: return "बत्तीस"
        case 33: return "तैंतीस"
        case 34: return "चौंतीस"
        case 35: return "पैंतीस"
        case 36: return "छत्तीस"
        case 37: return "सैंतीस"
        case 38: return "अड़तीस"
        case 39: return "उनतालीस"
        case 40: return "चालीस"
        case 41: return "इकतालीस"
        case 42: return "बयालीस"
        case 43: return "तैंतालीस"
        case 44: return "चौंतालीस"
        case 45: return "पैंतालीस"
        case 46: return "छियालीस"
        case 47: return "सैंतालीस"
        case 48: return "अड़तालीस"
        case 49: return "उनचास"
        case 50: return "पचास"
        case 51: return "इक्यावन"
        case 52: return "बावन"
        case 53: return "तिरपन"
        case 54: return "चौवन"
        case 55: return "पचपन"
        case 56: return "छप्पन"
        case 57: return "सत्तावन"
        case 58: return "अट्ठावन"
        case 59: return "उनसठ"
        case 60: return "साठ"
        case 61: return "इकसठ"
        case 62: return "बासठ"
        case 63: return "तिरसठ"
        case 64: return "चौंसठ"
        case 65: return "पैंसठ"
        case 66: return "छयासठ"
        case 67: return "सड़सठ"
        case 68: return "अड़सठ"
        case 69: return "उनहत्तर"
        case 70: return "सत्तर"
        case 71: return "इकहत्तर"
        case 72: return "बहत्तर"
        case 73: return "तिहत्तर"
        case 74: return "चौहत्तर"
        case 75: return "पचहत्तर"
        case 76: return "छिहत्तर"
        case 77: return "सतहत्तर"
        case 78: return "अठहत्तर"
        case 79: return "उनासी"
        case 80: return "अस्सी"
        case 81: return "इक्यासी"
        case 82: return "बयासी"
        case 83: return "तिरासी"
        case 84: return "चौरासी"
        case 85: return "पचासी"
        case 86: return "छियासी"
        case 87: return "सत्तासी"
        case 88: return "अठासी"
        case 89: return "नवासी"
        case 90: return "नब्बे"
        case 91: return "इक्यानवे"
        case 92: return "बानवे"
        case 93: return "तिरानवे"
        case 94: return "चौरानवे"
        case 95: return "पचानवे"
        case 96: return "छियानवे"
        case 97: return "सत्तानवे"
        case 98: return "अट्ठानवे"
        case 99: return "निन्यानवे"
        default: return "read_10_99: outside range"
        }
    }
    
    override func read_positive(_ i: Int) -> String {
        if i < 10 { return _0_9(i) }
        if i < 100 { return read_10_99(i) }
        if i < 1000 {
            var ret = ""
            ret = _0_9(i.E2) + " " + "सौ"
            if i.E2x > 0 {
                ret += " " + read(i.E2x)
            }
            return ret
        }
        if i < 100_000 {
            var ret = ""
            ret = read(i.E3) + " " + "हज़ार"
            if i.E3x > 0 {
                ret += " " + read(i.E3x)
            }
            return ret
        }
        if i < 100*100_000 {
            var ret = ""
            ret = read(i.E5) + " " + "लाख" // lakh
            if i.E5x > 0 {
                ret += " " + read(i.E5x)
            }
            return ret
        }
        if i < 100*100*100_000 {
            var ret = ""
            ret = read(i.E7) + " " + "करोड़" // crore
            if i.E7x > 0 {
                ret += " " + read(i.E7x)
            }
            return ret
        }
        if i < 100*100*100*100_000 {
            var ret = ""
            ret = read(i.E9) + " " + "अरब" // arab
            if i.E9x > 0 {
                ret += " " + read(i.E9x)
            }
            return ret
        }
        if i < 100*100*100*100*100_000 {
            var ret = ""
            ret = read(i.E11) + " " + "खरब" // kharab
            if i.E11x > 0 {
                ret += " " + read(i.E11x)
            }
            return ret
        }
        if i < 100*100*100*100*100*100_000 {
            var ret = ""
            ret = read(i.E13) + " " + "नील" // nil
            if i.E13x > 0 {
                ret += " " + read(i.E13x)
            }
            return ret
        }
        return "?"
    }
}

extension Int {
    var E1: Int { self / 10 }
    var E1x: Int { self - self / 10 * 10 } // self % 10?
    var E2: Int { self / 100 }
    var E2x: Int { self - self / 100 * 100 }
    var E3: Int { self / 1_000 }
    var E3x: Int { self - self / 1_000 * 1_000}
    var E4: Int { self / 10_000 }
    var E4x: Int { self - self / 10_000 * 10_000 }
    var E5: Int { self / 100_000 }
    var E5x: Int { self - self / 100_000 * 100_000 }
    var E6: Int { self / 1_000_000 }
    var E6x: Int { self - self / 1_000_000 * 1_000_000 }
    var E7: Int { self / 10_000_000 }
    var E7x: Int { self - self / 10_000_000 * 10_000_000 }
    var E8: Int { self / 100_000_000 }
    var E8x: Int { self - self / 100_000_000 * 100_000_000 }
    var E9: Int { self / 1_000_000_000 }
    var E9x: Int { self - self / 1_000_000_000 * 1_000_000_000 }
    var E11: Int { self / 100_000_000_000 }
    var E11x: Int { self - self / 100_000_000_000 * 100_000_000_000 }
    var E12: Int { self / 1_000_000_000_000 }
    var E12x: Int { self - self / 1_000_000_000_000 * 1_000_000_000_000 }
    var E13: Int { self / 10_000_000_000_000 }
    var E13x: Int { self - self / 10_000_000_000_000 * 10_000_000_000_000 }
}
