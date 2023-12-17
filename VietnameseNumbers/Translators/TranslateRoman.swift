//
//  TranslateRoman.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/17/23.
//

import SwiftUI

class TranslateRoman: BasicTranslator {
    
    init() {
        super.init(language: "roman",
                   dotString: "",
                   negativeString: "",
                   andSoOn: "",
                   exponentString: "")
        allowNegativeNumbers = false
    }
    
    override func translatePositiveInteger(_ num: Int) -> String? {
        if num == 0 {
            return "zero: unknown"
        }
        if num > 3999 {
            return "too large"
        }

        let values = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let numerals = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]
        
        var result = ""
        var remaining = num
        
        for (index, value) in values.enumerated() {
            while remaining >= value {
                result += numerals[index]
                remaining -= value
            }
        }
        
        return result
    }
}

