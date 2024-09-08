//
//  Portuguese.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class PortugueseImplementation: Group3Language  {
    let variant: Variant
    
    init(variant: Variant) {
        self.variant = variant
        super.init()
        name = variant.rawValue
        code = "pt"
        before_hundreds = ""
        _20_99_connector = " e "
        negativeString = "menos"
        dotString = "vírgula"
        before_hundreds = ""
        after_hundreds = " e "
        before_groupName = " "
        after_groupName = " e "    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "zero"
        case 1: return "um"
        case 2: return "dois"
        case 3: return "três"
        case 4: return "quatro"
        case 5: return "cinco"
        case 6: return "seis"
        case 7: return "sete"
        case 8: return "oito"
        case 9: return "nove"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
        switch i {
        case 1: return "dez"
        case 2: return "vinte"
        case 3: return "trinta"
        case 4: return "quarenta"
        case 5: return "cinquenta"
        case 6: return "sessenta"
        case 7: return "setenta"
        case 8: return "oitenta"
        case 9: return "noventa"
        default: return "read_10s: outside range"
        }
    }
    
    override func _11_19(_ i: UInt) -> String {
        switch i {
        case 11: return "onze"
        case 12: return "doze"
        case 13: return "treze"
        case 14: return "catorze"
        case 15: return "quinze"
        case 16: return "dezesseis"
        case 17: return "dezessete"
        case 18: return "dezoito"
        case 19: return "dezenove"
        default:
            fatalError("_11_19() parameter \(i)")
        }
    }
    
    override func _100_999(_ i: UInt) -> String {
        var ret = super._100_999(i)
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if hundreds == 1 && below == 0 { return "cem" }
        ret = ret.replacingOccurrences(of: "doiscentos", with: "duzentos")
        ret = ret.replacingOccurrences(of: "trêscentos", with: "trezentos")
        ret = ret.replacingOccurrences(of: "cincocentos", with: "quinhentos")
        return ret
    }
    
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 2:
            switch above {
            case 1: return "cento"
            default:
                return "centos"
            }
        case 3:
            return "mil"
        case 6:
            if above == 1 {
                return "um milhão"
            } else {
                return "milhões"
            }
        case 9:
            switch variant {
            case .brazilian:
                if above == 1 {
                    return "um bilhão"
                } else {
                    return "bilhões"
                }
            case .european:
                return "mil milhões"
            }
        case 12:
            switch variant {
            case .brazilian:
                if above == 1 {
                    return "um trilhão"
                } else {
                    return "trilhões"
                }
            case .european:
                if above == 1 {
                    return "um bilião"
                } else {
                    return "biliões"
                }
            }
        default: return nil
        }
    }
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        if below < 100 || below % 100 == 0 {
            after_groupName = " e "
        } else {
            after_groupName = " "
        }
        return super.group(groupIndex, above, below: below)
    }

    enum Variant: String {
        case european  = "Português Europeu"
        case brazilian = "Português Brasileiro"
    }
}
    
