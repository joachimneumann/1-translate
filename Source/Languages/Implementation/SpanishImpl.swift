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
        _10_99_connector.name = " y "
        afterNegative = " "
        puntoComma = puntoComma
    }
    
    //        e3 = "mil"
    //        e3_one = "mil"
    //        e6_one = "un millón"
    //        e6 = "millones"
    //        e9_one = "mil millones"
    //        e9 = "mil millones"
    //        e12_one = "un billón"
    //        e12 = "billiones"
//        tensConnector = " y "
//        eSpace = " "



    override func hundred(_ hundreds: Int, _0_99: Int) -> String {
        var ret = _1_99(hundreds, isLargestGroup: false) + " hundred"
        if _0_99 > 0 {
            ret += " " + _1_99(_0_99, isLargestGroup: false)
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
    
    override func _10s(_ i: Int) -> String? {
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
    
    override func _10_19(_ i: Int) -> String? {
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
    
    override func _10_99(_ i: Int) -> String {
        var ret = super._10_99(i)
        ret = ret.replacingOccurrences(of: "veinte y dos", with: "veintidós")
        ret = ret.replacingOccurrences(of: "veinte y tres", with: "veintitrés")
        ret = ret.replacingOccurrences(of: "veinte y seis", with: "veintiséis")
        ret = ret.replacingOccurrences(of: "veinte y ", with: "veinti")
        return ret
    }


//    override func read_e2_e3(_ i: Int) -> String {
//        var ret = ""
//        switch i.E2 {
//        case 1:
//            ret = i.E2x == 0 ? "cien" : "ciento"
//        case 5:
//            ret = "quinientos"
//        case 7:
//            ret = "setecientos"
//        case 9:
//            ret = "novecientos"
//        default:
//            ret = read_1_(i.E2) + "cientos"
//        }
//        if i.E2x > 0 {
//            ret += " " + read_1_(i.E2x)
//        }
//        return ret
//    }
}
