//
//  English.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import SwiftUI

class EnglishImpl: LanguageGroup3 {
    @AppStorage("EnglishUseAndAfterHundredKey", store: .standard)
    var useAndAfterHundred: Bool = false {
        didSet {
            _100_999_connector.after = useAndAfterHundred ? " and " : " "
        }
    }
    
    init() {
        super.init(
            name: "English",
            zero: "zero",
            negativeString: "minus",
            dotString: "point",
            exponentString: " times ten to the power of ")
        voiceLanguageCode = "en"
        _10_99_connector.name = "-"
        _100_999_connector.before = " "
        _100_999_connector.name = "hundred"
        //connector_3_2.after set by AppStorage
        connector_4_3.before = " "
        connector_4_3.name = "thousand"
        connector_4_3.after = " "
        connector_7_6.before = " "
        connector_7_6.name = "million"
        connector_7_6.after = " "
        connector_10_9.before = " "
        connector_10_9.name = "billion"
        connector_10_9.after = " "
        connector_13_12.before = " "
        connector_13_12.name = "trillion"
        connector_13_12.after = " "
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
    
    override func _10s(_ i: Int) -> String? {
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
    
    override func _10_19(_ i: Int) -> String? {
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
