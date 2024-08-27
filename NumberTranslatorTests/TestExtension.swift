//
//  TestExtension.swift
//  NumberTranslatorTests
//
//  Created by Joachim Neumann on 24.08.24.
//

import Foundation

extension String {
    var x: String {
        self.replacingOccurrences(of: Translator.wordSplitter, with: "")
    }
}
