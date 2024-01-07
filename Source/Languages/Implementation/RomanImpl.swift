//
//  Roman.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

class RomanImpl: Language {

    init() {
        super.init(
            name: "Roman",
            zero: nil,
            negativeString: "",
            dotString: "",
            exponentString: "")
        voiceLanguageCode = "la"
        allowNegativeNumbers = false
        allowExponent = false
        allowFraction = false
    }
    
    private func romanUpTp3999(_ i: Int) -> String {
        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        
        var result = ""
        var remaining = i
        
        for (index, value) in values.enumerated() {
            while remaining >= value {
                result += numerals[index]
                remaining -= value
            }
        }
        return result
    }
    
    override func read_1_(_ i: Int) -> String {
        if i <= 3_999 {
            return romanUpTp3999(i)
        } else {
            if i < 3_999_999 {
                return romanUpTp3999(i % 1000)
            }
        }
        return "too large"
    }
    
    override func read_OVERLINE(_ i: Int) -> String? {
        if i <= 3_999 {
            return nil
        } else {
            if i < 3_999_999 {
                return romanUpTp3999(i / 1000)
            }
        }
        return nil
    }

}

