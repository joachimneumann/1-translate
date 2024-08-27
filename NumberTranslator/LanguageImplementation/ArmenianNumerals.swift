//
//  ArmenianNumerals.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class ArmenianNumeralsImplementation: GeneralLanguage  {
    override init() {
        super.init()
        name = "թիվ"
        englishName = "Armenian Numerals"
        code = "hy"
        allowNegative = false
        allowExponent = false
        allowFraction = false
        beforeAndAfterDotString = ""
    }

    private func read_armenian_1_9(_ i: UInt) -> String {
        switch i {
        case 1: return "Ա"
        case 2: return "Բ"
        case 3: return "Գ"
        case 4: return "Դ"
        case 5: return "Ե"
        case 6: return "Զ"
        case 7: return "Է"
        case 8: return "Ը"
        case 9: return "Թ"
        default: return "read_0_9: outside range"
        }
    }
    
    private func read_armenianTens(_ i: UInt) -> String {
            switch i {
            case 1:     return "Ժ"
            case 2:     return "Ի"
            case 3:     return "Լ"
            case 4:     return "Խ"
            case 5:     return "Ծ"
            case 6:     return "Կ"
            case 7:     return "Հ"
            case 8:     return "Ձ"
            case 9:     return "Ղ"
            default: return "read_armenianTens: outside range"
            }
        }

        private func read_armenianHundreds(_ i: UInt) -> String {
            switch i {
            case 1:     return "Ճ"
            case 2:     return "Մ"
            case 3:     return "Յ"
            case 4:     return "Ն"
            case 5:     return "Շ"
            case 6:     return "Ո"
            case 7:     return "Չ"
            case 8:     return "Պ"
            case 9:     return "Ջ"
            default: return "read_armenianHundreds: outside range"
            }
        }

        private func read_armenianThousands(_ i: UInt) -> String {
            switch i {
            case 1:     return "Ռ"
            case 2:     return "Ս"
            case 3:     return "Վ"
            case 4:     return "Տ"
            case 5:     return "Ր"
            case 6:     return "Ց"
            case 7:     return "Ւ"
            case 8:     return "Փ"
            case 9:     return "Ք"
            default: return "read_armenianThousands: outside range"
            }
        }

        private func read_armenianTenThousands(_ i: UInt) -> String {
            switch i {
            case 1:     return "Օ"
            case 2:     return "Ֆ"
            default: return "read_armenianTenThousands: outside range"
            }
        }
    
    private func armenianUpTo9999(_ i: UInt) -> String {
        if i <= 9 {
            return read_armenian_1_9(i)
        }
        var ret = ""
        if i <= 99 {
            let first = i / 10
            let rest = i - 10 * first
            ret = read_armenianTens(first)
            if rest > 0 {
                ret += read_armenian_1_9(rest)
            }
            return ret
        }
        if i <= 999 {
            let first = i / 100
            let rest = i - 100 * first
            ret = read_armenianHundreds(first)
            if rest > 0 {
                ret += fromUInt(rest)
            }
            return ret
        }
        if i <= 9_999 {
            let first = i / 1000
            let rest = i - 1000 * first
            ret = read_armenianThousands(first)
            if rest > 0 {
                ret += fromUInt(rest)
            }
            return ret
        }

        return "too large"
    }
    
    override func fromUInt(_ i: UInt) -> String {
        if i == 0 { return "zero unknown" }
        if i <= 9_999 {
            return armenianUpTo9999(i)
        } else {
            if i <= 99_999_999 {
                let above_tenthousand = i / 10_000
                let below_tenthousand = i - above_tenthousand * 10_000
                var ret = armenianUpTo9999(above_tenthousand) + " OVERLINE"
                if below_tenthousand > 0 {
                    ret += " " + armenianUpTo9999(below_tenthousand)
                }
                return ret
            }
            return "too large"
        }
    }
    
}
