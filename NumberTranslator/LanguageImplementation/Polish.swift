//
//  Polish.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class PolishImplementation: Group3Language  {
    override init() {
        super.init()
        name = "Polski"
        code = "pl"
        _20_99_connector = " "
        negativeString = "minus"
        afterNegative = " "
        dotString = "przecinek"
        exponentString = " razy dziesięć do potęgi "
        after_hundreds = " "
        before_hundreds = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "zero"
        case 1: return "jeden"
        case 2: return "dwa"
        case 3: return "trzy"
        case 4: return "cztery"
        case 5: return "pięć"
        case 6: return "sześć"
        case 7: return "siedem"
        case 8: return "osiem"
        case 9: return "dziewięć" //dziewipoęć"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
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
    
    override func _11_19(_ i: UInt) -> String {
        switch i {
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


    override func _100_999(_ i: UInt) -> String {
        var ret = super._100_999(i)
        let hundreds: UInt = i / 100
        if hundreds == 2 {
            ret = ret.replacingOccurrences(of: "dwasta", with: "dwieście")
        }
        return ret
    }

    private func use(_ i: UInt, _ s0: String, _ s1: String, _ s2: String) -> String {
        if i == 1 { return s0 }
        var use1 = false
        
        if [2,3,4].contains(i % 10) { use1 = true }
        if [11, 12, 13, 14].contains(i % 100) { use1 = false }
        return use1 ? s1 : s2
    }

    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 2:
            return use(above, "sto", "sta", "set")
        case 3:
            return use(above, "tysiąc", "tysiące", "tysięcy")
        case 6:
            return use(above, "milion", "miliony", "milionów")
        case 9:
            return use(above, "miliard", "miliardy", "miliardów")
        case 12:
            return use(above, "bilion", "biliony", "bilionów")
        default:
            return nil
        }
    }
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        if groupIndex > 3 {
            use_single_group = true
        } else {
            use_single_group = false
        }
        return super.group(groupIndex, above, below: below)
    }
}
    
