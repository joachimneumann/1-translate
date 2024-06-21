//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

struct Translation {
    let displayText: String
    let groupSize: GroupSize
    let overline: String?
    var spokenText: String?
    var copyText: String {
        let text = displayText.replacingOccurrences(of: Languages.WordSplitter, with: "")
        guard var overline = overline else { return text }
        overline = overline.replacingOccurrences(of: Languages.WordSplitter, with: "")
        return "<overline>" + overline + "</overline>" + text
    }
}

@Observable class Language: Identifiable {
    var name: String
    var nameDescription: String? = nil
    var voiceLanguageCode: String? = nil
    let groupSize: GroupSize

    var flagName: String {
        nameDescription != nil ? nameDescription! : name
    }
    var nameWithDescription: String {
        name + (nameDescription != nil ? "/"+nameDescription! : "")
    }
    var speakingPostProcessing: ((String) -> String)?

    init(name: String, groupSize: GroupSize) {
        self.name = name
        self.groupSize = groupSize
    }
    
    func read(_ s: String) -> String {
        fatalError("read() not implmented")
    }
    func read_OVERLINE(_ i: Int) -> String? {
        nil
    }

    func translate(_ s: String) -> Translation {
        let displayText = read(s)
        var overline: String? = nil
        if let i = Int(s) {
            overline = read_OVERLINE(i)
        }
        var spokenText: String? = nil
        if voiceLanguageCode != nil {
            spokenText = displayText.replacingOccurrences(of: Languages.WordSplitter, with: " ")
            if let speakingPostProcessing = speakingPostProcessing {
                spokenText = speakingPostProcessing(spokenText!)
            }
        }
        return Translation(
            displayText: displayText,
            groupSize: groupSize,
            overline: overline,
            spokenText: spokenText)
    }
}


