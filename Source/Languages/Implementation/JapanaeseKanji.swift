//
//  JapanaeseKanji.swift
//  LanguageTest
//
//  Created by Joachim Neumann on 1/8/24.
//

import Foundation

class JapanaeseKanji: Language {
    
    let filler = "零"
    
    init() {
        super.init(
            name: "variant.name",
            zero: "variant.zero",
            negativeString: "负",
            dotString: "点",
            exponentString: " 乘以 十的 ")
        voiceLanguageCode = "zh"
        nameDescription = "variant.englishName"
//        e2 = variant.e2
//        e3 = variant.e3
//        e4 = variant.e4
    }
    
//    override func read_1_9(_ i: Int) -> String {
//        return variant.read_1_9(i)
//    }
//    
//    override func read_10s(_ i: Int) -> String {
//        if i == 1 {
//            return variant.e1
//        } else {
//            return read_1_9(i) + variant.e1
//        }
//    }
//    
//    func read_trailing_tens(_ i: Int) -> String {
//        var ret = readChinese(i)
//        if i.E1 == 1 {
//            ret = readChinese(1) + ret
//        }
//        return ret
//    }
//    
//    override func read_10_99(_ i: Int) -> String {
//        var ret = ""
//        if i.E1 > 0 {
//            ret = read_1_9(i.E1)
//        }
//        ret += variant.e1
//        if i.E1x > 0 {
//            ret += read_1_9(i.E1x)
//        }
//        return ret
//    }
//    
//    override func read_e2_e3(_ i: Int) -> String {
//        var ret = read_1_9(i.E2) + variant.e2
//        
//        if i.E2x > 0 {
//            ret += " "
//            if i.E2x < 10 {
//                ret += filler
//            }
//            ret += readChinese(i.E2x)
//        }
//        return ret
//    }
//
//    override func read_e3_e6(_ i: Int) -> String {
//        var ret = readChinese(i.E3) + variant.e3
//        
//        if i.E3x > 0 {
//            ret += " "
//            if i.E3x < 100 {
//                ret += filler
//            }
//            ret += readChinese(i.E3x)
//        }
//        return ret
//    }
//    
//    private func readChinese(_ i: Int) -> String {
//        var ret = ""
//        if i < 10_000 {
//            return super.read_1_(i)
//        }
//
//        if i < 100_000_000 {
//            ret += read_1_(i.E4)
//            ret += variant.e4
//            if i.E4x > 0 {
//                ret += " "
//                if i.E4x < 1_000 {
//                    ret += filler
//                }
//                ret += readChinese(i.E4x)
//            }
//            return ret
//        }
//
//        if i < 1_000_000_000_000 {
//            ret += read_1_(i.E8)
//            ret += variant.e8
//            if i.E8x > 0 {
//                ret += " "
//                if i.E8x < 10_000_000 {
//                    ret += filler
//                }
//                ret += readChinese(i.E8x)
//            }
//            return ret
//        }
//
//        ret += readChinese(i.E12)
//        ret += variant.e12
//        if i.E12x > 0 {
//            ret += " "
//            if i.E12x < 100_000_000_000 {
//                ret += filler
//            }
//            ret += readChinese(i.E12x)
//        }
//        return ret
//    }
//    
//    override func read_1_(_ i: Int) -> String {
//        if i >= 10 && i < 20 {
//            var ret = ""
//            ret = super.read_1_(i)
//            ret = String(ret.dropFirst())
//            return ret
//        } else {
//            return readChinese(i)
//        }
//    }
//


}
