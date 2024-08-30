//
//  wordSplitterExtension.swift
//  NumberTranslator
//
//  Created by Joachim Neumann on 30.08.24.
//

import Foundation

extension String {
    static let generalLanguageWordsplitter = GeneralLanguage().wordSplitter
    public var x: String {
        self.replacingOccurrences(of: Self.generalLanguageWordsplitter, with: "")
    }
}
