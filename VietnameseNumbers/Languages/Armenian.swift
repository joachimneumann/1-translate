//
//  Armenian.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class Armenian: Language {
    init() {
        super.init(
            name: "հայերեն",
            negativeString: "-",
            dotString: ".",
            exponentString: "e")
        englishName = "Armenian"
        allowNegativeNumbers = false
        allowExponent = false
        allowFraction = false
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "զրո"
        case 1:     return "մեկ"
        case 2:     return "երկու"
        case 3:     return "երեք"
        case 4:     return "որս"
        case 5:     return "հինգ"
        case 6:     return "վեց"
        case 7:     return "ոթ"
        case 8:     return "ութ"
        case 9:     return "ինը"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "տասը"
        case 2:     return "քսան"
        case 3:     return "երեսուն"
        case 4:     return "քառասուն"
        case 5:     return "հիսուն"
        case 6:     return "վաթսուն"
        case 7:     return "յոթանասուն"
        case 8:     return "ութսուն"
        case 9:     return "ինիսուն"
        default: return "read_10s: outside range"
        }
    }
}

