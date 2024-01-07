//
//  Extension.swift
//  LanguageTest
//
//  Created by Joachim Neumann on 1/7/24.
//

import Foundation

extension String {
    var x: String {
        self.replacingOccurrences(of: Languages.WordSplitter, with: "")
    }
}
