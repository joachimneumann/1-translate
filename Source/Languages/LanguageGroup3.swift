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
        if let zero = zero {
            return _10s(i.E1) + zero
        }
        return String(i)
    }
    
    func _10_19(_ i: Int) -> String {
        return _20_99(i)
    }
    
    func _20_99(_ i: Int) -> String {
        var ret = _10s(i.E1)
        if i.E1x > 0 {
            ret += _20_99_connector + _0_9(i.E1x)
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
            return _100_999(i.E2, below: i.E2x)
        }

        if i <= 999_999 {
            return group(3, i.E3, below: i.E3x)
        }

        if i <= 999_999_999 {
            return group(6, i.E6, below: i.E6x)
        }

        if i <= 999_999_999_999 {
            return group(9, i.E9, below: i.E9x)
        }

        if i <= 999_999_999_999_999 {
            return group(12, i.E12, below: i.E12x)
        }

        return "ERROR in NewLanguageGroup3.read_positive()"
    }
    

}

