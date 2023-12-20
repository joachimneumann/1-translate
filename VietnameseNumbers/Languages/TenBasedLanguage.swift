//
//  TenBasedLanguage.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation


protocol TenBasedLanguageProtocol: LanguageProtocol {
    func read_0_9(_ i: Int) -> String
}

typealias TenBasedLanguage = TenBasedLanguageProtocol & TenBasedLanguageClass

class TenBasedLanguageClass: LanguageClass {
    var tenBasedLanguage: TenBasedLanguage? = nil
    override init(groupSeparator: String, decimalSeparator: String) {
        super.init(groupSeparator: groupSeparator, decimalSeparator: decimalSeparator)
        self.tenBasedLanguage = self as? TenBasedLanguage
    }
    
    func readPeriodexten
    override func read(_ i: Int) -> String {
        guard let tenBasedLanguage = tenBasedLanguage else { return error }
        var ret = i.e0.read()
        
        return tenBasedLanguage.read_0_9(i)
    }

}
