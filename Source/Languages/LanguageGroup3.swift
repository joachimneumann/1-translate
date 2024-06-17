//
//  LanguageGroup3.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 6/13/24.
//

import Foundation

@Observable class LanguageGroup3: Language {
    var _20_99_connector: String = ""

    func _100_999(_ hundreds: Int, below: Int) -> String {
        fatalError("_100_999() not implmented")
    }    
    func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        fatalError("group() not implmented")
    }

    func _10s(_ i: Int) -> String {
        fatalError("_10s() not implmented")
    }
    
    func _10_19(_ i: Int) -> String {
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
    
    override func read_positive(_ i: Int) -> String {
        if i <= 9 {
            return _0_9(i) // implemented in Language
        }
        
        if i <= 19 {
            return _10_19(i)
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
    

}

