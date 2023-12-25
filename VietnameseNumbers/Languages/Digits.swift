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
