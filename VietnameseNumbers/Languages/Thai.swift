//
//  Thai.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

class Thai: Language {
    let e0 = "หนึ่ง"
    let e2 = "ร้อย"
    let e3 = "พัน"
    let e4 = "หมื่น"
    let e5 = "แสน"
    let e6 = "ล้าน"
    let e9 = "พันล้าน"

    init() {
        super.init(
            name: "ภาษาไทย",
            negativeString: "ลบ",
            dotString: "จุด",
            exponentString: "e",
            groupSeparator: "",
            decimalSeparator: ".")
    }
    
    private func read_0_9(_ i: Int) -> String {
        switch i {
        case 0: return "ศูนย์"
        case 1: return "เอ็ด"
        case 2: return "สอง"
        case 3: return "สาม"
        case 4: return "สี่"
        case 5: return "ห้า"
        case 6: return "หก"
        case 7: return "เจ็ด"
        case 8: return "แปด"
        case 9: return "เก้า"
        default: return " translate_0_10: outside range "
        }
    }
    
    private func read_10s(_ intValue: Int) -> String {
        switch intValue {
        case 1:     return "สิบ"
        case 2:     return "ยี่สิบ"
        case 3:     return "สามสิบ"
        case 4:     return "สี่สิบ"
        case 5:     return "ห้าสิบ"
        case 6:     return "หกสิบ"
        case 7:     return "เจ็ดสิบ"
        case 8:     return "แปดสิบ"
        case 9:     return "เก้าสิบ"
        default: return " 10s outside range "
        }
    }

    override func readPositive(_ i: Int) -> String {
        if i == 1 { return e0 }
        if i < 10 {
            return read_0_9(i)
        }

        var ret = ""
        if i <= 99 {
            let p = i.e0
            ret += read_10s(p._x_)
            if p.__x > 0 {
                ret += read_0_9(p.__x)
            }
            return ret
        }
        
        if i < 1_000 {
            let p = i.e0
            if p.x__ == 1 {
                ret += e0
            } else {
                ret += read_0_9(p.x__)
            }
            ret += e2
            if p._xx > 0 {
                ret += readPositive(p._xx)
            }
            return ret
        }

        if i < 10_000 {
            let p = i.e3!
            if p.__x == 1 {
                ret += e0
            } else {
                ret += read_0_9(p.__x)
            }
            ret += e3
            if i.e0.value > 0 {
                ret += readPositive(i.e0.value)
            }
            return ret
        }

        if i < 100_000 {
            let tenThousands = i / 10_000
            let leftOver = i - tenThousands * 10_000
            
            if tenThousands == 1 {
                ret += e0
            } else {
                ret += read_0_9(tenThousands)
            }
            ret += e4
            if leftOver > 0 {
                ret += readPositive(leftOver)
            }
            return ret
        }

        let hundredThousands = i / 100_000
        let leftOver = i - hundredThousands * 100_000
        
        if hundredThousands == 1 {
            ret += e0
        } else {
            ret += read_0_9(hundredThousands)
        }
        ret += e5
        if leftOver > 0 {
            ret += readPositive(leftOver)
        }
        return ret
    }
}
