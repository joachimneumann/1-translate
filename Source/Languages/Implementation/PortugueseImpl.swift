//
//  PortugueseImpl.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/8/24.
//

import SwiftUI

class PortugueseImpl: Language {
    
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
            zero: "zero",
            negativeString: "menos",
            dotString: "vírgula",
            exponentString: " EE ")
        voiceLanguageCode = "pt"
        tensConnector = " e "
    }
    
    override func read_1_9(_ i: Int) -> String {
        switch i {
        case 1:     return "um"
        case 2:     return "dois"
        case 3:     return "três"
        case 4:     return "quatro"
        case 5:     return "cinco"
        case 6:     return "seis"
        case 7:     return "sete"
        case 8:     return "oito"
        case 9:     return "nove"
        default: return "read_0_9: outside range"
        }
    }
    
    override func read_10s(_ i: Int) -> String {
        switch i {
        case 1:     return "dez"
        case 2:     return "vinte"
        case 3:     return "trinta"
        case 4:     return "quarenta"
        case 5:     return "cinquenta"
        case 6:     return "sessenta"
        case 7:     return "setenta"
        case 8:     return "oitenta"
        case 9:     return "noventa"
        default: return "read_10s: outside range"
        }
    }
    
    override func read_10_99(_ i: Int) -> String {
        if i == 11 { return "onze" }
        if i == 12 { return "doze" }
        if i == 13 { return "treze" }
        if i == 14 { return "catorze" }
        if i == 15 { return "quinze" }
        if i == 16 { return "dezesseis" }
        if i == 17 { return "dezessete" }
        if i == 18 { return "dezoito" }
        if i == 19 { return "dezenove" }
        return super.read_10_99(i)
    }
    
    override func read_e2_e3(_ i: Int) -> String {
        var ret = ""
        switch i.E2 {
        case 1:     ret = i.E2x > 0 ? "cento" : "cem"
        case 2:     ret = "duzentos"
        case 3:     ret = "trezentos"
        case 4:     ret = "quatrocentos"
        case 5:     ret = "quinhentos"
        case 6:     ret = "seiscentos"
        case 7:     ret = "setecentos"
        case 8:     ret = "oitocentos"
        case 9:     ret = "novecentos"
        default: return "read_e2_e3: outside range"
        }
        if i.E2x > 0 {
            ret += " e " + read(i.E2x)
        }
        return ret
    }
    
    override func read_e3_e6(_ i: Int) -> String {
        var ret = ""
        if i.E3 > 1 {
            ret = read(i.E3) + " "
        }
        ret += "mil"
        if i.E3x > 0 {
            if i.E3x < 100 || i.E3x % 100 == 0 {
                ret += " e"
            }
            ret += " " + read(i.E3x)
        }
        return ret
    }
    
    override func read_e6_e9(_ i: Int) -> String {
        var ret = ""
        if i.E6 > 1 {
            ret = read(i.E6) + " milhões"
        } else {
            ret = "um milhão"
        }
        if i.E6x > 0 {
            let cleanHundredThousands = i.E6x.E3 < 100 || i.E6x.E3 % 100 == 0
            let cleanHundred = i.E3x < 100 || i.E3x % 100 == 0
            let noHundredThousands = i.E6x.E3 == 0
            if cleanHundredThousands && !noHundredThousands || (noHundredThousands && cleanHundred) {
                ret += " e"
            }
            ret += " " + read(i.E6x)
        }
        return ret
    }
    
    override func read_e9_e12(_ i: Int) -> String {
        var ret = ""
        if i.E9 > 1 {
            ret = read(i.E9) + " "
            switch variant {
            case .Brazilian:
                ret += "bilhões"
            case .European:
                ret += "mil milhões"
            }
        } else {
            switch variant {
            case .Brazilian:
                ret = "um bilhão"
            case .European:
                ret = "mil milhões"
            }
        }
        if i.E9x > 0 {
            let cleanHundredThousands = i.E9x.E6 < 100 || i.E9x.E6 % 100 == 0
            let cleanHundred = i.E6x < 100 || i.E6x % 100 == 0
            let noHundredThousands = i.E9x.E6 == 0
            if cleanHundredThousands && !noHundredThousands || (noHundredThousands && cleanHundred) {
                ret += " e"
            }
            ret += " " + read(i.E9x)
        }
        return ret
    }
    
    override func read_e12_e15(_ i: Int) -> String {
        var ret = ""
        if i.E12 > 1 {
            ret = read(i.E12) + " "
            switch variant {
            case .Brazilian:
                ret += "trilhões"
            case .European:
                ret += "biliões"
            }
        } else {
            switch variant {
            case .Brazilian:
                ret = "um trilhão"
            case .European:
                ret += "um bilião"
            }
        }
        if i.E12x > 0 {
            let cleanHundredThousands = i.E12x.E9 < 100 || i.E12x.E9 % 100 == 0
            let cleanHundred = i.E9x < 100 || i.E9x % 100 == 0
            let noHundredThousands = i.E12x.E9 == 0
            if cleanHundredThousands && !noHundredThousands || (noHundredThousands && cleanHundred) {
                ret += " e"
            }
            ret += " " + read(i.E12x)
        }
        return ret
    }
    
}
