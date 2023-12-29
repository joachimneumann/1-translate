//
//  Armenian.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class ArmenianImpl: LanguageImpl {
    init() {
        super.init(
            name: "հայերեն",
            negativeString: "մինուս",
            dotString: "կետ",
            exponentString: "e",
            code: "hy")
        englishName = "Armenian"
        e2 = "հարյուր"
        e2_one = e2
        e3 = "հազար"
        e3_one = e3
        e6 = "միլիոն"
        e6_one = e6
        e9 = "միլիարդ"
        e9_one = e9
        e12 = "տրիլիոն"
        e12_one = e12
        eSpace = " "
        beforeAndAfterDotString = " "
    }

    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "զրո"
        case 1:     return "մեկ"
        case 2:     return "երկու"
        case 3:     return "երեք"
        case 4:     return "չորս"
        case 5:     return "հինգ"
        case 6:     return "վեց"
        case 7:     return "յոթ"
        case 8:     return "ութ"
        case 9:     return "ինը"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "տասն"
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
    
    override func read_10_99(_ i: Int) -> String {
        switch i {
        case 10: return "տասը"
        default: return super.read_10_99(i)
        }
    }
}

