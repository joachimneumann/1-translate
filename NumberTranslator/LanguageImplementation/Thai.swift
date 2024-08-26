//
//  Thai.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class ThaiImplementation: Group3Language  {
    override init() {
        super.init()
        name = "ภาษาไทย"
        negativeString = "ลบ"
        afterNegative = " "
        dotString = "จุด"
        use_single_hundreds = true
        use_single_group = true
        before_hundreds = ""
        after_hundreds = ""
        before_groupName = ""
        after_groupName = ""
        afterNegative = ""
        beforeAndAfterDotString = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "ศูนย์"
        case 1: return "หนึ่ง" // "เอ็ด"
        case 2: return "สอง"
        case 3: return "สาม"
        case 4: return "สี่"
        case 5: return "ห้า"
        case 6: return "หก"
        case 7: return "เจ็ด"
        case 8: return "แปด"
        case 9: return "เก้า"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
        switch i {
        case 1:     return "สิบ"
        case 2:     return "ยี่สิบ"
        default: return _0_9(i) + "สิบ"
        }
    }
    
    override func _20_99(_ i: UInt) -> String {
        let ret = super._20_99(i)
        if i > 1 && ret.hasSuffix("หนึ่ง") {
            return ret.replacingOccurrences(of: "หนึ่ง", with: "เอ็ด")
        }
        return ret
    }

    override func _100_999(_ i: UInt) -> String {
        var ret = super._100_999(i)
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if below > 0 {
            ret = ret.replacingOccurrences(of: "cents", with: "cent")
        }
        return ret
    }

    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 2:
            return "ร้อย"
        case 3:
            return "พัน"
        case 6:
            return "ล้าน"
        case 9:
            return "พันล้าน"
        case 12:
            return "ล้านล้าน"
        default: return nil
        }
    }
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        var ret: String = ""

        //    case 4:
        //        return "หมื่น"
        //    case 5:
        //        return "แสน"

        if groupIndex == 3 && above >= 100 {
            ret = fromUInt(above / 100) + "แสน"
            let below = (above - above / 100 * 100) * 1000 + below
            if below > 0 {
                ret += fromUInt(below)
            }
            return ret
        } else if groupIndex == 3 && above >= 10 {
            ret = fromUInt(above / 10) + "หมื่น"
            let below = (above - above / 10 * 10) * 1000 + below
            if below > 0 {
                ret += fromUInt(below)
            }
            return ret
        } else {
            if let groupName = groupName(groupIndex, above) {
                ret = groupName + after_groupName + fromUInt(above)
            }
        }
        
        if groupIndex == 3 {
            // handle groupindex 4
            
        }
        ret = fromUInt(above) + before_groupName
        if let groupName = groupName(groupIndex, above) {
            ret += groupName
        }

        if below > 0 {
            ret += after_groupName + fromUInt(below)
        }
        return ret
    }
}
    
