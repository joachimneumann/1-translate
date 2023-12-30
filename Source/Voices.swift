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
    
    var allSystemVoices: [AVSpeechSynthesisVoice] = []
    
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
//        func guessBestVoice() -> AVSpeechSynthesisVoice? {
//            guard list.count > 0 else { return nil }
//            for voice in list {
//                if voice.quality == .enhanced {
//                    return voice
//                }
//            }
//            for voice in list {
//                if voice.quality == .premium {
//                    return voice
//                }
//            }
//            return list.first
//        }
    }
        
    let synthesizer = AVSpeechSynthesizer()
    var voicesForLanguage: [String : [AVSpeechSynthesisVoice]] = [:]

        
    func getVoicesFor(translatorLanguages: [Language]) {
        Task {
            allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
            
            ///Preparation
            /// remove dupliate voice codes in the translation languages
            var tempUniqueCodes: [String] = []
            var cleanLanguagesList: [LanguageImpl] = []
            for translatorLanguage in translatorLanguages {
                if let translatorLanguage = translatorLanguage as? LanguageImpl {
                    if let code = translatorLanguage.voiceLanguageCode {
                        if !tempUniqueCodes.contains(code) {
                            tempUniqueCodes.append(code)
                            cleanLanguagesList.append(translatorLanguage)
                        }
                    }
                }
            }
            
            /// create voicesForLanguage dictionary
            for translatorLanguage in cleanLanguagesList {
                for systemVoice in allSystemVoices {
                    if systemVoice.languageCode == translatorLanguage.voiceLanguageCode {
                        if !voicesForLanguage.keys.contains(systemVoice.languageCode) {
                            voicesForLanguage[systemVoice.languageCode] = []
                        }
                        voicesForLanguage[systemVoice.languageCode]!.append(systemVoice)
                    }
                }
            }
            
            /// For all languages:
            ///      voice stored in userdefaults?
            ///      if not: guess best voice
            let defaults = UserDefaults.standard
            for language in translatorLanguages {
                print("looping, " + language.name)

                guard let language = language as? LanguageImpl else { continue }
                guard language.voice != nil else { fatalError("voices should be nil at the beginning") }
                guard language.voiceLanguageCode != nil else { continue } // no code -> no voice

                language.voice = nil
                let voiceKey = language.name + "_voiceIdentifier"
                let storedVoiceIdentifier = defaults.string(forKey: voiceKey)

                if let storedVoiceIdentifier = storedVoiceIdentifier {
                    print("found " + voiceKey + ": " + storedVoiceIdentifier)
                    for systemVoice in allSystemVoices {
                        if systemVoice.identifier == storedVoiceIdentifier {
                            language.voice = systemVoice
                            continue
                        }
                    }
                }

                if let voiceList = voicesForLanguage[language.voiceLanguageCode!] {
                    language.voice = getBestVoice(in: voiceList)
                    defaults.set(language.voice!.identifier, forKey: voiceKey)
                    print("set " + voiceKey)
                }
            }
            
            DispatchQueue.main.async {
                self.initDoneCallback()
            }
        }
    }
    
    func getBestVoice(in voiceList: [AVSpeechSynthesisVoice]) -> AVSpeechSynthesisVoice? {
        for voice in voiceList { if voice.quality == .premium { return voice } }
        for voice in voiceList { if voice.quality == .enhanced { return voice } }
        if voiceList.count >= 1 { return voiceList.first }
        return nil
    }
}

extension AVSpeechSynthesisVoice {
    var languageCode: String {
        String(self.language.split(separator: "-")[0])
    }
    var variantCode: String {
        String(self.language.split(separator: "-")[1])
    }
}

