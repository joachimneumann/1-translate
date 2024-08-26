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
        let text = displayText.replacingOccurrences(of: Languages.WordSplitter, with: "")
        guard var overline = overline else { return text }
        overline = overline.replacingOccurrences(of: Languages.WordSplitter, with: "")
        return "<overline>" + overline + "</overline>" + text
    }
}

enum GroupSize: Int, Codable, CaseIterable {
    case three
    case four
    case five
    var int: Int {
        get {
            switch self {
            case .three: return 3
            case .four: return 4
            case .five: return 5
            }
        }
    }
    var string: String {
        get {
            switch self {
            case .three: return "3"
            case .four: return "4"
            case .five: return "2,3"
            }
        }
    }
}

@Observable class Language: Identifiable {
    var nameDescription: String? = nil
    var voiceLanguageCode: String? = nil
    let groupSize: GroupSize
    let translator: Translator

    var flagName: String {
        nameDescription != nil ? nameDescription! : translator.name
    }
    var nameWithDescription: String {
        translator.name + (nameDescription != nil ? "/"+nameDescription! : "")
    }
    var speakingPostProcessing: ((String) -> String)?

    init(_ translator: Translator, _ code: String?, _ groupSize: GroupSize) {
        self.translator = translator
        self.voiceLanguageCode = code
        self.groupSize = groupSize
    }
    
    func translate(_ s: String) -> Translation {
        let displayText = translator.translate(s)
//        var overline: String? = nil
//        if let i = Int(s) {
//            overline = read_OVERLINE(i)
//        }
        var spokenText: String? = nil
        if voiceLanguageCode != nil {
            spokenText = displayText.replacingOccurrences(of: Languages.WordSplitter, with: " ")
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

class GermanLanguage: Language {
    var capitalisation: Bool = false {
        didSet {
            if let german = self.translator as? GermanTranslator {
                german.capitalisation = capitalisation
            }
        }
    }
}

class EnglishLanguage: Language {
    var useAndAfterHundred: Bool = false {
        didSet {
            if let english = self.translator as? EnglishTranslator {
                english.useAndAfterHundred = useAndAfterHundred
            }
        }
    }
}

