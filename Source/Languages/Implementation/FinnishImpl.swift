//
//  FinnishImpl.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 1/5/24.
//

import Foundation

class FinnishImpl: LanguageImpl {
    init() {
        super.init(
            name: "Suomalainen",
            negativeString: "miinus",
            dotString: "pilkku",
            exponentString: " EE ")
        nameDescription = "Finnish"

//        tensConnector = " "
//        e2 = "cent"
//        e2_one = e2
//        eSpace = " "
//        e3 = "mil"
//        e3_one = e3
//        e6 = "milionoj"
//        e6_one = "miliono"
//        e9 = "miliardoj"
//        e9_one = "miliardo"
//        e12 = "bilionoj"
//        e12_one = "biliono"
//        afterNegative = " "
//        beforeAndAfterDotString = " "
    }


    override func read_0_9(_ i: Int) -> String {
        switch i {
        case 0: return "nolla"
        case 1: return "yksi"
        case 2: return "kaksi"
        case 3: return "kolme"
        case 4: return "neljä"
        case 5: return "viisi"
        case 6: return "kuusi"
        case 7: return "seitsemän"
        case 8: return "kahdeksan"
        case 9: return "yhdeksän"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        if i == 1 { return "dek"}
        return read_0_9(i) + "dek"
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = super.read_e2_e3(i)
        ret = ret.replacingOccurrences(of: " cent", with: "cent")
        return ret
    }
    
}
