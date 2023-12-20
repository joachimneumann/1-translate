//
//  English.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class English: TenBasedLanguage {
    init() {
        super.init(
            name: "English",
            negativeString: "minus",
            dotString: "point",
            exponentString: " times ten to the power of ",
            groupSeparator: "",
            decimalSeparator: ".")

        _11 = "eleven"
        _12 = "twelve"
        _13 = "thirteen"
        _14 = "fourteen"
        _15 = "fifteen"
        _16 = "sixteen"
        _17 = "seventeen"
        _18 = "eighteen"
        _19 = "nineteen"

        e2 = "hundred"
        e3 = "thousand"
        e6 = "million"
        e9 = "billion"
        afterNegative = " "
        beforeAndAfterDotString = " "
        tensConnector = "-"
        eSpace = " "
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "zero"
        case 1:     return "one"
        case 2:     return "two"
        case 3:     return "three"
        case 4:     return "four"
        case 5:     return "five"
        case 6:     return "six"
        case 7:     return "seven"
        case 8:     return "eight"
        case 9:     return "nine"
        default: return " translate_0_10: outside range "
        }
    }
    
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "ten"
        case 2:     return "twenty"
        case 3:     return "thirty"
        case 4:     return "forty"
        case 5:     return "fifty"
        case 6:     return "sixty"
        case 7:     return "seventy"
        case 8:     return "eighty"
        case 9:     return "ninety"
        default: return " 10s outside range "
        }
    }
}
