//
//  LanguageGroup3.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 6/13/24.
//

import Foundation

//enum Grouping: Int {
//    case one
//    case three
//    case four
//    var int: Int {
//        get {
//            switch self {
//            case .one: return 1
//            case .three: return 3
//            case .four: return 4
//            }
//        }
//    }
//    var string: String {
//        get {
//            switch self {
//            case .one: return "1"
//            case .three: return "3"
//            case .four: return "4"
//            }
//        }
//    }
//    var limits: [Int] {
//        get {
//            switch self {
//            case .one: return [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15]
//            case .three: return [3, 6, 9, 12]
//            case .four: return [4, 9, 12]
//            }
//        }
//    }
//}

func aboveLimit(_ i: Int, _ limit: Int) -> Int {
    return (i / Int(pow(10.0, Double(limit))))
}
func belowLimit(_ i: Int, _ limit: Int) -> Int {
    return (i % Int(pow(10.0, Double(limit))))
}

struct Connector {
    var before: String = ""
    var name: String = ""
    var after: String = ""
}

@Observable class LanguageGroup3: Language {
    var _10_99_connector: Connector = Connector()
//    var connector_4_3: Connector = Connector()
//    var connector_7_6: Connector = Connector()
//    var connector_10_9: Connector = Connector()
//    var connector_13_12: Connector = Connector()
    var _11_99_inverted = false

    func hundred(_ hundreds: Int, _0_99: Int) -> String {
        fatalError("hundred() not implmented")
    }

    func _10s(_ i: Int) -> String? { return nil }
    func _10_19(_ i: Int) -> String? { return nil }
    func _1_99(_ i: Int, isLargestGroup: Bool) -> String {
        if i <= 9 {
            return _0_9(i)
        }
        return _10_99(i)
    }
    func _0_999(_ i: Int, isLargestGroup: Bool) -> String {
        if i <= 9 {
            return _0_9(i)
        }
        
        if i <= 99 {
            return _10_99(i)
        }
        
        if i <= 999 {
            return hundred(i.E2, _0_99: i.E2x)
        }
        return "ERROR in NewLanguageGroup3.read_group()"
    }
    
    override func read_positive(_ i: Int) -> String {
        if i <= 999 {
            return _0_999(i, isLargestGroup: true)
        }

//        if i <= 999_999 {
//            var ret: String = _0_999(i.E3, isLargestGroup: false)
//            ret += connector_4_3.before + connector_4_3.name
//            if i.E3x > 0 {
//                ret += connector_4_3.after
//                ret += _0_999(i.E3x, isLargestGroup: false)
//            }
//            return ret
//        }

//        if i <= 999_999_999 {
//            var ret: String
//            if i.E6 == 1 && connector_7_6.one != nil {
//                ret = connector_7_6.one!
//            } else {
//                ret = _0_999(i.E6, isLargestGroup: false)
//                ret += connector_7_6.before + connector_7_6.name
//            }
//            if i.E6x > 0 {
//                ret += connector_7_6.after
//                ret += read_positive(i.E6x)
//            }
//            return ret
//        }
//
//        if i <= 999_999_999_999 {
//            var ret: String
//            if i.E9 == 1 && connector_10_9.one != nil {
//                ret = connector_10_9.one!
//            } else {
//                ret = _0_999(i.E9, isLargestGroup: false)
//                ret += connector_10_9.before + connector_10_9.name
//            }
//            if i.E9x > 0 {
//                ret += connector_10_9.after
//                ret += read_positive(i.E9x)
//            }
//            return ret
//        }
//
//        if i <= 999_999_999_999_999 {
//            var ret: String
//            if i.E12 == 1 && connector_13_12.one != nil {
//                ret = connector_13_12.one!
//            } else {
//                ret = _0_999(i.E12, isLargestGroup: false)
//                ret += connector_13_12.before + connector_13_12.name
//            }
//            if i.E12x > 0 {
//                ret += connector_13_12.after
//                ret += read_positive(i.E12x)
//            }
//            return ret
//        }
        return "ERROR in NewLanguageGroup3.read_positive()"
    }
    
    func _10_99(_ i: Int) -> String {
        if i >= 10 && i <= 19 {
            if let ret = _10_19(i) {
                return ret
            }
        }
        let l = _10s(i.E1) ?? _0_9(i.E1)
        var ret = l
        if i.E1x > 0 {
            if _11_99_inverted {
                ret = _0_9(i.E1x) + _10_99_connector.before + _10_99_connector.name + _10_99_connector.after + ret
            } else {
                ret += _10_99_connector.before + _10_99_connector.name + _10_99_connector.after + _0_9(i.E1x)
            }
        }
        
        return ret
    }

}

