//
//  Voices.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/3/24.
//

import Foundation
import AVFoundation

@Observable class Voices {
    struct VoiceDisplayData {
        let variant: String?
        let name: String
        let quality: String?
        var selected: Bool
        init(variant: String?, name: String, quality: String?, selected: Bool) {
            self.variant = variant
            self.name = name
            self.quality = quality
            self.selected = selected
        }
    }
    typealias DisplayDataAndVoice = (displayData: VoiceDisplayData, voice: AVSpeechSynthesisVoice)
    typealias DictOfReducedIdentifiers = [String : DisplayDataAndVoice]
    typealias SelectedIDAndDict = (selectedId: String?, dict: DictOfReducedIdentifiers)
    typealias VoiceDict = [String : SelectedIDAndDict]
    static let synthesizer = AVSpeechSynthesizer()
    var voiceDict: VoiceDict = [:]


    init() {}
    
    func updateSelectedVoice(reducedIdentifier: String, for code: String, languageList: [Language]) {
        UserDefaults.standard.set(reducedIdentifier, forKey: code.voiceIdentifierKey)
        refreshVoiceDict(list: languageList)
    }
    
    func refreshVoiceDict(list: [Language]) {
        var uniqueVoiceLanguageCodes: [String] = []
        for language in list {
            if let code = language.voiceLanguageCode {
                if !uniqueVoiceLanguageCodes.contains(code) {
                    uniqueVoiceLanguageCodes.append(code)
                }
            }
        }

        let allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
        
        /// populate dict
        for code in uniqueVoiceLanguageCodes {
            voiceDict[code] = (nil, [:])

            /// presistent selectedId?
            if let storedVoiceIdentifier = UserDefaults.standard.string(forKey: code.voiceIdentifierKey) {
                var exists = false
                for voice in allSystemVoices {
                    if storedVoiceIdentifier == voice.reducedIdentifier { exists = true }
                }
                if exists {
                    voiceDict[code]!.selectedId = storedVoiceIdentifier
                }
            }

            /// premium?
            for voice in allSystemVoices {
                if voice.languageCode == code {
                    if !voiceDict[code]!.dict.keys.contains(voice.reducedIdentifier) {
                        if voice.identifier.contains("premium") {
                            if voiceDict[code]!.selectedId == nil {
                                voiceDict[code]!.selectedId = voice.reducedIdentifier
                            }
                            let displayData = VoiceDisplayData(
                                variant: voice.variantCode,
                                name: voice.name.replacingOccurrences(of: " (Premium)", with: ""),
                                quality: voice.quality.string,
                                selected: voiceDict[code]!.selectedId != nil && voiceDict[code]!.selectedId == voice.reducedIdentifier)
                            voiceDict[code]!.dict[voice.reducedIdentifier] = (displayData, voice)
                        }
                    }
                }
            }

            /// enhanced?
            for voice in allSystemVoices {
                if voice.languageCode == code {
                    if !voiceDict[code]!.dict.keys.contains(voice.reducedIdentifier) {
                        if voice.identifier.contains("enhanced") {
                            if voiceDict[code]!.selectedId == nil {
                                voiceDict[code]!.selectedId = voice.reducedIdentifier
                            }
                            let displayData = VoiceDisplayData(
                                variant: voice.variantCode,
                                name: voice.name.replacingOccurrences(of: " (Enhanced)", with: ""),
                                quality: voice.quality.string,
                                selected: voiceDict[code]!.selectedId != nil && voiceDict[code]!.selectedId == voice.reducedIdentifier)
                            voiceDict[code]!.dict[voice.reducedIdentifier] = (displayData, voice)
                        }
                    }
                }
            }
            
            /// enhanced?
            for voice in allSystemVoices {
                if voice.languageCode == code {
                    if !voiceDict[code]!.dict.keys.contains(voice.reducedIdentifier) {
                        if voice.identifier.contains("compact") {
                            if voiceDict[code]!.selectedId == nil {
                                voiceDict[code]!.selectedId = voice.reducedIdentifier
                            }
                            let displayData = VoiceDisplayData(
                                variant: voice.variantCode,
                                name: voice.name,
                                quality: voice.quality.string,
                                selected: voiceDict[code]!.selectedId != nil && voiceDict[code]!.selectedId == voice.reducedIdentifier)
                            voiceDict[code]!.dict[voice.reducedIdentifier] = (displayData, voice)
                        }
                    }
                }
            }

            /// no voice found?
            if voiceDict[code]!.selectedId == nil {
                voiceDict[code] = nil
            }
        }
    }
    
    
    func readAloud(_ text: String, in language: Language) {
        guard let voiceLanguageCode = language.voiceLanguageCode else { return }
        guard let (selectedID, dict) = voiceDict[voiceLanguageCode] else { return }
        guard let selectedID = selectedID else { return }
        guard let (_, voice) = dict[selectedID] else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        Voices.synthesizer.speak(utterance)
    }
}

private extension String {
    var voiceIdentifierKey: String {
        self + "_voiceIdentifier"
    }
}



extension AVSpeechSynthesisVoice {
    var languageCode: String {
        String(self.language.split(separator: "-")[0])
    }
    var variantCode: String {
        String(self.language.split(separator: "-")[1])
    }
    var reducedIdentifier: String {
        self.identifier
            .replacingOccurrences(of: ".premium", with: "")
            .replacingOccurrences(of: ".enhanced", with: "")
            .replacingOccurrences(of: ".compact", with: "")
            .replacingOccurrences(of: ".eloquence", with: "")
    }
}
