//
//  Digits.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class Digits: TenBasedLanguage {
    var negativeString = "-"
    var dotString = "."
    var exponentString = "e"
    var name: String = "Digits"
    
    override init() {
        super.init()
        afterNegative = ""
    }
    
    func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "0"
        case 1:     return "1"
        case 2:     return "2"
        case 3:     return "3"
        case 4:     return "4"
        case 5:     return "5"
        case 6:     return "6"
        case 7:     return "7"
        case 8:     return "8"
        case 9:     return "9"
        default: return " translate_0_10: outside range "
        }
    }
}
