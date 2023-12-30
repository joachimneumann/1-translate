//
//  Voices.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/28/23.
//

import Foundation
import AVFoundation

class Voices {
    var translatorLanguages: [Language] = []
    var initDoneCallback: () -> () = {}
    var allSystemVoices: [AVSpeechSynthesisVoice] = []
    let synthesizer = AVSpeechSynthesizer()
    var voicesForLanguage: [String : [AVSpeechSynthesisVoice]] = [:]

    private func voiceKey(_ language: Language) -> String {
        language.flagName + "_voiceIdentifier"
    }

    private func setVoice(_ voice: AVSpeechSynthesisVoice, for language: LanguageImpl) {
        language.voice = voice
        UserDefaults.standard.set(language.voice!.identifier, forKey: voiceKey(language))
    }
    func setVoices(_ voice: AVSpeechSynthesisVoice, for code: String) {
        for language in translatorLanguages {
            if let language = language as? LanguageImpl {
                if language.voiceLanguageCode == code {
                    setVoice(voice, for: language)
                }
            }
        }
    }

    func getVoices(for translatorLanguages: [Language]) {
        Task {
            allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
            
            ///Preparation
            /// remove dupliate voice codes in the translation languages
            var tempUniqueCodes: [String] = []
            var cleanLanguagesList: [LanguageImpl] = []
            for language in translatorLanguages {
                if let language = language as? LanguageImpl {
                    if let code = language.voiceLanguageCode {
                        if !tempUniqueCodes.contains(code) {
                            tempUniqueCodes.append(code)
                            cleanLanguagesList.append(language)
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
            for language in translatorLanguages {
                print("looping, " + language.name)

                guard let language = language as? LanguageImpl else { continue }
                guard language.voice == nil else { fatalError("voices should be nil at the beginning") }
                guard language.voiceLanguageCode != nil else { continue } // no code -> no voice

                language.voice = nil
                let storedVoiceIdentifier = UserDefaults.standard.string(forKey: voiceKey(language))

                if let storedVoiceIdentifier = storedVoiceIdentifier {
                    print("found " + voiceKey(language) + ": " + storedVoiceIdentifier)
                    for systemVoice in allSystemVoices {
                        if systemVoice.identifier == storedVoiceIdentifier {
                            language.voice = systemVoice
                            continue
                        }
                    }
                }

                guard language.voice == nil else { continue }
                if let voiceList = voicesForLanguage[language.voiceLanguageCode!] {
                    if let best = getBestVoice(in: voiceList) {
                        setVoice(best, for: language)
                    }
                }
            }
            
            self.translatorLanguages = translatorLanguages
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
    var genderSting: String {
        self.gender.rawValue == 1 ? "male" : "female"
    }
    var qualityString: String {
        self.quality.rawValue == 3 ? "Premium" : (self.quality.rawValue == 2 ? "Enhanced" : "")
    }

}

