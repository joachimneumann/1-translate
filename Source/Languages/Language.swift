//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation
import NumberTranslator

struct Translation {
    let displayText: String
    let overline: String?
    var spokenText: String?
    var copyText: String {
        let text = displayText.replacingOccurrences(of: Translator.wordSplitter, with: "")
        guard var overline = overline else { return text }
        overline = overline.replacingOccurrences(of: Translator.wordSplitter, with: "")
        return "<overline>" + overline + "</overline>" + text
    }
}

@Observable class Language: Identifiable {
    var translator: Translator
    var hasVoice: Bool = false
    var flagName: String {
        translator.englishName ?? translator.name
    }
    var nameWithDescription: String {
        translator.name + (translator.englishName != nil ? "/"+translator.englishName! : "")
    }
    var speakingPostProcessing: ((String) -> String)?

    init(_ translator: Translator) {
        self.translator = translator
    }
    
    func translate(_ s: String) -> Translation {
        var displayText = translator.translate(s)
        var overline: String? = nil
        if displayText.contains("OVERLINE") {
            let parts = displayText.split(separator: "OVERLINE")
            if parts.count == 1 {
                overline = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                displayText = ""
            }
            if parts.count == 2 {
                overline = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                displayText = " " + String(parts[1]).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        }
        var spokenText: String? = nil
        if translator.code != nil && hasVoice {
            spokenText = displayText.replacingOccurrences(of: Translator.wordSplitter, with: " ")
            if let speakingPostProcessing = speakingPostProcessing {
                spokenText = speakingPostProcessing(spokenText!)
            }
        }
        return Translation(
            displayText: displayText,
            overline: overline,
            spokenText: spokenText)
    }
}
