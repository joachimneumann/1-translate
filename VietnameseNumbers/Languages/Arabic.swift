//
//  Arabic.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class Arabic: Language {
    init() {
        super.init(
            name: "Català",
            negativeString: "menys",
            dotString: "coma",
            exponentString: " por diez elevat a ")
        englishName = "Arabic"
        e1_one = "عَشَرَة"
        //        e2 = "cent"
        //        e2_one = "cent"
        //        e3 = "mil"
        //        e3_one = "mil"
        //        e6_one = "un milió"
        //        e6 = "milions"
        //        e9_one = "mil milions"
        //        e9 = "mil milions"
        //        e12_one = "un bilió"
        //        e12 = "bilions"
        //        afterNegative = " "
        //        beforeAndAfterDotString = " "
        //        tensConnector = "-"
        //        beforeHundred = "-"
        //        e3Space = " "
        //        e69Space = " "
    }
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "صفر"
        case 1:     return "وَاحِد"
        case 2:     return "اِثْنَان"
        case 3:     return "ثَلَاثَة"
        case 4:     return "أَرْبَعَة"
        case 5:     return "خَمْسَة"
        case 6:     return "سِتَّة"
        case 7:     return "سَبْعَة"
        case 8:     return "ثَمَانِيَة"
        case 9:     return "تِسْعَة"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "عَشَرَ"
        case 2:     return "vint"
        case 3:     return "trenta"
        case 4:     return "quaranta"
        case 5:     return "cinquanta"
        case 6:     return "seixanta"
        case 7:     return "setanta"
        case 8:     return "vuitanta"
        case 9:     return "noranta"
        default: return "read_10s: outside range"
        }
    }
}
