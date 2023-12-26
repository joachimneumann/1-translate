//
//  TranslateNumberP.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/26/23.
//

import Foundation

protocol Language2P {
    func read(_ numberString: String) -> String
    func read(_ i: Int) -> String
    var name: String { get }
    var englishName: String? { get }
    var rightToLeft: Bool { get }
}
protocol English: Language2P {
    var afterHundred: String { get set }
}
