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
    
    func read(_ i: Int) -> String {
        var ret: String
        if i == 0 {
            ret = zero ?? "zero unknown"
        } else if i < 0 {
            if !allowNegativeNumbers {
                ret = "negative unknown"
            } else {
                ret = negativeString + afterNegative + read(-i)
            }
        } else {
            if i <= 0 {
                fatalError("read() negative integer \(i)")
            }
            if i > 999_999_999_999_999 { fatalError("read() too large parameter \(i)") }
            ret = read_positive(i)
        }
        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret
    }

    func read(_ s: String) -> String {
        // exponent and mantissa part
        var parts = s.components(separatedBy: "e")
        guard parts.count > 0 && parts.count <= 2 else { return LanguageError }
        let mantissa = parts[0]
        let exponentAsString: String? = (parts.count == 2) ? parts[1] : nil
        guard allowExponent || parts.count == 1 else { return "scientific notation not known" }

        // integer part and fractional part
        parts = mantissa.components(separatedBy: ".")
        guard parts.count > 0 && parts.count <= 2 else { return LanguageError }
        let integerPart = parts[0]
        let fractionalPart: String? = (parts.count == 2) ? parts[1] : nil
        guard allowFraction || fractionalPart == nil else { return "fractions not known" }

        var ret: String = ""
        if integerPart == "-0" && fractionalPart != nil { // e.g. -0.7 !!!
            if let zero = zero {
                ret = negativeString + afterNegative + zero
            } else {
                return "zero unknown"
            }
        } else {
            guard let integerPartInt = Int(integerPart) else { return LanguageError }
            ret = read(integerPartInt)
        }
        
        if let fractionalPart = fractionalPart {
            var count = 0
            ret += beforeAndAfterDotString + dotString
            for char in fractionalPart {
                if count < 10 {
                    guard let digit = Int(String(char)) else { return LanguageError }
                    ret += beforeAndAfterDotString + read_positive(digit)
                }
                count += 1
            }
            if count >= 10 {
                ret += "..."
            }
        }

        if let exponentAsString = exponentAsString {
            ret += exponentString + read(exponentAsString)
        }

        if let postProcessing = postProcessing {
            ret = postProcessing(ret)
        }
        return ret;
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

