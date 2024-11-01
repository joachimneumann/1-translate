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
    var debugDescription: String {
        "\((overline != nil) ? overline!+" " : "")\(displayText)"
    }
}

class TranslationManager: NumberTranslator, Identifiable {

    var currentLanguage: NumberTranslator.Language = .english
    var result = TranslationResult()
    var hasVoice: Bool = false
    
    func flagName(_ language: NumberTranslator.Language) -> String {
        englishName(language) ?? name(language)
    }

    var borderColor: Color? {
        switch name(currentLanguage) {
        case "Deutsch":
            return Color(UIColor.lightGray)
        case "English":
            return Color(UIColor.lightGray)
        default:
            return nil
        }
    }

    var code: String? { code(currentLanguage) }
    var groupSize: Int { groupSize(currentLanguage) }

    func nameWithDescription(_ language: NumberTranslator.Language) -> String {
        language.rawValue + (englishName(language) != nil ? "/"+englishName(language)! : "")
    }
    var nameWithDescription: String { nameWithDescription(currentLanguage) }

    var speakingPostProcessing: ((String) -> String)?

    private func translateThis(_ s: String, to language: NumberTranslator.Language) {
        let overlineAndText = translate(s, to: language)
        if overlineAndText.contains("OVERLINE") {
            let parts = overlineAndText.split(separator: "OVERLINE")
            if parts.count == 1 {
                result.overline = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                result.displayText = ""
            }
            if parts.count == 2 {
                result.overline = String(parts[0]).trimmingCharacters(in: .whitespacesAndNewlines)
                result.displayText = " " + String(parts[1]).trimmingCharacters(in: .whitespacesAndNewlines)
            }
        } else {
            result.displayText = overlineAndText.trimmingCharacters(in: .whitespacesAndNewlines)
        }
        if code(language) != nil && hasVoice {
            result.spokenText = overlineAndText.replacingOccurrences(of: "\u{200A}", with: "")
            if let speakingPostProcessing {
                result.spokenText = speakingPostProcessing(result.spokenText!)
            }
        }
    }
    
    func translate(_ s: String) {
        translateThis(s, to: currentLanguage)
    }
    
    var implementedFlagnames: [String] {
        var flagnamesWithHue: [(name: String, hue: CGFloat)] = []
        
        for language in languageImplementation.keys {
            if let uiImage = UIImage(named: flagName(language)),
               let averageHue = uiImage.averageHue {
                flagnamesWithHue.append((name: flagName(language), hue: averageHue))
            }
        }
        
        // Sort by hue value, placing those with hue 0 at the end
            let sortedFlagNames = flagnamesWithHue
                .sorted {
                    if $0.hue == 0 && $1.hue != 0 {
                        return false
                    } else if $0.hue != 0 && $1.hue == 0 {
                        return true
                    } else {
                        return $0.hue < $1.hue
                    }
                }
                .map { $0.name }
            
            return sortedFlagNames
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
