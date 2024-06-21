//
//  RussianImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/1/24.
//

import Foundation

class RussianImpl: LanguageImplGroup3 {
    init() {
        super.init(
            name: "Русский",
            groupSize: GroupSize.three,
            zero: "ноль",
            negativeString: "минус",
            dotString: "целых",
            exponentString: " EE ")
        voiceLanguageCode = "ru"
        nameDescription = "Russian"
        before_hundreds = ""
        after_hundreds = " "
        _20_99_connector = " "
    }
    
    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
        switch groupIndex {
        case 2:
            if above == 1 {
                return "стo"
            } else {
                return "сти"
            }
        case 3:
            if above % 10 == 1 && (above < 10 || above > 20)  {
                return "тысяча"
            } else if (above % 10 >= 1 && above % 10 <= 4) && (above < 10 || above > 20) {
                return "тысячи"
            } else {
                return "тысяч"
            }
        case 6:
            if above % 10 == 1 && (above < 10 || above > 20)  {
                return "миллион"
            } else if (above % 10 >= 1 && above % 10 <= 4) && (above < 10 || above > 20) {
                return "миллиона"
            } else {
                return "миллионов"
            }
        case 9:
            if above % 10 == 1 && (above < 10 || above > 20)  {
                return "миллиард"
            } else if (above % 10 >= 1 && above % 10 <= 4) && (above < 10 || above > 20) {
                return "миллиарда"
            } else {
                return "миллиардов"
            }
        case 12:
            if above % 10 == 1 && (above < 10 || above > 20)  {
                return "триллион"
            } else if (above % 10 >= 1 && above % 10 <= 4) && (above < 10 || above > 20) {
                return "триллиона"
            } else {
                return "триллионов"
            }
        default: return nil
        }
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = ""
        switch hundreds {
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
            fatalError("_100_999() out of range")
        }
        if below > 0 {
            if ret.count > 0 { ret += " " }
            ret += read_positive(below)
        }
        return ret
    }

    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "один"
        case 2: return "два"
        case 3: return "три"
        case 4: return "четыре"
        case 5: return "пять"
        case 6: return "шесть"
        case 7: return "семь"
        case 8: return "восемь"
        case 9: return "девять"
        default: return "read_0_9: outside range"
        }
    }
    
    override func _10s(_ i: Int) -> String {
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
    
    override func _11_19(_ i: Int) -> String {
        switch i {
        case 11: return "одиннадцать"
        case 12: return "двенадцать"
        case 13: return "тринадцать"
        case 14: return "четырнадцать"
        case 15: return "пятнадцать"
        case 16: return "шестнадцать"
        case 17: return "семнадцать"
        case 18: return "восемнадцать"
        case 19: return "девятнадцать"
        default:
            fatalError("_11_19() parameter \(i)")
        }
    }

    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        if groupIndex == 3 {
            use_single_group = false
        } else {
            use_single_group = true
        }
        var ret = super.group(groupIndex, above, below: below)
        ret = ret.replacingOccurrences(of: "два тыся", with: "две тыся")
        if groupIndex == 3 {
            ret = ret.replacingOccurrences(of: "один тыся", with: "одна тыся")
        }
        return ret
    }

}
