//
//  RussianImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/1/24.
//

import Foundation

class RussianImpl: LanguageImpl {
    init() {
        super.init(
            name: "русский",
            negativeString: "минус",
            dotString: "целых",
            exponentString: "e")
        voiceLanguageCode = "ru"
        voiceLanguageName = "Russian"
        nameDescription = "Russian"
        e2 = "стo"
        e2_one = e2
        e3 = "тысяча"
        e3_one = e3
        e6 = "миллион"
        e6_one = e6
        e9 = "миллиард"
        e9_one = e9
        e12 = "триллион"
        e12_one = e12
        tensConnector = " "
        eSpace = " "
//        afterHundred = " "
//        beforeHundred = " "
        beforeAndAfterDotString = " "
    }
    
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "нуль"
        case 1:     return "один"
        case 2:     return "два"
        case 3:     return "три"
        case 4:     return "четыре"
        case 5:     return "пять"
        case 6:     return "шесть"
        case 7:     return "семь"
        case 8:     return "восемь"
        case 9:     return "девять"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "десять"
        case 2:     return "двадцать"
        case 3:     return "тридцать"
        case 4:     return "сорок"
        case 5:     return "пятьдесят"
        case 6:     return "шестьдесят"
        case 7:     return "семьдесят"
        case 8:     return "восемьдесят"
        case 9:     return "девяносто"
        default: return "read_10s: outside range"
        }
    }
    
    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "одиннадцать" }
        if i == 12 { return "двенадцать" }
        if i == 13 { return "тринадцать" }
        if i == 14 { return "четырнадцать" }
        if i == 15 { return "пятнадцать" }
        if i == 16 { return "шестнадцать" }
        if i == 17 { return "семнадцать" }
        if i == 18 { return "восемнадцать" }
        if i == 19 { return "девятнадцать" }
        return super.read_10_99(i)
    }
}
