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
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        switch i.E2 {
        case 1:
            ret = "стo"
        case 2:
            ret = "двести"
        case 3:
            ret = "триста"
        case 4:
            ret = "четыреста"
        case 5:
            ret = "пятьсот"
        case 6:
            ret = "шестьсот"
        case 7:
            ret = "семьсот"
        case 8:
            ret = "восемьсот"
        case 9:
            ret = "девятьсот"
        default:
            fatalError("read_e2_e3 out of range")
        }
        if i.E2x > 0 {
            if ret.count > 0 { ret += " " }
            ret += readInteger(i.E2x)
        }
        return ret
    }

    override func read_e3_e6(_ i: Int) -> String {
        var ret = ""
        switch i.E3 {
        case 1:
            ret = "тысяча"
        case 2:
            ret = "две тысячи"
        case 3:
            ret = "три тысячи"
        case 4:
            ret = "четыре тысячи"
        case 5:
            ret = "пять тысяч"
        case 6:
            ret = "шесть тысяч"
        case 7:
            ret = "семь тысяч"
        case 8:
            ret = "восемь тысяч"
        case 9:
            ret = "девять тысяч"
        default:
            ret = readInteger(i.E3) + " " + "тысяч"
        }
        if i.E3x > 0 {
            ret += " "
            ret += readInteger(i.E3x)
        }
        return ret
    }
}
