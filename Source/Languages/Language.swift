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
        let text = displayText.replacingOccurrences(of: "\u{200A}", with: "")
        guard var overline = overline else { return text }
        overline = overline.replacingOccurrences(of: "\u{200A}", with: "")
        return "<overline>" + overline + "</overline>" + text
    }
}

@Observable class Translator: Identifiable {
    private var translatorIplementation: NumberTranslator
    private var currentLanguage: NumberTranslator.Language = .english
    var hasVoice: Bool = false
    func flagName(_ language: NumberTranslator.Language) -> String {
        translatorIplementation.englishName(language) ?? language.rawValue
    }
    var flagName: String { flagName(currentLanguage) }
    
    func nameWithDescription(_ language: NumberTranslator.Language) -> String {
        language.rawValue + (translatorIplementation.englishName(language) != nil ? "/"+translatorIplementation.englishName(language)! : "")
    }
    var nameWithDescription: String { nameWithDescription(currentLanguage) }

    var speakingPostProcessing: ((String) -> String)?

    init() {
        self.translatorIplementation = NumberTranslator()
    }
    
    func translate(_ s: String, to language: NumberTranslator.Language) -> Translation {
        var displayText = translatorIplementation.translate(s, to: language)
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
        if translatorIplementation.code(language) != nil && hasVoice {
            spokenText = displayText.replacingOccurrences(of: "\u{200A}", with: "")
            if let speakingPostProcessing = speakingPostProcessing {
                spokenText = speakingPostProcessing(spokenText!)
            }
        }
        return Translation(
            displayText: displayText,
            overline: overline,
            spokenText: spokenText)
    }
    func translate(_ s: String) -> Translation {
        translate(s, to: currentLanguage)
    }
}
