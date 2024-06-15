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
    var _11_99_connector: Connector = Connector()
//    var connector_4_3: Connector = Connector()
//    var connector_7_6: Connector = Connector()
//    var connector_10_9: Connector = Connector()
//    var connector_13_12: Connector = Connector()
    var _11_99_inverted = false

    func _100_999(_ hundreds: Int, below: Int) -> String {
        fatalError("_100_999() not implmented")
    }    
    func group(_ groupIndex: Int, _ thousands: Int, below: Int) -> String {
        fatalError("group() not implmented")
    }

    func _10s(_ i: Int) -> String? { return nil }
    func _10_19(_ i: Int) -> String? { return nil }
    
    func _1_99(_ i: Int, isLargestGroup: Bool = false) -> String {
        if i <= 9 {
            return _0_9(i)
        }
        return _10_99(i)
    }
    
    func _10_99(_ i: Int) -> String {
        if i <= 19 {
            if let ret = _10_19(i) {
                return ret
            }
        }
        var ret = _10s(i.E1) ?? _0_9(i.E1)
        if i.E1x > 0 {
            if _11_99_inverted {
                ret = _0_9(i.E1x) + _11_99_connector.before + _11_99_connector.name + _11_99_connector.after + ret
            } else {
                ret += _11_99_connector.before + _11_99_connector.name + _11_99_connector.after + _0_9(i.E1x)
            }
        }
        
        return ret
    }

    func _0_999(_ i: Int, isLargestGroup: Bool = false) -> String {
        if i <= 9 {
            return _0_9(i) // implemented in Language
        }
        
        if i <= 99 {
            return _10_99(i)
        }
        
        if i <= 999 {
            return _100_999(i.E2, below: i.E2x)
        }

        return "ERROR in NewLanguageGroup3._0_999()"
    }
    
    override func read_positive(_ i: Int) -> String {
        if i <= 999 {
            return _0_999(i, isLargestGroup: true)
        }

        if i <= 999_999 {
            return group(3, i.E3, below: i.E3x)
        }

        if i <= 999_999_999 {
            return group(6, i.E6, below: i.E6x)
        }

        return "ERROR in NewLanguageGroup3.read_positive()"
    }
    

}

