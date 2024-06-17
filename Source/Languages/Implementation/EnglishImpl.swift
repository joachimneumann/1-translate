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
    
    private func groupName(_ groupIndex: Int) -> String {
        switch groupIndex {
        case 3:
            return "thousand"
        case 6:
            return "million"
        case 9:
            return "billion"
        case 12:
            return "trillion"
        default: return "ERROR in English Group"
        }
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret = read_positive(above) + " " + groupName(groupIndex)
        if below > 0 {
            ret += " " + read_positive(below)
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
