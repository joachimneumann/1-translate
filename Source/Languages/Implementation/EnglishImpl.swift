//
//  English.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class EnglishImpl: LanguageImpl, English {
    var useAndAfterHundred: Bool = false {
        didSet {
            afterHundred = useAndAfterHundred ? " and" : ""
        }
    }
    
    init() {
        super.init(
            name: "English",
            negativeString: "minus",
            dotString: "point",
            exponentString: " times ten to the power of ",
            code: "en")
        e2 = "hundred"
        e3 = "thousand"
        e6 = "million"
        e9 = "billion"
        e12 = "trillion"
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
        default: return "read_0_9: outside range"
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
        default: return "read_10s outside range"
        }
    }
    
    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "eleven" }
        if i == 12 { return "twelve" }
        if i == 13 { return "thirteen" }
        if i == 14 { return "fourteen" }
        if i == 15 { return "fifteen" }
        if i == 16 { return "sixteen" }
        if i == 17 { return "seventeen" }
        if i == 18 { return "eighteen" }
        if i == 19 { return "nineteen" }
        return super.read_10_99(i)
    }
}
