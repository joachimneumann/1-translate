//
//  VietnameseImplementation.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class VietnameseImplementation: Group3Language  {
    var vietnameseThousand: VietnameseThousand = .nghìn
    var secondLast: SecondLast = .lẻ
    var compact: Bool = false

    enum VietnameseThousand: String, Codable, CaseIterable {
        case ngàn
        case nghìn
    }

    enum SecondLast: String, Codable, CaseIterable {
        case linh
        case lẻ
    }
    
    override init() {
        super.init()
        name = "Tiếng Việt"
        negativeString = "âm"
        afterNegative = " "
        dotString = "phẩy"
        beforeAndAfterDotString = " "
        exponentString = " nhân mười mũ "
        _20_99_connector = " "
        use_single_hundreds = true
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "không"
        case 1: return "một"
        case 2: return "hai"
        case 3: return "ba"
        case 4: return "bốn"
        case 5: return "năm"
        case 6: return "sáu"
        case 7: return "bảy"
        case 8: return "tám"
        case 9: return "chín"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
        return "mười" // the other cases are handled below
    }
    
    override func _11_19(_ i: UInt) -> String {
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
    
    override func _20_99(_ i: UInt) -> String {
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
    
    override func _100_999(_ i: UInt) -> String {
        after_hundreds = " "
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if below > 0 {
            if below <= 9 {
                after_hundreds = " " + secondLast.rawValue + " "
            }
        }
        return super._100_999(i)
    }
    
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 0:
            return ""
        case 2:
            return "trăm"
        case 3:
            return " " + vietnameseThousand.rawValue
        case 6:
            return " triệu"
        case 9:
            return " tỷ"
        case 12:
            return " " + vietnameseThousand.rawValue + " tỷ"
        default: return nil
        }
    }
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        var ret = fromUInt(above)
        if let groupName = groupName(groupIndex, above) {
            ret += groupName
        }
        if below > 0 {
            ret += notLargestGroup(groupIndex - 3, below)
        }
        return ret
    }
    
    private func notLargestGroup(_ groupIndex: UInt, _ i: UInt) -> String {
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
            ret += " " + fromUInt(above)
            if let groupName = groupName(groupIndex, above) {
                ret += groupName
            }
            if groupIndex >= 3 && below > 0 {
                ret += notLargestGroup(groupIndex - 3, below)
            }
        }
        return ret
    }
    
}
    
