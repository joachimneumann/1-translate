//
//  Spanish.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import SwiftUI

class SpanishImpl: LanguageGroup3 {
    enum PuntoComma: String, Codable, CaseIterable {
        case coma
        case punto
    }

    @AppStorage("SpanishUsePuntoKey", store: .standard)
    var puntoComma: PuntoComma = .coma {
        didSet {
            dotString = puntoComma.rawValue
        }
    }
    
    init() {

        super.init(
            name: "Español",
            zero: "cero",
            negativeString: "menos",
            dotString: "coma",
            exponentString: " por diez elevado a ")

        voiceLanguageCode = "es"
        _20_99_connector = " y "
        afterNegative = " "
        puntoComma = puntoComma
    }

    override func _100_999(_ hundreds: Int, below: Int) -> String {
        var ret: String = ""
        switch hundreds {
        case 1:
            ret = below == 0 ? "cien" : "ciento"
        case 5:
            ret = "quinientos"
        case 7:
            ret = "setecientos"
        case 9:
            ret = "novecientos"
        default:
            ret = read_positive(hundreds) + "cientos"
        }
        if below > 0 {
            ret += " " + read_positive(below)
        }
        return ret
    }
    
    private func groupName(_ groupIndex: Int, _ isOne: Bool) -> String {
        switch groupIndex {
        case 3:
            return "mil"
        case 6:
            if isOne {
                return "un millón"
            } else {
                return "millones"
            }
        case 9:
            return "mil millones"
        case 12:
            if isOne {
                return "un billón"
            } else {
                return "billiones"
            }
        default: return "ERROR in Spanish Group"
        }
    }

    override func group(_ groupIndex: Int, _ above: Int, below: Int) -> String {
        var ret: String = ""
        
        if above == 1 {
            ret = groupName(groupIndex, true)
        } else {
            ret = read_positive(above) + " " + groupName(groupIndex, false)
        }
        if below > 0 {
            ret += groupIndex == 12 ? " y " : " "
            ret += read_positive(below)
        }
        return ret
    }
    
    override func _0_9(_ i: Int) -> String {
        switch i {
        case 0:  return zero!
        case 1:  return "uno"
        case 2:  return "dos"
        case 3:  return "tres"
        case 4:  return "cuatro"
        case 5:  return "cinco"
        case 6:  return "seis"
        case 7:  return "siete"
        case 8:  return "ocho"
        case 9:  return "nueve"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: Int) -> String {
        switch i {
        case 1: return "diez"
        case 2: return "veinte"
        case 3: return "treinta"
        case 4: return "cuarenta"
        case 5: return "cincuenta"
        case 6: return "sesenta"
        case 7: return "setenta"
        case 8: return "ochenta"
        case 9: return "noventa"
        default:
            fatalError("_10s() parameter \(i)")
        }
    }
    
    override func _10_19(_ i: Int) -> String {
        switch i {
        case 10: return _10s(1)
        case 11: return "once"
        case 12: return "doce"
        case 13: return "trece"
        case 14: return "catorce"
        case 15: return "quince"
        case 16: return "dieciséis"
        case 17: return "diecisiete"
        case 18: return "dieciocho"
        case 19: return "diecinueve"
        default:
            fatalError("_11_19() parameter \(i)")
        }
    }
    
    override func _20_99(_ i: Int) -> String {
        var ret = super._20_99(i)
        ret = ret.replacingOccurrences(of: "veinte y dos", with: "veintidós")
        ret = ret.replacingOccurrences(of: "veinte y tres", with: "veintitrés")
        ret = ret.replacingOccurrences(of: "veinte y seis", with: "veintiséis")
        ret = ret.replacingOccurrences(of: "veinte y ", with: "veinti")
        return ret
    }

}
