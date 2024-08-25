//
//  NumberTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 22.08.24.
//

import Foundation

public protocol LanguageProtocol {
    var name: String { get }
    func translate(_ s: String) -> String
    func translate(_ i: Int) -> String
    func translate(_ f: Float) -> String
    func translate(_ d: Double) -> String
}

extension LanguageProtocol {
    public func translate(_ f: Float) -> String {
        return translate(String(f))
    }
    
    public func translate(_ d: Double) -> String {
        return translate(String(d))
    }
}

extension UInt {
    func E(_ i: UInt) -> UInt {
        let factor = UInt(pow(10.0, Double(i)))
        return self / factor
    }
    func Ex(_ i: UInt) -> UInt {
        let factor = UInt(pow(10.0, Double(i)))

        return self - self / factor * factor
    }
    var pow10: UInt { UInt(pow(10.0, Double(self))) }
    var secondLastDigit: UInt { (self /  10) % 10 }
    var thirdLastDigit:  UInt { (self / 100) % 10 }
}
