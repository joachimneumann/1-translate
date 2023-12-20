//
//  TenBasedLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation


class TenBasedLanguage: Language {
    func read_0_9(_ i: Int) -> String {
        fatalError("not implmented")
    }

    func readPeriod(_ p: Period) -> String {
        fatalError("not overridden")
    }

    override func readPositive(_ i: Int) -> String {
        guard i >= 0 && i < 999_999_999_999_999 else { fatalError("TenBasedLanguage readPositive out of range") }
        
        if i < 10 {
            return read_0_9(i)
        }
        var ret = ""
        let e0 = i.e0
        guard let e3 = i.e3  else {
            return readPeriod(e0)
        }
        ret = readPeriod(e0)

        guard let e6 = i.e6  else {
            return readPeriod(e3) + ret
        }
        ret = readPeriod(e3) + ret

        guard let e9 = i.e9  else {
            return readPeriod(e6) + ret
        }
        ret = readPeriod(e6) + ret

        guard let e12 = i.e12  else {
            return readPeriod(e9) + ret
        }
        ret = readPeriod(e9) + ret
        ret = readPeriod(e12) + ret

        return ret
    }

}
