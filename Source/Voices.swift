//
//  Voices.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/28/23.
//

import Foundation
import AVFoundation

class Voices {
    var initDoneCallback: () -> () = {}
    
    //    class Speaker: Equatable {
    //        let name: String
    //        let quality: AVSpeechSynthesisVoiceQuality
    //        let gender: AVSpeechSynthesisVoiceGender
    //        init(_ name: String, _ quality: AVSpeechSynthesisVoiceQuality, _ gender: AVSpeechSynthesisVoiceGender) {
    //            self.name = name
    //            self.quality = quality
    //            self.gender = gender
    //        }
    //        static func == (lhs: Voices.Speaker, rhs: Voices.Speaker) -> Bool {
    //            return (lhs.name == rhs.name) && (lhs.quality == rhs.quality)
    //        }
    //    }
    //
    //    class Variant {
    //        let code: String
    //        var speakers: [Speaker] = []
    //        init(_ code: String) {
    //            self.code = code
    //            speakers = []
    //        }
    //
    //        func add(_ newSpeaker: Speaker) {
    //            if !speakers.contains(newSpeaker) {
    //                speakers.append(newSpeaker)
    //            }
    //        }
    //    }
    //
    //    class VoiceLanguage {
    //        let code: String
    //        var variants: [Variant] = []
    //
    //        init(_ code: String) {
    //            self.code = code
    //            variants = []
    //        }
    //
    //        func findOrCreate(_ code: String) -> Variant {
    //            for variant in variants {
    //                if variant.code == code { return variant }
    //            }
    //            let newVariant = Variant(code)
    //            variants.append(newVariant)
    //            return newVariant
    //        }
    //    }
    //
    //    class AllVoiceLanguages {
    //        var list: [VoiceLanguage]
    //
    //        init() {
    //            list = []
    //        }
    //
    //        func findOrCreate(_ code: String) -> VoiceLanguage {
    //            for language in list {
    //                if language.code == code { return language }
    //            }
    //            let newLanguage = VoiceLanguage(code)
    //            list.append(newLanguage)
    //            return newLanguage
    //        }
    //
    //        func has(_ languageCode: String) -> Bool {
    //            for language in list {
    //                if language.code == languageCode { return true}
    //            }
    //            return false
    //        }
    //
    //        func add(combinedCode: String,
    //                 name: String,
    //                 quality: AVSpeechSynthesisVoiceQuality,
    //                 gender: AVSpeechSynthesisVoiceGender) {
    //            let splitString = combinedCode.split(separator: "-")
    //            if splitString.count != 2 {
    //                fatalError("splitString.count = \(splitString.count)")
    //            }
    //
    //            let newLanguageCode = String(splitString[0])
    //            let newVariantCode = String(splitString[1])
    //
    //            let language = findOrCreate(newLanguageCode)
    //            let variant = language.findOrCreate(newVariantCode)
    //            let speaker = Speaker(name, quality, gender)
    //            variant.add(speaker)
    //        }
    //    }
    
    struct Voice {
        let variant: String
        let name: String
        let quality: AVSpeechSynthesisVoiceQuality
        let gender: AVSpeechSynthesisVoiceGender
    }
    
    class VoiceLanguage {
        let languageName: String
        var list: [AVSpeechSynthesisVoice]
        init(languageName: String) {
            self.languageName = languageName
            self.list = []
        }
        func guessBestVoice() -> AVSpeechSynthesisVoice? {
            guard list.count > 0 else { return nil }
            for voice in list {
                if voice.quality == .enhanced {
                    return voice
                }
            }
            for voice in list {
                if voice.quality == .premium {
                    return voice
                }
            }
            return list.first
        }
    }
    
    class SupportedLanguages {
        var dict: [String : VoiceLanguage] = [:]

        func has(_ code: String?) -> Bool {
            guard let code = code else { return false }
            return dict.keys.contains(code)
        }
    }
    
    let synthesizer = AVSpeechSynthesizer()
    var supportedLanguages = SupportedLanguages()
    
    
    func readAloud(_ text: String, in languageCode: String?) {
        if text.count > 0 {
            if let languageCode = languageCode {
                if let supportedLanguage = supportedLanguages.dict[languageCode] {
                    if supportedLanguage.list.count > 0 {
                        Task {
                            let utterance = AVSpeechUtterance(string: text)
                            utterance.voice = supportedLanguage.guessBestVoice()
                            DispatchQueue.main.async {
                                self.synthesizer.speak(utterance)
                            }
                        }
                    }
                }
            }
        }
    }
    
    func getVoicesFor(translatorLanguages: [Language]) {
        Task {
            let allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
            
            for translatorLanguage in translatorLanguages {
                if let translatorCode = translatorLanguage.code {
                    for systemVoice in allSystemVoices {
                        if systemVoice.language.prefix(2) == translatorCode {
                            if !supportedLanguages.has(translatorCode) {
                                supportedLanguages.dict[translatorCode] = VoiceLanguage(languageName: translatorLanguage.flagName)
                            }
                            supportedLanguages.dict[translatorCode]!.list.append(systemVoice)
                        }
                    }
                }
            }
            DispatchQueue.main.async {
                self.initDoneCallback()
            }
        }
    }
}
