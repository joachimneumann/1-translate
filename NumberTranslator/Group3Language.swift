//
//  Group3Language.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 25.08.24.
//

import Foundation

class Group3Language: GeneralLanguage {
    var use_single_group = false
    var before_groupName: String = " "
    var after_groupName: String = " "
    var _20_99_connector: String = ""
    var use_single_hundreds = false
    var before_hundreds: String = " "
    var after_hundreds: String = " "

    func _10s(_ i: UInt) -> String {
        return _0_9(i) + " 10s"
    }
    
    func _11_19(_ i: UInt) -> String {
        return _20_99(i)
    }
    
    func _20_99(_ i: UInt) -> String {
        let left = i / 10
        let right = i - left * 10
        var ret = _10s(left)
        if right > 0 {
            ret += _20_99_connector + _0_9(right)
        }
        return ret
    }

    func _0_99(_ i: UInt) -> String {
        if i <= 9 { return _0_9(i) }
        if i == 10 { return _10s(1) }
        if i <= 19 { return _11_19(i) }
        return _20_99(i)
    }
    
    func _100_999(_ i: UInt) -> String {
        var ret = ""
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if hundreds > 1 || use_single_hundreds {
            ret = _0_9(hundreds) + before_hundreds
        }
        if let hundredsName = groupName(2, hundreds) {
            ret += hundredsName
        }
        if below > 0 {
            ret += after_hundreds + _0_99(below)
        }
        return ret
    }

    func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        return nil
    }
    
    
    override func fromUInt(_ i: UInt) -> String {
        if i <= 9 {
            return _0_9(i) // implemented in Language
        }
        
        if i == 10 {
            return _10s(1)
        }
        
        if i <= 19 {
            return _11_19(i)
        }
        
        if i <= 99 {
            return _20_99(i)
        }
        
        if i <= 999 {
            return _100_999(i)
        }

        for exponent: UInt in stride(from: 3, to: 15, by: 3){
            if i <= (exponent+3).pow10 - 1 {
                return group(exponent, i.E(exponent), below: i.Ex(exponent))
            }
        }

        return "ERROR in NewLanguageGroup3.read_positive()"
    }
    
    func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        var ret: String = ""

        if above > 1 || use_single_group {
            ret = fromUInt(above) + before_groupName
        }
        if let groupName = groupName(groupIndex, above) {
            ret += groupName
        }

        if below > 0 {
            ret += after_groupName + fromUInt(below)
        }
        return ret
    }
}
