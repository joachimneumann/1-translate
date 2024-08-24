////
////  German.swift
////  TranslateNumbers
////
////  Created by Joachim Neumann on 23.08.24.
////
//
//import Foundation
//
//public class German: Language, LanguageImplementation, LanguageImplGroup3 {
//    public init() {}
//    func _0_9(_ i: Int) -> String {
//        switch i {
//        case 0: return zero!
//        case 1: return "eins"
//        case 2: return "zwei"
//        case 3: return "drei"
//        case 4: return "vier"
//        case 5: return "fünf"
//        case 6: return "sechs"
//        case 7: return "sieben"
//        case 8: return "acht"
//        case 9: return "neun"
//        default:
//            fatalError("_0_9() parameter \(i)")
//        }
//    }
//
//    func _10s(_ i: Int) -> String {
//        switch i {
//        case 1: return "zehn"
//        case 2: return "zwanzig"
//        case 3: return "dreißig"
//        case 4: return "vierzig"
//        case 5: return "fünfzig"
//        case 6: return "sechzig"
//        case 7: return "siebzig"
//        case 8: return "achtzig"
//        case 9: return "neunzig"
//        default:
//            fatalError("_10s() parameter \(i)")
//        }
//    }
//    
//    override func _20_99(_ i: Int) -> String {
//        // inverted order in German
//        let left = i / 10
//        let right = i - left * 10
//        var ret = _10s(left)
//        if right > 0 {
//            ret = _0_9(right) + _20_99_connector + ret
//        }
//        return ret
//    }
//    
//    public var name: String = "Deutsch"
//    var zero: String? = "null"
//    let allowNegativeNumbers: Bool = true
//    let allowExponent: Bool = false
//    let allowFraction: Bool = false
//    let afterNegative: String = ""
//    let negativeString = "-"
//    let beforeAndAfterDotString = ""
//    let dotString = "."
//    let exponentString = " EE "
//    
//    var _20_99_connector: String = "und"
//    var use_single_hundreds = false
//    var before_hundreds = " "
//    var after_hundreds = " "
//    var use_single_group = false
//    var before_groupName = ""
//    var after_groupName = ""
//    
//}
