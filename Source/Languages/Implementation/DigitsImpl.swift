//
//  Digits.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class DigitsImpl: LanguageImpl {
    init() {
        super.init(
            name: "Digits",
            zero: "0",
            negativeString: "-",
            dotString: ".",
            exponentString: " EE ")
        afterNegative = ""
    }
    
    override func read_positive(_ i: Int) -> String {
        i.string
    }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
