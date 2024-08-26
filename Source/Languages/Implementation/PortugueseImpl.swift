//
//  PortugueseImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/8/24.
//

import SwiftUI

class PortugueseImpl: LanguageImplGroup3 {

    enum Variant: String, Codable, CaseIterable {
        case European
        case Brazilian
        var name: String {
            switch self {
            case .European: "Português Europeu"
            case .Brazilian:  "Português Brasileiro"
            }
        }
    }

    var variant: Variant

    init(variant: Variant) {
        self.variant = variant
        super.init(
            name: variant.name,
            groupSize: GroupSize.three,
            zero: "zero",
            negativeString: "menos",
            dotString: "vírgula",
            exponentString: " EE ")
        voiceLanguageCode = "pt"
        _20_99_connector = " e "
        before_hundreds = ""
        after_hundreds = " e "
        before_groupName = " "
        after_groupName = " e "
    }

    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0: return zero!
        case 1: return "um"
        case 2: return "dois"
        case 3: return "três"
        case 4: return "quatro"
        case 5: return "cinco"
        case 6: return "seis"
        case 7: return "sete"
        case 8: return "oito"
        case 9: return "nove"
        default: return "read_0_9: outside range"
        }
    }

    override func _10s(_ i: Int) -> String {
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

    override func _11_19(_ i: Int) -> String {
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

    override func groupName(_ groupIndex: Int, _ above: Int) -> String? {
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
            case .Brazilian:
                if above == 1 {
                    return "um bilhão"
                } else {
                    return "bilhões"
                }
            case .European:
                return "mil milhões"
            }
        case 12:
            switch variant {
            case .Brazilian:
                if above == 1 {
                    return "um trilhão"
                } else {
                    return "trilhões"
                }
            case .European:
                if above == 1 {
                    return "um bilião"
                } else {
                    return "biliões"
                }
            }
        default: return nil
        }
    }

    override func _100_999(_ hundreds: Int, below: Int) -> String {
        if hundreds == 1 && below == 0 { return "cem" }
        var ret = super._100_999(hundreds, below: below)
        ret = ret.replacingOccurrences(of: "doiscentos", with: "duzentos")
        ret = ret.replacingOccurrences(of: "trêscentos", with: "trezentos")
        ret = ret.replacingOccurrences(of: "cincocentos", with: "quinhentos")
        return ret
    }

    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        if below < 100 || below % 100 == 0 {
            after_groupName = " e "
        } else {
            after_groupName = " "
        }
        return super.group(groupIndex, above, below: below)
    }

}
