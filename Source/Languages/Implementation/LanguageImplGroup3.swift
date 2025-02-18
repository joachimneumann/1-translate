//
//  LanguageGroup3.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 6/13/24.
//

import Foundation

class LanguageImplGroup3: LanguageImpl {
    var _20_99_connector: String = ""
    var use_single_hundreds = false
    var before_hundreds: String = " "
    var after_hundreds: String = " "
    var use_single_group = false
    var before_groupName: String = " "
    var after_groupName: String = " "

    override func read_positive(_ i: Int) -> String {
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
            return _100_999(i.E(2), below: i.Ex(2))
        }

        for exponent in stride(from: 3, to: 15, by: 3){
            if i <= (exponent+3).pow10 - 1 {
                return group(exponent, i.E(exponent), below: i.Ex(exponent))
            }
        }

        return "ERROR in NewLanguageGroup3.read_positive()"
    }

    func groupName(_ groupIndex: Int, _ above: Int) -> String? {
        return nil
    }
    
    func _10s(_ i: Int) -> String {
        fatalError("_10s() not implmented")
    }
    
    func _11_19(_ i: Int) -> String {
        return _20_99(i)
    }
    
    func _20_99(_ i: Int) -> String {
        let left = i / 10
        let right = i - left * 10
        var ret = _10s(left)
        if right > 0 {
            ret += _20_99_connector + _0_9(right)
        }
        return ret
    }
    
    func _0_99(_ i: Int) -> String {
        if i <= 9 { return _0_9(i) }
        if i == 10 { return _10s(1) }
        if i <= 19 { return _11_19(i) }
        return _20_99(i)
    }
    
    func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = ""
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
    
    func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = ""

        if above > 1 || use_single_group {
            ret = read_positive(above) + before_groupName
        }
        if let groupName = groupName(groupIndex, above) {
            ret += groupName
        }

        if below > 0 {
            ret += after_groupName + read_positive(below)
        }
        return ret
    }

}

