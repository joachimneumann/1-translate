//
//  XNumberTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation
import NumberTranslator

class TranslationResult: ObservableObject {
    var displayText: String
    var overline: String?
    var spokenText: String?
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
    }
    init(displayText: String, overline: String?, spokenText: String?) {
        self.displayText = displayText
        self.overline = overline
        self.spokenText = spokenText
    }
}

@Observable class XNumberTranslator: NumberTranslator, ObservableObject, Identifiable {

    var currentLanguage: NumberTranslator.Language = .english
    
    var hasVoice: Bool = false
    
    func flagName(_ language: NumberTranslator.Language) -> String {
        englishName(language) ?? name(language)
    }
    var flagName: String { flagName(currentLanguage) }
    var code: String? { code(currentLanguage) }
    var groupSize: Int { groupSize(currentLanguage) }

    func nameWithDescription(_ language: NumberTranslator.Language) -> String {
        language.rawValue + (englishName(language) != nil ? "/"+englishName(language)! : "")
    }
    var nameWithDescription: String { nameWithDescription(currentLanguage) }

    var speakingPostProcessing: ((String) -> String)?

    func getResult(_ s: String, to language: NumberTranslator.Language) -> TranslationResult {
        var displayText = translate(s, to: language)
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
        if code(language) != nil && hasVoice {
            spokenText = displayText.replacingOccurrences(of: "\u{200A}", with: "")
            if let speakingPostProcessing {
                spokenText = speakingPostProcessing(spokenText!)
            }
        }
        ObjectWillChangePublisher().send()
        return TranslationResult(
            displayText: displayText,
            overline: overline,
            spokenText: spokenText)
    }
    func getResult(_ s: String) -> TranslationResult {
        getResult(s, to: currentLanguage)
    }
}
