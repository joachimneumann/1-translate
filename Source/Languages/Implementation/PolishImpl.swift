//
//  Polish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class PolishImpl: LanguageGroup3 {
    init() {
        super.init(
            name: "Polski",
            zero: "zero",
            negativeString: "minus",
            dotString: "przecinek",
            exponentString: " razy dziesięć do potęgi ")
        
        voiceLanguageCode = "pl"
        _11_99_connector = " "
    }
    
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "jeden"
        case 2:  return "dwa"
        case 3:  return "trzy"
        case 4:  return "cztery"
        case 5:  return "pięć"
        case 6:  return "sześć"
        case 7:  return "siedem"
        case 8:  return "osiem"
        case 9:  return "dziewięć" //dziewipoęć" 
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1: return "dziesięć"
        case 2: return "dwadzieścia"
        case 3: return "trzydzieści"
        case 4: return "czterdzieści"
        case 5: return "pięćdziesiąt"
        case 6: return "sześćdziesiąt"
        case 7: return "siedemdziesiąt"
        case 8: return "osiemdziesiąt"
        case 9: return "dziewięćdziesiąt"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }
    
    override func _10_19(_ i: Int) -> String {
        switch i {
        case 10: return _10s(1)
        case 11: return "jedenaście"
        case 12: return "dwanaście"
        case 13: return "trzynaście"
        case 14: return "czternaście"
        case 15: return "piętnaście"
        case 16: return "szesnaście"
        case 17: return "siedemnaście"
        case 18: return "osiemnaście"
        case 19: return "dziewiętnaście"
        default:
            fatalError("_11_19() parameter \(i)")
        }
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = ""
        switch hundreds {
        case 1:
            ret = "sto"
        case 2:
            ret = "dwieście"
        case 3, 4:
            ret = read_positive(hundreds) + "sta"
        default:
            ret = read_positive(hundreds) + "set"
        }

        if below > 0 {
            ret += " " + read_positive(below)
        }
        return ret
    }
    
    private func use(_ i: Int, _ s1: String, _ s2: String) -> String {
        var use1 = false
        switch i % 10 {
        case 2, 3, 4:
            use1 = true
        default:
            use1 = false
        }
        switch i % 100 {
        case 11, 12, 13, 14:
            use1 = false
        default:
            break
        }
        return use1 ? s1 : s2
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret = ""
        switch groupIndex {
        case 3: 
            if above == 1 {
                ret = "tysiąc"
            } else {
                ret = read_positive(above) + " " + use(above, "tysiące", "tysięcy")
            }
        case 6:
            if above == 1 {
                ret = read_positive(above) + " " + "milion"
            } else {
                ret = read_positive(above) + " " + use(above, "miliony", "milionów")
            }
        case 9:
            if above == 1 {
                ret = read_positive(above) + " " + "miliard"
            } else {
                ret = read_positive(above) + " " + use(above, "miliardy", "miliardów")
            }
        case 12:
            if above == 1 {
                ret = read_positive(above) + " " + "bilion"
            } else {
                ret = read_positive(above) + " " + use(above, "biliony", "bilionów")
            }
        default:
            fatalError("wrong groupindex \(groupIndex)")
        }
        if below > 0 {
            switch groupIndex {
            case 3:
                ret += " " + read_positive(below)
            case 6:
                if below.E3 > 0 {
                    ret += " " + group(3, below.E3, below: below.E3x)
                } else {
                    ret += " " + read_positive(below)
                }
            case 9:
                if below.E6 > 0 {
                    ret += " " + group(6, below.E6, below: below.E6x)
                } else if below.E3 > 0 {
                    ret += " " + group(3, below.E3, below: below.E3x)
                } else {
                    ret += " " + read_positive(below)
                }
            default:
                fatalError("wrong groupindex \(groupIndex)")
            }
        }
        return ret
    }
    
//
//    override func read_e2_e3(_ i: Int) -> String {
//        var ret = ""
//        switch i.E2 {
//        case 1:
//            ret = "sto"
//        case 2:
//            ret = "dwieście"
//        case 3, 4:
//            ret = read_1_9(i.E2) + "sta"
//        default:
//            ret = read_1_9(i.E2) + "set"
//        }
//        if i.E2x > 0 {
//            if ret.count > 0 { ret += " " }
//            ret += read_1_(i.E2x)
//        }
//        return ret
//    }
//    
//    private func use(_ i: Int, _ s1: String, _ s2: String) -> String {
//        var use1 = false
//        switch i % 10 {
//        case 2, 3, 4:
//            use1 = true
//        default:
//            use1 = false
//        }
//        switch i % 100 {
//        case 11, 12, 13, 14:
//            use1 = false
//        default:
//            break
//        }
//        return use1 ? s1 : s2
//    }
//    
//    override func read_e3_e6(_ i: Int) -> String {
//        var ret = read_1_(i.E3) + " " + use(i.E3, "tysiące", "tysięcy")
//        if i.E3 == 1 { ret = "tysiąc" }
//        if i.E3x > 0 { ret += " " + read_1_(i.E3x) }
//        return ret
//    }
//    
//    override func read_e6_e9(_ i: Int) -> String {
//        var ret = read_1_(i.E6) + " " + use(i.E6, "miliony", "milionów")
//        if i.E6 == 1 { ret = "jeden milion" }
//        if i.E6x > 0 { ret += " " + read_1_(i.E6x) }
//        return ret
//    }
//    
//    override func read_e9_e12(_ i: Int) -> String {
//        var ret = read_1_(i.E9) + " " + use(i.E9, "miliardy", "miliardów")
//        if i.E9 == 1 { ret = "jeden miliard" }
//        if i.E9x > 0 { ret += " " + read_1_(i.E9x) }
//        return ret
//    }
//    
//    override func read_e12_e15(_ i: Int) -> String {
//        var ret = read_1_(i.E12) + " " + use(i.E12, "biliony", "bilionów")
//        if i.E12 == 1 { ret = "jeden bilion" }
//        if i.E12x > 0 { ret += " " + read_1_(i.E12x) }
//        return ret
//    }
}
