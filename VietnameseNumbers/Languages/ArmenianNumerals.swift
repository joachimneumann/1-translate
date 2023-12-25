//
//  ArmenianNumerals.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/25/23.
//

import Foundation

class ArmenianNumerals: Language {
    init() {
        super.init(
            name: "թվանշաններ", 
            negativeString: "-",
            dotString: ".",
            exponentString: "e")
        englishName = "Armenian Numerals"
        allowNegativeNumbers = false
        allowExponent = false
        allowFraction = false
    }
    
    private func read_armenian_1_9(_ i: Int) -> String {
        switch i {
        case 1:     return "Ա"
        case 2:     return "Բ"
        case 3:     return "Գ"
        case 4:     return "Դ"
        case 5:     return "Ե"
        case 6:     return "Զ"
        case 7:     return "Է"
        case 8:     return "Ը"
        case 9:     return "Թ"
        default: return "read_armenian_1_9: outside range"
        }
    }

    private func read_armenianTens(_ i: Int) -> String {
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

    private func read_armenianHundreds(_ i: Int) -> String {
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

    private func read_armenianThousands(_ i: Int) -> String {
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

    private func read_armenianTenThousands(_ i: Int) -> String {
        switch i {
        case 1:     return "Օ"
        case 2:     return "Ֆ"
        default: return "read_armenianTenThousands: outside range"
        }
    }
    
    private func read_9_999(_ i: Int) -> String {
        if i == 0 {
            return "zero: unknown"
        }
        if i <= 9 {
            return read_armenian_1_9(i)
        }
        var ret = ""
        if i <= 99 {
            ret = read_armenianTens(i.E1)
            if i.E1x > 0 {
                ret += read_armenian_1_9(i.E1x)
            }
            return ret
        }
        if i <= 999 {
            ret = read_armenianHundreds(i.E2)
            if i.E2x > 0 {
                ret += read(i.E2x)
            }
            return ret
        }
        if i <= 9_999 {
            ret = read_armenianThousands(i.E3)
            if i.E3x > 0 {
                ret += read(i.E3x)
            }
            return ret
        }

        return "too large"
    }
    
    
    
    override func read(_ i: Int) -> String {
        if i < 0 {
            return "negative: unknown"
        }
        if i <= 9_999 {
            return read_9_999(i)
        } else {
            if i <= 99_999_999 {
                let XXX = i % 10_000
                let XXX_000 = i / 10_000
                var ret = read_9_999(XXX_000) + OVERLINE
                if XXX > 0 {
                    ret += read_9_999(XXX)
                }
                return ret
            }
        }
        return "too large"
    }

}
