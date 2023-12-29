//
//  Voice.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/28/23.
//

import Foundation
import AVFoundation

class Voice {
    class Speaker: Equatable {
        let name: String
        let quality: AVSpeechSynthesisVoiceQuality
        init(_ name: String, _ quality: AVSpeechSynthesisVoiceQuality) {
            self.name = name
            self.quality = quality
        }
        static func == (lhs: Voice.Speaker, rhs: Voice.Speaker) -> Bool {
            return (lhs.name == rhs.name) && (lhs.quality == rhs.quality)
        }
    }
    
    class Variant {
        let code: String
        var speakers: [Speaker] = []
        init(_ code: String) {
            self.code = code
            speakers = []
        }
        
        func add(_ newSpeaker: Speaker) {
            if !speakers.contains(newSpeaker) {
                speakers.append(newSpeaker)
            }
        }
    }
    
    class Language {
        let code: String
        var variants: [Variant] = []
        
        init(_ code: String) {
            self.code = code
            variants = []
        }
        
        func findOrCreate(_ code: String) -> Variant {
            for variant in variants {
                if variant.code == code { return variant }
            }
            let newVariant = Variant(code)
            variants.append(newVariant)
            return newVariant
        }
    }
    
    class AllLanguages {
        var languages: [Language]
        
        init() {
            languages = []
        }
        
        func has(_ languageCode: String) -> Bool {
            for language in languages {
                if language.code == languageCode { return true}
            }
            return false
        }
        
        func findOrCreate(_ code: String) -> Language {
            for language in languages {
                if language.code == code { return language }
            }
            let newLanguage = Language(code)
            languages.append(newLanguage)
            return newLanguage
        }
        
        func add(combinedCode: String, name: String, quality: AVSpeechSynthesisVoiceQuality) {
            let splitString = combinedCode.split(separator: "-")
            if splitString.count != 2 {
                fatalError("splitString.count = \(splitString.count)")
            }
            
            let newLanguageCode = String(splitString[0])
            let newVariantCode = String(splitString[1])
            
            let language = findOrCreate(newLanguageCode)
            let variant = language.findOrCreate(newVariantCode)
            let speaker = Speaker(name, quality)
            variant.add(speaker)
        }
    }
    
    let synthesizer = AVSpeechSynthesizer()
    var languages = AllLanguages()
    var supportedLanguages: [String] = []
    
    func getVoices() async {
        let voices = AVSpeechSynthesisVoice.speechVoices()
        for voice in voices {
            languages.add(combinedCode: voice.language, name: voice.name, quality: voice.quality)
        }
        print(languages)
    }
    
    init(languagesCodes: [String]) {
        Task {
            await getVoices()
            for languagesCode in languagesCodes {
                if languages.has(languagesCode) {
                    supportedLanguages.append(languagesCode)
                }
            }
        }
    }
}
