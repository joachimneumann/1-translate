//
//  GeneralTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/9/23.
//

import Foundation

protocol GeneralTranslatorProtocol: BasicTranslatorProtocol {
    func translatePositiveInteger(_ i: Int) -> String?
}

class GeneralTranslator: BasicTranslator, GeneralTranslatorProtocol {
    override func translatePositiveInteger(_ i: Int) -> String? {
        // placeholder
        return nil
    }
}
