//
//  TranslateNumberP.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import Foundation

protocol LanguageP {
    var removeSeperators: RemoveSeperators { get }
    func read(_ numberString: String) -> String
    var name: String { get }
    var englishName: String? { get }
    var rightToLeft: Bool { get }
    var groupSeparator: String  { get set }
    var decimalSeparator: String  { get set }
}
protocol EnglishP: LanguageP{
    var andAfterHundred: Bool { get set }
}
protocol GermanP: LanguageP{
    var capitalization: Bool { get set }
}
protocol RemoveSeperators {
    func removeSeperators()
}
protocol TranslateNumberP {
    var decimalSeparator: DecimalSeparator { get set }
    var groupSeparator: GroupSeparator { get set }
    var languages: [LanguageP]  { get }
    func language(_ requestedLanguage: String) -> LanguageP?
    func english() -> EnglishP
    func german() -> GermanP
}
