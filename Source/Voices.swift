//
//  Voices.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/3/24.
//

import Foundation
import AVFoundation

@Observable class Voices {
    class VoicesForCode {
        var list: [AVSpeechSynthesisVoice] = []
        let displayName: String = ""
    }

    var voicesForCode: [String : VoicesForCode] = [:]
    var selectedVoiceDict: [String: AVSpeechSynthesisVoice] = [:]

    private let synthesizer = AVSpeechSynthesizer()
    private var translatorLanguages: [Language] = []
    private var systemVoices: [AVSpeechSynthesisVoice] = []

    private func voiceKey(_ language: Language) -> String {
        language.flagName + "_voiceIdentifier"
    }
    private func voiceKey(_ code: String) -> String {
        code + "_voiceIdentifier"
    }

    private func setVoiceIfCodeMatches(code: String, voice: AVSpeechSynthesisVoice) {
        for var language in translatorLanguages {
            if language.voiceLanguageCode == code {
                language.voice = voice
                if language.synthesizer == nil {
                    language.synthesizer = synthesizer
                }
            }
        }
    }

    private func uniqueLanguageCodes(allLanguages: [Language]) -> [String] {
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
    
    func setAndRemember(_ code: String, _ voice: AVSpeechSynthesisVoice) {
        DispatchQueue.main.async {
            self.selectedVoiceDict[code] = voice
        }
        UserDefaults.standard.set(voice.identifier, forKey: voiceKey(code))
        setVoiceIfCodeMatches(code: code, voice: voice)
    }


    
    func populate(with languages: [Language]) {
        self.translatorLanguages = languages
        let allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
        systemVoices = []
        for systemVoice in allSystemVoices {
            if systemVoice.identifier.contains("premium") {
                systemVoices.append(systemVoice)
            }
        }
        for systemVoice in allSystemVoices {
            if systemVoice.identifier.contains("enhanced") {
                let check = systemVoice.identifier.replacingOccurrences(of: "enhanced", with: "premium")
                var exists = false
                for s in systemVoices { if s.identifier == check { exists = true } }
                if !exists { systemVoices.append(systemVoice) }
            }
        }
        for systemVoice in allSystemVoices {
            if systemVoice.identifier.contains("compact") {
                let check1 = systemVoice.identifier.replacingOccurrences(of: "compact", with: "enhanced")
                let check2 = systemVoice.identifier.replacingOccurrences(of: "compact", with: "premium")
                var exists = false
                for s in systemVoices { if s.identifier == check1 || s.identifier == check2 { exists = true } }
                if !exists { systemVoices.append(systemVoice) }
            }
        }

        let uniqueCodes = uniqueLanguageCodes(allLanguages: translatorLanguages)
        
        /// create voicesForCode dictionary
        assert(voicesForCode.keys.count == 0)
        for code in uniqueCodes {
            var list: [AVSpeechSynthesisVoice] = []
            for systemVoice in systemVoices {
                if systemVoice.languageCode == code {
                    list.append(systemVoice)
                }
            }
            if list.count > 0 {
                voicesForCode[code] = VoicesForCode()
                voicesForCode[code]?.list = list
            }
        }
        
        /// Are all voices nil?
        for language in translatorLanguages {
            assert(language.voice == nil)
        }
        
        /// any voice identifiers stored in userdefaults?
        for code in uniqueCodes {
            var found = false
            if let storedVoiceIdentifier = UserDefaults.standard.string(forKey: voiceKey(code)) {
                for systemVoice in systemVoices {
                    // print(systemVoice.description)
                    if systemVoice.identifier == storedVoiceIdentifier {
                        setVoiceIfCodeMatches(code: code, voice: systemVoice)
                        found = true
                        DispatchQueue.main.async {
                            self.selectedVoiceDict[code] = systemVoice
                        }
                    }
                }
            }
            if !found {
                /// guess the voice
                var guessedVoice: AVSpeechSynthesisVoice? = nil
                if let list = voicesForCode[code]?.list {
                    if list.count >= 1 { guessedVoice = list.first }
                    for voice in list { if voice.quality == .enhanced { guessedVoice = voice } }
                    for voice in list { if voice.quality == .premium { guessedVoice = voice } }
                    guard let guessedVoice = guessedVoice else { fatalError("failed guessing the initial voice for "+code) }
                    setAndRemember(code, guessedVoice)
                } else {
                    /// code not supported
                }
            }
        }
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
