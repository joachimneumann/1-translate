//
//  Digits.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class DigitsImpl: LanguageBaseClass {
    init() {
        super.init(
            name: "Digits",
            negativeString: "-",
            dotString: ".",
            exponentString: "e")
        afterNegative = ""
    }
    
    override func read(_ i: Int) -> String {
        i.string
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
