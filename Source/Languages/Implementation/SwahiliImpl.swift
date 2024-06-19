//
//  SwahiliImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/2/24.
//

import SwiftUI

class SwahiliImpl: LanguageGroup3 {
    init() {
        super.init(
            name: "Swahili",
            zero: "sifuri",
            negativeString: "menos",
            dotString: "kaj",
            exponentString: " EE ")
        _20_99_connector = " na "
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "moja"
        case 2: return "mbili"
        case 3: return "tatu"
        case 4: return "nne"
        case 5: return "tano"
        case 6: return "sita"
        case 7: return "saba"
        case 8: return "nane"
        case 9: return "tisa"
        default: return "read_0_9: outside range"
        }
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1: return "kumi"
        case 2: return "ishirini"
        case 3: return "thelathini"
        case 4: return "arobaini"
        case 5: return "hamsini"
        case 6: return "sitini"
        case 7: return "sabini"
        case 8: return "themanini"
        case 9: return "tisini"
        default: return "read_10s: outside range"
        }
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = "mia " + _0_9(hundreds)
        if below > 0 {
            ret += " na "
            ret += read_positive(below)
        }
        return ret
    }

    override func groupName(_ groupIndex: Int, _ above: Int) -> String {
        switch groupIndex {
        case 3:
            return "elfu"
        case 6:
            return "milioni"
        case 9:
            return "bilioni"
        case 12:
            return "trilioni"
        default: return "ERROR in English Group"
        }
    }
    
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = groupName(groupIndex, above) + before_groupName + read_positive(above)

        if groupIndex == 3 && above >= 100 {
            ret = "laki " + read_positive(above / 100)
            let below = (above - above / 100 * 100) * 1000 + below
            if below > 0 {
                ret += ", " + read_positive(below)
            }
            return ret
        }
        if below > 0 {
            ret += below <= 9 ? " na " : ", "
            ret += read_positive(below)
        }
        return ret
    }
    
//    override func read_e2_e3(_ i: Int) -> String {
//        var ret = "mia " + read_1_9(i.E2)
//        if i.E2x > 0 {
//            var leftover = read(i.E2x)
//            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
//            ret += ", " + leftover
//        }
//        return ret
//    }
//    
//    override func read_e3_e6(_ i: Int) -> String {
//        var ret = ""
//        if i.E3 >= 100 {
//            ret = "laki " + read(i.E5)
//            if i.E5x > 0 {
//                var leftover = read(i.E5x)
//                if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
//                ret += ", " + leftover
//            }
//        } else {
//            ret = "elfu " + read(i.E3)
//            if i.E3x > 0 {
//                var leftover = read(i.E3x)
//                if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
//                ret += ", " + leftover
//            }
//        }
//        return ret
//    }
//    
//    override func read_e6_e9(_ i: Int) -> String {
//        var ret = ""
//        ret = "milioni " + read(i.E6)
//        if i.E6x > 0 {
//            var leftover = read(i.E6x)
//            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
//            ret += ", " + leftover
//        }
//        return ret
//    }
//    
//    override func read_e9_e12(_ i: Int) -> String {
//        var ret = ""
//        ret = "bilioni " + read(i.E9)
//        if i.E9x > 0 {
//            var leftover = read(i.E9x)
//            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
//            ret += ", " + leftover
//        }
//        return ret
//    }
//
//    override func read_e12_e15(_ i: Int) -> String {
//        var ret = ""
//        ret = "trilioni " + read(i.E12)
//        if i.E12x > 0 {
//            var leftover = read(i.E12x)
//            if leftover.split(separator: " ").count == 1 { leftover = "na " + leftover }
//            ret += ", " + leftover
//        }
//        return ret
//    }

}
