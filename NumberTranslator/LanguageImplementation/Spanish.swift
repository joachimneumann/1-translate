//
//  Spanish.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 26.08.24.
//

import Foundation

class SpanishImplementation: Group3Language  {
    enum PuntoComma: String, Codable, CaseIterable {
        case coma
        case punto
    }

    var puntoComma: PuntoComma = .coma {
        didSet {
            dotString = puntoComma.rawValue
        }
    }

    override init() {
        super.init()
        name = "Español"
        code = "es"
        _20_99_connector = " y "
        negativeString = "menos"
        afterNegative = " "
        dotString = "coma"
        exponentString = " por diez elevado a "
        before_hundreds = ""
    }
    
    override func _0_9(_ i: UInt) -> String {
        switch i {
        case 0: return "cero"
        case 1: return "uno"
        case 2: return "dos"
        case 3: return "tres"
        case 4: return "cuatro"
        case 5: return "cinco"
        case 6: return "seis"
        case 7: return "siete"
        case 8: return "ocho"
        case 9: return "nueve"
        default:
            fatalError("_0_9() parameter \(i)")
        }
    }
    
    override func _10s(_ i: UInt) -> String {
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
    
    override func _11_19(_ i: UInt) -> String {
        switch i {
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

    override func _20_99(_ i: UInt) -> String {
        var ret = super._20_99(i)
        ret = ret.replacingOccurrences(of: "veinte y dos", with: "veintidós")
        ret = ret.replacingOccurrences(of: "veinte y tres", with: "veintitrés")
        ret = ret.replacingOccurrences(of: "veinte y seis", with: "veintiséis")
        ret = ret.replacingOccurrences(of: "veinte y ", with: "veinti")
        return ret
    }

    override func _100_999(_ i: UInt) -> String {
        var ret = super._100_999(i)
        let hundreds: UInt = i / 100
        let below: UInt = i - hundreds * 100
        if hundreds == 1 && below == 0 {
            ret = ret.replacingOccurrences(of: "ciento", with: "cien")
        }
        ret = ret.replacingOccurrences(of: "cincocientos", with: "quinientos")
        ret = ret.replacingOccurrences(of: "sietecientos", with: "setecientos")
        ret = ret.replacingOccurrences(of: "nuevecientos", with: "novecientos")
        return ret
    }

    
    override func groupName(_ groupIndex: UInt, _ above: UInt) -> String? {
        switch groupIndex {
        case 2:
            if above == 1 {
                return "ciento"
            } else {
                return "cientos"
            }
        case 3:
            return "mil"
        case 6:
            if above == 1 {
                return "un millón"
            } else {
                return "millones"
            }
        case 9:
            return "mil millones"
        case 12:
            if above == 1 {
                return "un billón"
            } else {
                return "billiones"
            }
        default: return nil
        }
    }
    
    override func group(_ groupIndex: UInt, _ above: UInt, below: UInt) -> String {
        if groupIndex == 12 {
            after_groupName = " y "
        } else {
            after_groupName = " "
        }
        return super.group(groupIndex, above, below: below)
    }
}
    
