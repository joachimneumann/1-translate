//
//  RussianImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/1/24.
//

import Foundation

class RussianImpl: Language {
    init() {
        super.init(
            name: "Русский",
            negativeString: "минус",
            dotString: "целых",
            exponentString: " EE ")
        voiceLanguageCode = "ru"
        voiceLanguageName = "Russian"
        nameDescription = "Russian"
        e2 = "стo"
        e2_one = e2
        e3 = "тысяча"
        e3_one = e3
        e6 = "миллиона"
        e6_one = "один миллион"
        e9 = "миллиарда"
        e9_one = "один миллиард"
        e12 = "триллиона"
        e12_one = "один триллион"
        tensConnector = " "
        eSpace = " "
    }
    
    
    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0:     return "ноль"
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
            ret = readInteger(i.E3)
            if i.E3 == 22 { ret = "двадцать две"}
            if i.E3 <= 20 {
                ret += " " + "тысяч"
            } else {
                if i.E3 % 10 == 0 {
                    ret += " " + "тысяч"
                } else if i.E3 % 10 == 1 {
                    ret += " " + "тысяча"
                } else if i.E3 % 10 <= 4 {
                    ret += " " + "тысячи"
                } else {
                    ret += " " + "тысяч"
                }
            }
        }
        if i.E3x > 0 {
            ret += " "
            ret += readInteger(i.E3x)
        }
        ret = ret.replacingOccurrences(of: "один ", with: "одна ")
        return ret
    }
    
    override func read_e6_e9(_ i: Int) -> String {
        var ret = super.readInteger(i.E6)
        if i.E6 == 1 {
            ret = "один миллион"
        } else if i.E6 % 10 == 0 {
            ret += " " + "миллионов"
        } else if i.E6 % 10 == 1 {
            ret += " " + "миллион"
        } else if i.E6 % 10 <= 4 {
            ret += " " + "миллиона"
        } else {
            ret += " " + "миллионов"
        }
        if i.E6x > 0 {
            let leftover = read(i.E6x)
            ret += " " + leftover
        }
    //        if i.E6 % 10 == 1 {
    //            ret = ret.replacingOccurrences(of: "миллиона", with: "миллион")
    //        } else if i.E6 % 10 > 4 { ret = ret.replacingOccurrences(of: "миллиона", with: "миллионов") }
    return ret
}

override func read_e9_e12(_ i: Int) -> String {
    var ret = super.read_e9_e12(i)
    if i.E9 > 4 { ret = ret.replacingOccurrences(of: "миллиарда", with: "миллиардов")}
    if i.E9 > 1 {
        ret = ret.replacingOccurrences(of: "один ", with: "одна ")
    }
    return ret
}

override func read_e12_e15(_ i: Int) -> String {
    var ret = super.read_e12_e15(i)
    if i.E12 > 4 { ret = ret.replacingOccurrences(of: "триллиона", with: "триллионов")}
    if i.E12 > 1 {
        ret = ret.replacingOccurrences(of: "один ", with: "одна ")
    }
    return ret
}
}
