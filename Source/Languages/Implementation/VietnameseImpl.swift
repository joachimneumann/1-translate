//
//  Vietnamese.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/22/23.
//

import SwiftUI

class VietnameseImpl: LanguageGroup3 {
    
    @AppStorage("VietnameseThousandKey")
    var vietnameseThousand: VietnameseImpl.VietnameseThousand = .nghìn
    
    @AppStorage("VietnameseSecondLastKey")
    var secondLast: VietnameseImpl.SecondLast = .lẻ
    
    @AppStorage("VietnameseCompactKey")
    var compact: Bool = false

    enum VietnameseThousand: String, Codable, CaseIterable {
        case ngàn
        case nghìn
    }

    enum SecondLast: String, Codable, CaseIterable {
        case linh
        case lẻ
    }
    
    init() {
        super.init(
            name: "Tiếng Việt",
            zero: "không",
            negativeString: "âm",
            dotString: "phẩy",
            exponentString: " nhân mười mũ ")
        voiceLanguageCode = "vi"
        afterNegative = " "
        nameDescription = "Vietnamese"
        _20_99_connector = " "
        secondLast = secondLast
        vietnameseThousand = vietnameseThousand
    }
    
    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret = read_positive(hundreds) + " trăm"
        if below > 0 {
            if below <= 9 {
                ret += " " + secondLast.rawValue
            }
            ret += " " + read_positive(below)
        }
        return ret
    }
    
    private func groupName(_ groupIndex: Int) -> String {
        switch groupIndex {
        case 0:
            return ""
        case 3:
            return " " + vietnameseThousand.rawValue
        case 6:
            return " triệu"
        case 9:
            return " tỷ"
        case 12:
            return " " + vietnameseThousand.rawValue + " tỷ"
        default: return "ERROR in English Group"
        }
    }
    
    private func notLargestGroup(_ groupIndex: Int, _ i: Int) -> String {
        var ret = ""
        let above = i.E(groupIndex)
        let below = i.Ex(groupIndex)
        if above == 0 {
            ret += notLargestGroup(groupIndex - 3, i)
        } else {
            if above <= 9 {
                ret += " không trăm " + secondLast.rawValue
            } else if above <= 99 {
                ret += " không trăm"
            }
            ret += " " + read_positive(above)
            ret += groupName(groupIndex)
            if groupIndex >= 3 && below > 0 {
                ret += notLargestGroup(groupIndex - 3, below)
            }
        }
        return ret
    }
        
    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret = read_positive(above) + groupName(groupIndex)
        if below > 0 {
            ret += notLargestGroup(groupIndex - 3, below)
        }
        return ret
    }
    
    override func _20_99(_ i: Int) -> String {
        let left = i / 10
        let right = i - left * 10
        var ret = _0_9(left)
        if right == 0 {
            ret += " mươi"
        } else {
            ret += (!compact || right == 0) ? " mươi" : ""
            if right == 1 {
                ret += " mốt"
            } else if right == 5 {
                ret += " lăm"
            } else {
                ret += " " + _0_9(right)
            }
        }
        return ret
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "một"
        case 2:  return "hai"
        case 3:  return "ba"
        case 4:  return "bốn"
        case 5:  return "năm"
        case 6:  return "sáu"
        case 7:  return "bảy"
        case 8:  return "tám"
        case 9:  return "chín"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10_19(_ i: Int) -> String {
        let left = i / 10
        let right = i - left * 10

        var ret = "mười"
        if right > 0 {
            if right == 5 {
                ret += " lăm"
            } else {
                ret += " " + _0_9(right)
            }
        }
        return ret
    }
    
    override func _10s(_ i: Int) -> String {
        var ret = " mươi"
        if i > 1 {
            ret = _0_9(i) + ret
        }
        return ret
    }

}
