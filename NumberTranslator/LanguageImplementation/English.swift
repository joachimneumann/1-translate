//
//  English.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 25.08.24.
//

import Foundation
import SwiftUI

class EnglishImplementation: Group3Language, EnglishParameterProtocol {
    override init() {
        super.init()
        name = "English"
        code = "en"
        _20_99_connector = "-"
        use_single_hundreds = true
        use_single_group = true
        negativeString = "minus"
        afterNegative = " "
        dotString = "point"
    }
    
    @AppStorage("englishAseAndAfterHundred", store: .standard)
    var englishAseAndAfterHundred: Bool = true {
        didSet {
            after_hundreds = englishAseAndAfterHundred ? " and " : " "
        }
    }
     
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "zero"
        case 1: return "one"
        case 2: return "two"
        case 3: return "three"
        case 4: return "four"
        case 5: return "five"
        case 6: return "six"
        case 7: return "seven"
        case 8: return "eight"
        case 9: return "nine"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
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
    
    override func _11_19(_ i: UInt) -> String {
        switch i {
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

    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 2:
            return "hundred"
        case 3:
            return "thousand"
        case 6:
            return "million"
        case 9:
            return "billion"
        case 12:
            return "trillion"
        default: return nil
        }
    }
}
    
