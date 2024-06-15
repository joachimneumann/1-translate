//
//  English.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import SwiftUI

class EnglishImpl: LanguageGroup3 {
    @AppStorage("EnglishUseAndAfterHundredKey", store: .standard)
    var useAndAfterHundred: Bool = false
    
    init() {
        super.init(
            name: "English",
            zero: "zero",
            negativeString: "minus",
            dotString: "point",
            exponentString: " times ten to the power of ")
        voiceLanguageCode = "en"
        _20_99_connector = "-"
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = read_positive(hundreds) + " hundred"
        if below > 0 {
            ret += (useAndAfterHundred ? " and " : " ") + read_positive(below)
        }
        return ret
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        let name: String
        switch groupIndex {
        case 3: name = "thousand"
        case 6: name = "million"
        case 9: name = "billion"
        case 12: name = "trillion"
        default:
            fatalError("wrong groupindex \(groupIndex)")
        }
        var ret = read_positive(above) + " " + name
        if below > 0 {
            switch groupIndex {
            case 3:
                ret += " " + read_positive(below)
            case 6:
                if below.E3 > 0 {
                    ret += " " + group(3, below.E3, below: below.E3x)
                } else {
                    ret += " " + read_positive(below)
                }
            case 9:
                if below.E6 > 0 {
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else if below.E3 > 0 {
                    ret += " " + group(3, below.E3, below: below.E3x)
                } else {
                    ret += " " + read_positive(below)
                }
            case 12:
                if below.E9 > 0 {
                    ret += " " + group(9, below.E9, below: below.E9x)
                } else if below.E6 > 0 {
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else if below.E3 > 0 {
                    ret += " " + group(3, below.E3, below: below.E3x)
                } else {
                    ret += " " + read_positive(below)
                }
            default:
                fatalError("wrong groupindex \(groupIndex)")
            }
        }
        return ret
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "one"
        case 2:  return "two"
        case 3:  return "three"
        case 4:  return "four"
        case 5:  return "five"
        case 6:  return "six"
        case 7:  return "seven"
        case 8:  return "eight"
        case 9:  return "nine"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1: return "ten"
        case 2: return "twenty"
        case 3: return "thirty"
        case 4: return "forty"
        case 5: return "fifty"
        case 6: return "sixty"
        case 7: return "seventy"
        case 8: return "eighty"
        case 9: return "ninety"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }
    
    override func _10_19(_ i: Int) -> String {
        switch i {
        case 10: return _10s(1)
        case 11: return "eleven"
        case 12: return "twelve"
        case 13: return "thirteen"
        case 14: return "fourteen"
        case 15: return "fifteen"
        case 16: return "sixteen"
        case 17: return "seventeen"
        case 18: return "eighteen"
        case 19: return "nineteen"
        default:
            fatalError("_11_19() parameter \(i)")
        }
    }


    
}
