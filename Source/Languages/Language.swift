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

//enum GroupSize: Int, Codable, CaseIterable {
//    case three
//    case four
//    case five
//    var int: Int {
//        get {
//            switch self {
//            case .three: return 3
//            case .four: return 4
//            case .five: return 5
//            }
//        }
//    }
//    var string: String {
//        get {
//            switch self {
//            case .three: return "3"
//            case .four: return "4"
//            case .five: return "2,3"
//            }
//        }
//    }
//}

@Observable class Language: Identifiable {
    var translator: Translator

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
    
    func setParameter(_ parameter: String, to value: Bool) {
        if parameter == "useAndAfterHundred" {
            if var selfWithEnglishParameterProtocol = self as? EnglishParameterProtocol {
                selfWithEnglishParameterProtocol.useAndAfterHundred = value
            }
        }
    }
    
    func translate(_ s: String) -> Translation {
        let displayText = translator.translate(s)
//        var overline: String? = nil
//        if let i = Int(s) {
//            overline = read_OVERLINE(i)
//        }
        var spokenText: String? = nil
        if translator.code != nil {
            spokenText = displayText.replacingOccurrences(of: Translator.wordSplitter, with: " ")
            if let speakingPostProcessing = speakingPostProcessing {
                spokenText = speakingPostProcessing(spokenText!)
            }
        }
        return Translation(
            displayText: displayText,
            overline: nil,
            spokenText: spokenText)
    }
}
