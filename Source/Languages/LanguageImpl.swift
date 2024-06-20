//
//  LanguageImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 20.06.24.
//

import Foundation

@Observable class LanguageImpl: Language {
    func _0_9(_ i: Int) -> String {
        fatalError("_0_9() not implmented")
    }
}

extension Int {
    func E(_ i: Int) -> Int {
        let factor = Int(pow(10.0, Double(i)))
        return self / factor
    }
    func Ex(_ i: Int) -> Int {
        let factor = Int(pow(10.0, Double(i)))
        
        return self - self / factor * factor
    }
    var pow10: Int { Int(pow(10.0, Double(self))) }
    var secondLastDigit: Int { (self /  10) % 10 }
    var thirdLastDigit:  Int { (self / 100) % 10 }
}
