//
//  Digits.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class Digits: Language {
    init() {
        super.init(
            name: "Digits",
            negativeString: "-",
            dotString: ".",
            exponentString: "e",
            groupSeparator: "",
            decimalSeparator: ".")
        afterNegative = ""
    }
    
    override func readPositive(_ i: Int) -> String {
        i.string
    }
}
