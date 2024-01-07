//
//  Roman.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import Foundation

let OVERLINE = "__OVERLINE__"

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
    
    private func read_3_999(_ i: Int) -> String {
        if i > 3_999 {
            return "too large"
        }

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
    
    override func read_1_(_ num: Int) -> String {
        if num < 0 {
            return "negative: unknown"
        }
        if num <= 3_999 {
            return read_3_999(num)
        } else {
            if num < 3_999_999 {
                let XXX = num % 1000
                let XXX_000 = num / 1000
                var ret = read_3_999(XXX_000) + OVERLINE
                if XXX > 0 {
                    ret += read_3_999(XXX)
                }
                return ret
            }
        }
        return "too large"
    }

}

