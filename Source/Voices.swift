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
    var voicesForCode: [String : [AVSpeechSynthesisVoice]] = [:]

    private func voiceKey(_ language: Language) -> String {
        language.flagName + "_voiceIdentifier"
    }
    private func voiceKey(_ code: String) -> String {
        code + "_voiceIdentifier"
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
    
    func uniqueLanguageCodes(allLanguages: [Language]) -> [String] {
        var ret: [String] = []
        for language in allLanguages {
            if let language = language as? LanguageImpl {
                if let code = language.voiceLanguageCode {
                    if !ret.contains(code) {
                        ret.append(code)
                    }
                }
            }
        }
        return ret
    }
    
    func setVoiceIfCodeMatches(allLanguages: [Language], code: String, voice: AVSpeechSynthesisVoice) {
        for var language in allLanguages {
            if language.voiceLanguageCode == code {
                language.voice = voice
            }
        }
    }
    
    @Published var selectedVoiceDict: [String: AVSpeechSynthesisVoice] = [:]

    
    
    
    
    
    func selectedVoiceFor(allLanguages: [Language], code: String) -> AVSpeechSynthesisVoice! {
        for language in allLanguages {
            if language.voiceLanguageCode == code {
                return language.voice
            }
        }
        return nil
    }

    func getVoices(for translatorLanguages: [Language]) {
        Task {
            allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
            
            let uniqueCodes = uniqueLanguageCodes(allLanguages: translatorLanguages)
            
            /// create voicesForCode dictionary
            assert(voicesForCode.keys.count == 0)
            for code in uniqueCodes {
                var list: [AVSpeechSynthesisVoice] = []
                for systemVoice in allSystemVoices {
                    if systemVoice.languageCode == code {
                        list.append(systemVoice)
                    }
                }
                if list.count > 0 {
                    voicesForCode[code] = list
                }
            }
            
            /// Are all voices nil?
            for language in translatorLanguages {
                assert(language.voice == nil)
            }
            
            /// any voice identifiers stored in userdefaults?
            for code in uniqueCodes {
                if let storedVoiceIdentifier = UserDefaults.standard.string(forKey: voiceKey(code)) {
                    for systemVoice in allSystemVoices {
                        if systemVoice.identifier == storedVoiceIdentifier {
                            setVoiceIfCodeMatches(allLanguages: translatorLanguages, code: code, voice: systemVoice)
                            selectedVoiceDict[code] = systemVoice
                        }
                    }
                } else {
                    /// guess the voice
                    var guessedVoice: AVSpeechSynthesisVoice? = nil
                    if let list = voicesForCode[code] {
                        if list.count >= 1 { guessedVoice = list.first }
                        for voice in list { if voice.quality == .enhanced { guessedVoice = voice } }
                        for voice in list { if voice.quality == .premium { guessedVoice = voice } }
                        guard let guessedVoice = guessedVoice else { fatalError("failed guessing the initial voice for "+code) }
                        UserDefaults.standard.set(guessedVoice.identifier, forKey: voiceKey(code))
                        setVoiceIfCodeMatches(allLanguages: translatorLanguages, code: code, voice: guessedVoice)
                        selectedVoiceDict[code] = guessedVoice
                    } else {
                        /// code not supported
                    }
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
    var genderSting: String {
        self.gender.rawValue == 1 ? "male" : "female"
    }
    var qualityString: String {
        self.quality.rawValue == 3 ? "Premium" : (self.quality.rawValue == 2 ? "Enhanced" : "")
    }

}

