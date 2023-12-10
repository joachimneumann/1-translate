//
//  TranslateVietnamese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/8/23.
//

import SwiftUI

enum VietnameseThousand: String, Codable, CaseIterable {
    case ngàn
    case nghìn
    var string: String {
        switch self {
        case .ngàn: return "ngàn"
        case .nghìn: return "nghìn"
        }
    }
}

enum VietnameseSecondLast: String, Codable, CaseIterable {
    case linh
    case lẻ
    var string: String {
        switch self {
        case .linh: return "linh"
        case .lẻ: return "lẻ"
        }
    }
}


class TranslateVietnamese: GeneralTranslator {
    var compact: Bool = false
    var secondLast: VietnameseSecondLast = .lẻ
    var thousand: VietnameseThousand = .nghìn
    
    init() {
        super.init(
            language: translatorLanguages.vietnamese.rawValue,
            dotString: "phẩy",
            negativeString: "âm",
            andSoOn: "và như thế",
            exponentString: "nhân mười lũy thừa")
    }
        
    private let one = "một"
    private let one_with_up_tone = "mốt"
    private let ten = "mười"
    private let ten_no_tone = "mươi"
    private let hundred = "trăm"
    private let million = "triệu"
    private let billion = "tỷ"
    
    private func toString_0_10(_ intValue: Int, one_up_tone: Bool = false, lăm: Bool = false, ten_tone: Bool = false) -> String? {
        switch intValue {
        case 0:     return "không"
        case 1:     if one_up_tone { return one_with_up_tone } else { return one }
        case 2:     return "hai"
        case 3:     return "ba"
        case 4:     return "bốn"
        case 5:     if lăm { return "lăm" } else { return "năm" }
        case 6:     return "sáu"
        case 7:     return "bảy"
        case 8:     return "tám"
        case 9:     return "chín"
        case 10:    if ten_tone { return ten_no_tone } else { return ten }
        default: return nil
        }
    }
        
    private func toString_(_ intValue: Int, fromLargerNumber: Bool) -> String? {
        if intValue < 0 { return nil }
        if !fromLargerNumber && intValue <= 10 {
            return toString_0_10(intValue)
        }
        if !fromLargerNumber && intValue < 20 {
            return toString_0_10(10)! + " " +
            toString_0_10(intValue - 10, one_up_tone: false, lăm: true)!
        }
        if intValue <= 999 {
            var temp = intValue
            let X = temp % 10
            temp = (temp - X) / 10
            let X0 = temp % 10
            temp = (temp - X0) / 10
            let X00 = temp % 10
            var ret = ""
            if fromLargerNumber || X00 > 0 {
                if ret.count > 0 { ret += " " }
                ret += toString_(X00, fromLargerNumber: false)! + " " + hundred
            } else {
                if fromLargerNumber || ret.count > 0 {
                    if ret.count > 0 { ret += " " }
                    ret += toString_(0, fromLargerNumber: false)! + " " + hundred
                }
            }
            if X0 == 0 && X == 0 {
                return ret
            }
            if X0 > 0 {
                if ret.count > 0 { ret += " " }
                if X0 >= 2 {
                    var between = " " + ten_no_tone
                    if compact {
                        if X > 0 {
                            between = ""
                        }
                    }
                    ret += toString_(X0, fromLargerNumber: false)! + between
                    if X > 0 {
                        ret += " " + toString_0_10(X, one_up_tone: true, lăm: true)!
                    }
                } else {
                    // X0 is 1
                    ret += ten
                    if X > 0 {
                        ret += " " + toString_0_10(X, one_up_tone: false, lăm: true)!
                    }
                }
            } else {
                // lẻ?
                if ret.count > 0 { ret += " " }
                if X > 0 {
                    ret += secondLast.string + " "
                    ret += toString_(X, fromLargerNumber: false)!
                } else {
                    ret += toString_(0, fromLargerNumber: false)!
                }
            }
            return ret
        }
        
        if intValue <= 999_999 {
            let XXX = intValue % 1_000
            let XXX_000 = (intValue - XXX) / 1_000
            var ret = toString_(XXX_000, fromLargerNumber: fromLargerNumber)! + " " + thousand.string
            if XXX > 0 {
                ret += " " + toString_(XXX, fromLargerNumber: true)!
            }
            return ret
        }
        
        if intValue <= 999_999_999 {
            let XXX_XXX = intValue % 1_000_000
            let XXX_000_000 = (intValue - XXX_XXX) / 1_000_000
            var ret = toString_(XXX_000_000, fromLargerNumber: false)! + " " + million
            if XXX_XXX > 0 {
                ret += " " + toString_(XXX_XXX, fromLargerNumber: true)!
            }
            return ret
        }
        
        if intValue <= 999_999_999_999 {
            let XXX_XXX_XXX = intValue % 1_000_000_000
            let XXX_000_000_000 = (intValue - XXX_XXX_XXX) / 1_000_000_000
            var ret = toString_(XXX_000_000_000, fromLargerNumber: false)! + " " + billion
            if XXX_XXX_XXX > 0 {
                ret += " " + toString_(XXX_XXX_XXX, fromLargerNumber: true)!
            }
            return ret
        }
        
        return nil
    }

    override func translatePositiveInteger(_ i: Int) -> String? {
        toString_(i, fromLargerNumber: false)!
    }

}
