//
//  ThousandBasedTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/10/23.
//

import Foundation

protocol ThousandBasedTranslatorProtocol: TranslatorProtocol {
    var hundred: String { get set }
    var thousand: String { get set }
    var million: String { get set }
    var billion: String { get set }
    func translatePositiveInteger_0_999(_ i: Int) -> String?
}

class ThousandBasedTranslator: BasicTranslator, ThousandBasedTranslatorProtocol {
    var hundred: String
    var thousand: String
    var million: String
    var billion: String
    
    init(
        language: String,
        dotString: String,
        negativeString: String,
        andSoOn: String,
        exponentString: String,
        hundred: String,
        thousand: String,
        million: String,
        billion: String) {
            self.hundred = hundred
            self.thousand = thousand
            self.million = million
            self.billion = billion
            super.init(
                language: language,
                dotString: dotString,
                negativeString: negativeString,
                andSoOn: andSoOn,
                exponentString: exponentString)
        }
    
    func translatePositiveInteger_0_999(_ i: Int) -> String? {
        /// to be overridden
        return nil
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        if i <= 999 {
            return translatePositiveInteger_0_999(i)
        }
        if i <= 999_999 {
            let XXX_000 = (i - i % 1000) / 1000
            let XXX = i - 1000 * XXX_000
            var ret = translatePositiveInteger(XXX_000)! + " " + thousand
            if XXX > 0 {
                ret += " " + translate(XXX)!
            }
            return ret
        }
        if i <= 999_999_999 {
            let XXX_000_000 = (i - i % 1_000_000) / 1_000_000
            let XXX_000 = i - 1_000_000 * XXX_000_000
            var ret = translatePositiveInteger(XXX_000_000)! + " " + million
            if XXX_000 > 0 {
                ret += " " + translatePositiveInteger(XXX_000)!
            }
            return ret
        }
        
        if i <= 999_999_999_999 {
            let XXX_000_000_000 = (i - i % 1_000_000_000) / 1_000_000_000
            let XXX_000_000 = i - 1_000_000_000 * XXX_000_000_000
            var ret = translatePositiveInteger(XXX_000_000_000)! + " " + billion
            if XXX_000_000 > 0 {
                ret += " " + translatePositiveInteger(XXX_000_000)!
            }
            return ret
        }
        return nil
    }
}
