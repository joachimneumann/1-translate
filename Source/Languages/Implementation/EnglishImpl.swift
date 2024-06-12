//
//  English.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import SwiftUI

class EnglishImpl: NewLanguageGroup3 {
    @AppStorage("EnglishUseAndAfterHundredKey", store: .standard)
    var useAndAfterHundred: Bool = false {
        didSet {
            connector_3_2.after = useAndAfterHundred ? " and " : " "
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
        connector_2_1.after = "-"
        connector_3_2.before = " "
        connector_3_2.name = "hundred"
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
//        E1.after = "-"
//        E2.before = " "
//        E2.name = "hundred"
//        E2.after = " "
//        E3.name = "thousand"
//        E6.name = "million"
//        E9.name = "billion"
//        E12.name = "trillion"
//        useAndAfterHundred = useAndAfterHundred
    }
    
    override func override(_ i: Int) -> String? {
        switch i {
        case 1:     return "one"
        case 2:     return "two"
        case 3:     return "three"
        case 4:     return "four"
        case 5:     return "five"
        case 6:     return "six"
        case 7:     return "seven"
        case 8:     return "eight"
        case 9:     return "nine"
        case 10:     return "ten"
        case 20:     return "twenty"
        case 30:     return "thirty"
        case 40:     return "forty"
        case 50:     return "fifty"
        case 60:     return "sixty"
        case 70:     return "seventy"
        case 80:     return "eighty"
        case 90:     return "ninety"
        case 11:     return "eleven"
        case 12:     return "twelve"
        case 13:     return "thirteen"
        case 14:     return "fourteen"
        case 15:     return "fifteen"
        case 16:     return "sixteen"
        case 17:     return "seventeen"
        case 18:     return "eighteen"
        case 19:     return "nineteen"
        default:
            return nil
        }
    }
}
