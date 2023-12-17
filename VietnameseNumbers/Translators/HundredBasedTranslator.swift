//
//  StandardTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/9/23.
//

import Foundation

protocol HundredBasedTranslatorProtocol: TranslatorProtocol {
    var hundred: String { get set }
    var thousand: String { get set }
    var million: String { get set }
    var billion: String { get set }
    func translatePositiveInteger_0_99(_ i: Int) -> String?
}

class HundredBasedTranslator: BasicTranslator, HundredBasedTranslatorProtocol {
    var hundred: String
    var thousand: String
    var million: String
    var billion: String
    var beforeChunk: String = ""
    var beforeOneChunk: String = ""
    var afterChunk: String = ""
    var afterHundred: String? = nil

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
    
    func translatePositiveInteger_0_99(_ i: Int) -> String? {
        /// to be overridden
        return nil
    }
    
    override func translatePositiveInteger(_ i: Int) -> String? {
        if i <= 99 {
            return translatePositiveInteger_0_99(i)
        }
        if i <= 999 {
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            temp = (temp - X0) / 10
            let X00 = temp % 10
            var ret = ""
            if X00 == 1 {
                ret = beforeOneChunk + hundred
            } else {
                ret = translatePositiveInteger_0_99(X00)! + beforeChunk + hundred
            }
            let leftover = 10 * X0 + X
            if leftover > 0 {
                if let afterHundred = afterHundred {
                    ret +=  afterHundred + translate(leftover)!
                } else {
                    ret +=  afterChunk + translate(leftover)!
                }
            }
            return ret
        }
        if i <= 999_999 {
            let XXX_000 = (i - i % 1000) / 1000
            let XXX = i - 1000 * XXX_000
            var ret = ""
            if XXX_000 == 1 {
                ret = beforeOneChunk + thousand
            } else {
                ret = translatePositiveInteger(XXX_000)! + beforeChunk + thousand
            }
            if XXX > 0 {
                ret += afterChunk + translate(XXX)!
            }
            return ret
        }
        if i <= 999_999_999 {
            let XXX_000_000 = (i - i % 1_000_000) / 1_000_000
            let XXX_000 = i - 1_000_000 * XXX_000_000
            var ret = ""
            if XXX_000_000 == 1 {
                ret = beforeOneChunk + million
            } else {
                ret = translatePositiveInteger(XXX_000_000)! + beforeChunk + million
            }
            if XXX_000 > 0 {
                ret += afterChunk + translate(XXX_000)!
            }
            return ret
        }
        
        let XXX_000_000_000 = (i - i % 1_000_000_000) / 1_000_000_000
        let XXX_000_000 = i - 1_000_000_000 * XXX_000_000_000
        var ret = ""
        if XXX_000_000_000 == 1 {
            ret = beforeOneChunk + billion
        } else {
            ret = translatePositiveInteger(XXX_000_000_000)! + beforeChunk + billion
        }
        if XXX_000_000 > 0 {
            ret += afterChunk + translate(XXX_000_000)!
        }
        return ret
    }
}
