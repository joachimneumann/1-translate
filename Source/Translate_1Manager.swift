//
//  XNumberTranslator.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation
import NumberTranslator
import SwiftUI

class TranslationResult: ObservableObject, CustomDebugStringConvertible {
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

class Translate_1Manager: NumberTranslator, Identifiable {

    var result = TranslationResult()
    var hasVoice: Bool = false

    func flagname(_ language: NumberTranslator.LanguageEnum) -> String {
        englishName(language) ?? name(language)
    }

    func languageEnum(forFlagname: String) -> LanguageEnum? {
        for language in NumberTranslator.LanguageEnum.allCases {
            if forFlagname == flagname(language) {
                return language
            }
        }
        return nil
    }

    func generalLanguage(forEnum languageEnum: LanguageEnum) -> GeneralLanguage? {
        languageImplementation[languageEnum]
    }

    
    func borderColor(_ language: NumberTranslator.LanguageEnum) -> Color {
        Color(UIColor.darkGray)
    }

    func nameWithDescription(_ language: NumberTranslator.LanguageEnum) -> String {
        language.rawValue + (englishName(language) != nil ? "/"+englishName(language)! : "")
    }

    var speakingPostProcessing: ((String) -> String)?

    func translateThis(_ s: String, to language: NumberTranslator.LanguageEnum) {
        var overlineAndText = super.translate(s, to: language)
        DispatchQueue.main.async {
            if overlineAndText.starts(with: "Error: ") {
                overlineAndText = overlineAndText.replacingOccurrences(of: "Error: ", with: "")
                self.result.error = true
            } else {
                self.result.error = false
            }
            if overlineAndText.contains("_OVERLINE_") {
                let parts = overlineAndText.split(separator: "_OVERLINE_")
                if parts.count == 1 {
                    self.result.overline = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                    self.result.displayText = ""
                }
                if parts.count == 2 {
                    self.result.overline = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                    self.result.displayText = String(parts[1]).trimmingCharacters(in: .whitespacesAndNewlines)
                }
            } else {
                self.result.displayText = overlineAndText
                self.result.overline = nil
            }
            if self.code(language) != nil && self.hasVoice {
                self.result.spokenText = overlineAndText.replacingOccurrences(of: "\u{200A}", with: "")
                if let speakingPostProcessing = self.speakingPostProcessing {
                    self.result.spokenText = speakingPostProcessing(self.result.spokenText!)
                }
            }
        }
    }
        
    var sortedlanguages: [LanguageEnum] {
        var languagesWithHue: [(language: LanguageEnum, hue: CGFloat)] = []
        
        for language in languageImplementation.keys {
            if let uiImage = UIImage(named: flagname(language)),
               let averageHue = uiImage.averageHue {
                languagesWithHue.append((language: language, hue: averageHue))
            }
        }
        
        // Sort by hue value, placing those with hue 0 at the end
        let sortedLanguages = languagesWithHue
            .sorted {
                if $0.hue == 0 && $1.hue != 0 {
                    return false
                } else if $0.hue != 0 && $1.hue == 0 {
                    return true
                } else {
                    return $0.hue < $1.hue
                }
            }
            .map { $0.language }
        
        return sortedLanguages
    }}


extension UIImage {
    var averageHue: CGFloat? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        let average = UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)

        var hue        : CGFloat = 0
        var saturation : CGFloat = 0
        var brightness : CGFloat = 0
        var alpha      : CGFloat = 0
        let couldBeConverted = average.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if couldBeConverted {
            return hue
        }
        return nil
    }
}
