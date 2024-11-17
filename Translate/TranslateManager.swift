//
//  TranslateManager.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/20/23.
//

import Foundation
import NumberTranslator
import SwiftUI

class TranslateManager: NumberTranslator, Identifiable {

    var result = TranslateResult()
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
        Color(AppleColor.darkGray)
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
            print(flagname(language))
            if !flagname(language).contains("Chinese") { // add chinese later to keep them together
                if let uiImage = AppleImage(named: flagname(language)), let averageHue = uiImage.averageHue {
                    //                print("\(averageHue) \(flagname(language))")
                    languagesWithHue.append((language: language, hue: averageHue))
                }
            }
        }
        
        // Sort by hue value, placing those with hue 0 at the end
        var sortedLanguages = languagesWithHue
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
        
        sortedLanguages.insert(.simplifiedChinese, at: 4)
        sortedLanguages.insert(.traditionalChinese, at: 4)
        sortedLanguages.insert(.financialChinese, at: 4)

        return sortedLanguages
    }}

import CoreImage

extension AppleImage {
    var averageHue: CGFloat? {
        let inputImage: CIImage
        
        #if canImport(UIKit)
        guard let ciImage = CIImage(image: self) else { return nil }
        inputImage = ciImage
        #elseif canImport(AppKit)
        guard let imageData = self.tiffRepresentation, let ciImage = CIImage(data: imageData) else { return nil }
        inputImage = ciImage
        #endif
        
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)
        
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull as Any])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
        
        #if canImport(UIKit)
        let averageColor = UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
        #elseif canImport(AppKit)
        let averageColor = NSColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
        #endif
        
        var hue: CGFloat = 0
        var saturation: CGFloat = 0
        var brightness: CGFloat = 0
        var alpha: CGFloat = 0
        
        averageColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
        if let h = averageHueValue(of: inputImage) {
            return h == 1.0 ? 0.001 : h
        }
        return 0.0//hue
    }
}

func averageHueValue(of ciImage: CIImage) -> CGFloat? {
    let context = CIContext()
    
    // Define the extent (area) of the image to average
    let extent = ciImage.extent
    
    // Create and configure the CIAreaAverage filter
    guard let areaAverageFilter = CIFilter(name: "CIAreaAverage") else {
        print("Failed to create CIAreaAverage filter.")
        return nil
    }
    areaAverageFilter.setValue(ciImage, forKey: kCIInputImageKey)
    areaAverageFilter.setValue(CIVector(x: extent.origin.x, y: extent.origin.y, z: extent.width, w: extent.height), forKey: "inputExtent")
    
    // Get the output image (1x1 pixel)
    guard let outputImage = areaAverageFilter.outputImage else {
        print("Failed to get output image from CIAreaAverage filter.")
        return nil
    }
    
    // Render the output image to extract the color data
    var bitmap = [UInt8](repeating: 0, count: 4) // RGBA format
    context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)
    
    // Extract RGBA components
    let red = CGFloat(bitmap[0]) / 255.0
    let green = CGFloat(bitmap[1]) / 255.0
    let blue = CGFloat(bitmap[2]) / 255.0
    
    // Convert RGBA to HSB
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var brightness: CGFloat = 0
    AppleColor(red: red, green: green, blue: blue, alpha: 1.0).getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: nil)
    
    return hue // Returns the average hue value (0.0 to 1.0)
}
