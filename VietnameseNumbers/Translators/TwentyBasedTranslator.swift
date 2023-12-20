//
//  TwentyBasedTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/9/23.
//

import Foundation

protocol TwentyBasedTranslatorProtocol: TranslatorProtocol {
    var hundred: String { get set }
    var thousand: String { get set }
    var _e6: String { get set }
    var _e9: String { get set }
    func translate_0_20(_ i: Int) -> String
    func translate_10s(_ i: Int) -> String
}

class TwentyBasedTranslator: BasicTranslator, TwentyBasedTranslatorProtocol {
    var hundred: String
    var thousand: String
    var _e6: String
    var _e9: String

    // optional modifiers
    var tenThousand: String? = nil
    var hundredThousand: String? = nil
    var beforeChunk: String = ""
    var beforeOneChunk: String = ""
    var afterChunk: String = ""
    var afterHundred: String? = nil
    var betweenTenAndOne: String? = nil
    var onlyOne: String? = nil

    init(
        language: String,
        languageEnglish: String? = nil,
        dotString: String,
        negativeString: String,
        exponentString: String,
        hundred: String,
        thousand: String,
        _e6: String,
        _e9: String) {
            self.hundred = hundred
            self.thousand = thousand
            self._e6 = _e6
            self._e9 = _e9
            super.init(
                language: language,
                languageEnglish: languageEnglish,
                dotString: dotString,
                negativeString: negativeString,
                exponentString: exponentString)
        }
    
    func translate_0_20(_ i: Int) -> String {
        /// to be overridden
        return "Error: not implemented"
    }
    func translate_10s(_ i: Int) -> String {
        /// to be overridden
        return "Error: not implemented"
    }

    override func translatePositiveInteger(_ i: Int) -> String? {
//        if i == 1 && onlyOne != nil {
//            return onlyOne!
//        }
        if i <= 20 {
            return translate_0_20(i)
        }
        if i <= 99 {
            var temp = i
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            var ret = translate_10s(X0)
            if X > 0 {
                ret += (betweenTenAndOne != nil ? betweenTenAndOne! : "")
                ret += translate_0_20(X)
            }
            return ret
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
                ret = translate_0_20(X00) + beforeChunk + hundred
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

            if let hundredThousand = hundredThousand {
                if XXX_000 >= 100 {
                    let h = XXX_000 / 100
                    let leftover = i - 100_000 * h
                    var ret = ""

                    if h == 1 {
                        ret = beforeOneChunk + hundredThousand
                    } else {
                        ret = translate_0_20(h) + beforeChunk + hundredThousand
                    }

                    if leftover > 0 {
                        ret += translatePositiveInteger(leftover)!
                    }
                    return ret
                }
            }
            if let tenThousand = tenThousand {
                if XXX_000 >= 10 {
                    let t = XXX_000 / 10
                    let leftover = i - 10_000 * t
                    var ret = ""

                    if t == 1 {
                        ret = beforeOneChunk + tenThousand
                    } else {
                        ret = translate_0_20(t) + beforeChunk + tenThousand
                    }
                    if leftover > 0 {
                        ret += translatePositiveInteger(leftover)!
                    }
                    return ret
                }
            }

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
                ret = beforeOneChunk + _e6
            } else {
                ret = translatePositiveInteger(XXX_000_000)! + beforeChunk + _e6
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
            ret = beforeOneChunk + _e9
        } else {
            ret = translatePositiveInteger(XXX_000_000_000)! + beforeChunk + _e9
        }
        if XXX_000_000 > 0 {
            ret += afterChunk + translate(XXX_000_000)!
        }
        return ret
    }
}
