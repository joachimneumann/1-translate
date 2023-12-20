//
//  TenBasedLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation


protocol TenBasedLanguageProtocol: LanguageProtocol {
    func read_0_9(_ i: Int) -> String
}

typealias TenBasedLanguage = TenBasedLanguageProtocol & TenBasedLanguageClass

class TenBasedLanguageClass: LanguageClass {
    var tenBasedLanguage: (any TenBasedLanguage)? = nil
    override init() {
        super.init()
        self.tenBasedLanguage = self as? (any TenBasedLanguage)
    }
    
    private func readPeriod(_ p: Period, leadingZeros: Bool = true) -> String {
        guard let tenBasedLanguage = tenBasedLanguage else { return error }
        var ret = ""
        if leadingZeros || p.x__ != 0 {
            ret += tenBasedLanguage.read_0_9(p.x__)
        }
        if leadingZeros || p._x_ != 0 || p.x__ != 0 {
            ret += tenBasedLanguage.read_0_9(p._x_)
        }
        ret += tenBasedLanguage.read_0_9(p.__x)
        return ret
    }

    func readPositive(_ i: Int) -> String {
        guard i >= 0 && i < 999_999_999_999_999 else { return error }
        
        var ret = ""
        let e0 = i.e0
        guard let e3 = i.e3  else {
            return readPeriod(e0, leadingZeros: false)
        }
        ret = readPeriod(e0)

        guard let e6 = i.e6  else {
            return readPeriod(e3, leadingZeros: false) + ret
        }
        ret = readPeriod(e3) + ret

        guard let e9 = i.e9  else {
            return readPeriod(e6, leadingZeros: false) + ret
        }
        ret = readPeriod(e6) + ret

        guard let e12 = i.e12  else {
            return readPeriod(e9, leadingZeros: false) + ret
        }
        ret = readPeriod(e9) + ret
        ret = readPeriod(e12, leadingZeros: false) + ret

        return ret
    }

}
