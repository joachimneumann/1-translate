//
//  Voice.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/28/23.
//

import Foundation
import AVFoundation

class Voice {
    var initDoneCallback: () -> () = {}
    class Speaker: Equatable {
        let name: String
        let quality: AVSpeechSynthesisVoiceQuality
        let gender: AVSpeechSynthesisVoiceGender
        init(_ name: String, _ quality: AVSpeechSynthesisVoiceQuality, _ gender: AVSpeechSynthesisVoiceGender) {
            self.name = name
            self.quality = quality
            self.gender = gender
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
                
        func findOrCreate(_ code: String) -> Language {
            for language in languages {
                if language.code == code { return language }
            }
            let newLanguage = Language(code)
            languages.append(newLanguage)
            return newLanguage
        }
        
        func has(_ languageCode: String) -> Bool {
            for language in languages {
                if language.code == languageCode { return true}
            }
            return false
        }

        func add(combinedCode: String,
                 name: String,
                 quality: AVSpeechSynthesisVoiceQuality,
                 gender: AVSpeechSynthesisVoiceGender) {
            let splitString = combinedCode.split(separator: "-")
            if splitString.count != 2 {
                fatalError("splitString.count = \(splitString.count)")
            }
            
            let newLanguageCode = String(splitString[0])
            let newVariantCode = String(splitString[1])
            
            let language = findOrCreate(newLanguageCode)
            let variant = language.findOrCreate(newVariantCode)
            let speaker = Speaker(name, quality, gender)
            variant.add(speaker)
        }
    }
    
    let synthesizer = AVSpeechSynthesizer()
    var allLanguages = AllLanguages()
    var supportedVoices: [String : AVSpeechSynthesisVoice] = [:]
    
    func getAllVoices() async {
        let allVoices = AVSpeechSynthesisVoice.speechVoices()
        for voice in allVoices {
            allLanguages.add(combinedCode: voice.language, name: voice.name, quality: voice.quality, gender: voice.gender)
        }
    }
    
    func has(_ code: String?) -> Bool {
        guard let code = code else { return false }
        return supportedVoices.keys.contains(code)
    }
    
    func read(_ text: String, in languageCode: String?) {
        if text.count > 0 {
            if let languageCode = languageCode {
                if let voice = supportedVoices[languageCode] {
                    let utterance = AVSpeechUtterance(string: text)
                    utterance.voice = voice
                    synthesizer.speak(utterance)
                }
            }
        }
    }

    init() {
    }
    
    func getVoicesFor(languages languagesCodes: [String]) {
        Task {
            await getAllVoices()
            for languagesCode in languagesCodes {
                if allLanguages.has(languagesCode) {
                    supportedVoices[languagesCode] = AVSpeechSynthesisVoice(language: languagesCode)
                }
            }
            DispatchQueue.main.async {
                self.initDoneCallback()
            }
        }
    }
}
