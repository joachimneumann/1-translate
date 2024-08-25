//
//  GeneralLanguage.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 25.08.24.
//

import Foundation

public class GeneralLanguage: GeneralLanguageProtocol {
    public var name: String = "name"
    var allowNegative: Bool = true
    var allowExponent: Bool = true
    var allowFraction: Bool = true
    var negativeString: String = "-"
    var afterNegative: String = ""
    var dotString: String = "."
    var beforeAndAfterDotString: String = ""
    var exponentString: String = " EE "
    
    func _0_9(_ i: UInt) -> String {
        return String(i)
    }
    
    func fromUInt(_ i: UInt) -> String {
        return String(i)
    }
}
