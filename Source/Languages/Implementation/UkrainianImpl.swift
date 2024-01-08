//
//  UkrainianImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/8/24.
//

import Foundation


class UkrainianImpl: Language {
    init() {
        super.init(
            name: "українська",
            zero: "нуль",
            negativeString: "мінус",
            dotString: "кома",
            exponentString: " EE ")
        voiceLanguageCode = "ru"
        nameDescription = "Ukrainian"
        e9 = "мільярди"
        e9_one = "один мільярд"
        e12 = "трильйони"
        e12_one = "один трильйон"
        tensConnector = " "
        eSpace = " "
    }
    
    
    override func read_1_9(_ i: Int) -> String {
        switch i {
        case 1:     return "один"
        case 2:     return "два"
        case 3:     return "три"
        case 4:     return "чотири"
        case 5:     return "п'ять"
        case 6:     return "шість"
        case 7:     return "сім"
        case 8:     return "вісім"
        case 9:     return "дев'ять"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "десять"
        case 2:     return "двадцять"
        case 3:     return "тридцять"
        case 4:     return "сорок"
        case 5:     return "п'ятдесят"
        case 6:     return "шістдесят"
        case 7:     return "сімдесят"
        case 8:     return "вісімдесят"
        case 9:     return "дев'яносто"
        default: return "read_10s: outside range"
        }
    }
    
    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "одинадцять" }
        if i == 12 { return "дванадцять" }
        if i == 13 { return "тринадцять" }
        if i == 14 { return "чотирнадцять" }
        if i == 15 { return "п'ятнадцять" }
        if i == 16 { return "шістнадцять" }
        if i == 17 { return "сімнадцять" }
        if i == 18 { return "вісімнадцять" }
        if i == 19 { return "дев'ятнадцять" }
        return super.read_10_99(i)
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        switch i.E2 {
        case 1:
            ret = "сто"
        case 2:
            ret = "двісті"
        case 3:
            ret = "триста"
        case 4:
            ret = "чотириста"
        case 5:
            ret = "п'ятсот"
        case 6:
            ret = "шістсот"
        case 7:
            ret = "сімсот"
        case 8:
            ret = "вісімсот"
        case 9:
            ret = "дев'ятсот"
        default:
            fatalError("read_e2_e3 out of range")
        }
        if i.E2x > 0 {
            if ret.count > 0 { ret += " " }
            ret += read_1_(i.E2x)
        }
        return ret
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        var ret = ""
        switch i.E3 {
        case 1:
            ret = "тисяча"
        case 2:
            ret = "дві тисячі"
        case 3:
            ret = "три тисячі"
        case 4:
            ret = "чотири тисячі"
        case 5:
            ret = "п'ять тисяч"
        case 6:
            ret = "шість тисяч"
        case 7:
            ret = "сім тисяч"
        case 8:
            ret = "вісім тисяч"
        case 9:
            ret = "дев'ять тисяч"
        default:
            ret = read_1_(i.E3)
            if i.E3 == 22 { ret = "двадцять дві"}
            if i.E3 <= 20 {
                ret += " " + "тисяч"
            } else {
                if i.E3 % 10 == 0 {
                    ret += " " + "тисяч"
                } else if i.E3 % 10 == 1 {
                    ret += " " + "тисяча"
                } else if i.E3 % 10 <= 4 {
                    ret += " " + "тисячі"
                } else {
                    ret += " " + "тисяч"
                }
            }
        }
        if i.E3x > 0 {
            ret += " "
            ret += read_1_(i.E3x)
        }
        ret = ret.replacingOccurrences(of: "один ", with: "одна ")
        return ret
    }
    
    override func read_e6_e9(_ i: Int) -> String {
        var ret = super.read_1_(i.E6)
        if i.E6 == 1 {
            ret = "один мільйон"
        } else if i.E6 % 10 == 0 {
            ret += " " + "мільйонів"
        } else if i.E6 % 10 == 1 {
            ret += " " + "мільйон"
        } else if i.E6 % 10 <= 4 {
            ret += " " + "мільйони"
        } else {
            ret += " " + "мільйонів"
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
    if i.E9 > 4 { ret = ret.replacingOccurrences(of: "мільярди", with: "мільярдів")}
    if i.E9 > 1 {
        ret = ret.replacingOccurrences(of: "один ", with: "одна ")
    }
    return ret
}

override func read_e12_e15(_ i: Int) -> String {
    var ret = super.read_e12_e15(i)
    if i.E12 > 4 { ret = ret.replacingOccurrences(of: "трильйони", with: "трильйонів")}
    if i.E12 > 1 {
        ret = ret.replacingOccurrences(of: "один ", with: "одна ")
    }
    return ret
}
}
