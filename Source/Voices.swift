//
//  Voices.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/3/24.
//

import Foundation
import AVFoundation

@Observable class Voices {
    
    static let synthesizer = AVSpeechSynthesizer()
    var voiceDict: [String : AVSpeechSynthesisVoice] = [:]
    var uniqueVoiceLanguageCodes: [String] = []

    private func refreshVoiceDict() {
        voiceDict = [:]
        let allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
        for voice in allSystemVoices {
            if voice.identifier.contains("premium") {
                voiceDict[voice.identifier] = voice
            }
        }
        for voice in allSystemVoices {
            if voice.identifier.contains("enhanced") {
                let exists = voiceDict.keys.contains(voice.identifier.replacingOccurrences(of: "enhanced", with: "premium"))
                if !exists { voiceDict[voice.identifier] = voice }
            }
        }
        for voice in allSystemVoices {
            if voice.identifier.contains("compact") {
                let exists1 = voiceDict.keys.contains(voice.identifier.replacingOccurrences(of: "compact", with: "enhanced"))
                let exists2 = voiceDict.keys.contains(voice.identifier.replacingOccurrences(of: "compact", with: "premium"))
                if !exists1 && !exists2 { voiceDict[voice.identifier] = voice }
            }
        }
    }
    
    init() {
        refreshVoiceDict()
    }
    
    func readAloud(_ text: String, withId voiceIdentifier: String?) {
        if let voiceIdentifier = voiceIdentifier {
            let utterance = AVSpeechUtterance(string: text)
            utterance.voice = voiceDict[voiceIdentifier]
            Voices.synthesizer.speak(utterance)
        }
    }
    
    private func voiceIdentifierKey(_ code: String) -> String {
        code + "_voiceIdentifier"
    }
    
    func voicesForCode(code: String?) -> [AVSpeechSynthesisVoice] {
        var ret: [AVSpeechSynthesisVoice] = []
        if code != nil {
            for (_, voice) in voiceDict {
                if voice.languageCode == code {
                    ret.append(voice)
                }
            }
        }
        return ret
    }
    
    func selectVoiceID(_ voiceID: String, for code: String) {
        UserDefaults.standard.set(voiceID, forKey: voiceIdentifierKey(code))
    }
    
    func voiceIDFor(code: String?) -> String? {
        guard let code = code else { return nil }
        
        /// any voice identifiers stored in userdefaults?
        if let storedVoiceIdentifier = UserDefaults.standard.string(forKey: voiceIdentifierKey(code)) {
            return storedVoiceIdentifier
        }
        
        let voices = voicesForCode(code: code)
        
        /// guess the best voice
        var guess: String? = nil
        for voice in voices {
            if guess == nil {
                if voice.quality == .premium {
                    guess = voice.identifier
                }
            }
        }
        for voice in voices {
            if guess == nil {
                if voice.quality == .enhanced {
                    guess = voice.identifier
                }
            }
        }
        for voice in voices {
            if guess == nil {
                guess = voice.identifier
            }
        }
        if guess != nil {
            selectVoiceID(guess!, for: code)
        }
        return guess
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
