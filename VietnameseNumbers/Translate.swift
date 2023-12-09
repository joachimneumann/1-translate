//
//  Translate.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

///
/// TODOs:
///  Reading the text
///  Nachkommastellen
///

import Foundation


protocol StandardTranslator: BasicTranslatorProtocol {
    var thousand: String { get set }
    var million: String { get set }
    var billion: String { get set }
    func translatePositiveInteger_0_20(_ i: Int) -> String?
    func translatePositiveInteger_21_99(_ i: Int) -> String?
}



//extension BasicTranslatorProtocol {
//    func translate(_ i: Int) -> String? {
//        if i < 0 {
//            return negativeString + " " + translatePositiveInteger(-i)!
//        } else {
//            return translatePositiveInteger(i)!
//        }
//    }
//    
//    func translate(_ d: Double) -> String? {
//        translate(d.string)
//    }
//    
//
//}


extension StringProtocol {
    var firstUppercased: String { prefix(1).uppercased() + dropFirst() }
    var firstCapitalized: String { prefix(1).capitalized + dropFirst() }
}

extension LosslessStringConvertible {
    var string: String { .init(self) }
}
