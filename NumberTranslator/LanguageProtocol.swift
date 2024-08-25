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
