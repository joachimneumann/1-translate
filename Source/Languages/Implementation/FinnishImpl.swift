//
//  FinnishImpl.swift
//  TranslateNumbersTests
//
//  Created by Joachim Neumann on 1/5/24.
//

import Foundation

class FinnishImpl: Language {
    init() {
        super.init(
            name: "Suomalainen",
            zero: "nolla",
            negativeString: "miinus",
            dotString: "pilkku",
            exponentString: " EE ")
        nameDescription = "Finnish"
        voiceLanguageCode = "fi"
        e2 = "sataa"
        e2_one = "sata"
        e3 = "tuhatta"
        e3_one = "tuhat"
        e6 = "miljoonaa"
        e6_one = "miljoona"
        e9 = "miljardia"
        e9_one = "miljardi"
        e12 = "biljoonaa"
        e12_one = "biljoona"
        e3Space = Languages.WordSplitter
        e69Space = " "
    }


    override func read_1_9(_ i: Int) -> String {
        switch i {
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
        if i == 1 { return "toista" } //kymmenen"}
        return read_1_9(i) + Languages.WordSplitter + "kymmentä"
    }
    
    override func read_10_99(_ i: Int) -> String {
        if i == 10 { return "kymmenen" }
        var ret = read_10s(i.E1)
        if i < 20 {
            if i.E1x > 0 {
                ret = read_1_9(i.E1x) + Languages.WordSplitter + ret
            }
        } else {
            if i.E1x > 0 {
                ret += Languages.WordSplitter + read_1_9(i.E1x)
            }
        }
        return ret
    }
    override func read_e2_e3(_ i: Int) -> String {
        var ret = super.read_e2_e3(i)
        ret = ret.replacingOccurrences(of: " cent", with: "cent")
        return ret
    }
    
}
