//
//  TranslateResult.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 10.11.2024.
//

import SwiftUI

class TranslateResult: ObservableObject, CustomDebugStringConvertible {
    @Published var displayText: String
    @Published var overline: String?
    var spokenText: String?
    var error: Bool
    
    var copyText: String {
        let text = displayText.replacingOccurrences(of: "\u{200A}", with: "")
        guard var overline = overline else { return text }
        overline = overline.replacingOccurrences(of: "\u{200A}", with: "")
        return "<overline>" + overline + "</overline>" + text
    }
    
    init() {
        self.displayText = ""
        self.overline = nil
        spokenText = nil
        error = false
    }
    
    init(displayText: String, overline: String?, spokenText: String?) {
        if displayText.starts(with: "Error: ") {
            self.displayText = displayText.replacingOccurrences(of: "Error: ", with: "")
            self.error = true
        } else {
            self.displayText = displayText
            self.error = false
        }
        self.overline = overline
        self.spokenText = spokenText
    }
    
    var debugDescription: String {
        "\((overline != nil) ? overline!+" " : "")\(displayText)"
    }
}
