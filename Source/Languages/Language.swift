//
//  Language.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation

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

@Observable class Language: Identifiable {
    var name: String
    var nameDescription: String? = nil
    let zero: String?
    var negativeString: String
    var dotString: String
    var beforeAndAfterDotString: String = " "
    var exponentString: String
    var voiceLanguageCode: String? = nil
    var allowNegativeNumbers = true
    var afterNegative = " "
    var postProcessing: ((String) -> String)? = nil
    var speakingPostProcessing: ((String) -> String)?
    func read_OVERLINE(_ i: Int) -> String? { nil }
    let LanguageError = "ERROR"
    var allowExponent = true
    var allowFraction = true
    var flagName: String { nameDescription != nil ? nameDescription! : name }

    var nameWithDescription: String {
        name + (nameDescription != nil ? "/"+nameDescription! : "")
    }
    
    init(name: String,
         zero: String?,
         negativeString: String,
         dotString: String,
         exponentString: String) {
        self.name = name
        self.zero = zero
        self.negativeString = negativeString
        self.dotString = dotString
        self.exponentString = exponentString
    }

    func _0_9(_ i: Int) -> String {
        fatalError("_0_9() not implmented")
    }

    func read_positive(_ i: Int) -> String {
        fatalError("read_positive() not implmented")
    }
    
    func read(_ s: String) -> String {
        fatalError("read_positive() not implmented")
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
            overline: overline,
            spokenText: spokenText)
    }

}


extension Int {
    func E(_ i: Int) -> Int {
        let factor = Int(pow(10.0, Double(i)))
        return self / factor
    }
    func Ex(_ i: Int) -> Int {
        let factor = Int(pow(10.0, Double(i)))
        
        return self - self / factor * factor
    }
    var pow10: Int { Int(pow(10.0, Double(self))) }
    var secondLastDigit: Int { (self /  10) % 10 }
    var thirdLastDigit:  Int { (self / 100) % 10 }
}

