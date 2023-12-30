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
    
    class SupportedLanguages {
        var dict: [String : VoiceLanguage] = [:]

        func has(_ code: String?) -> Bool {
            guard let code = code else { return false }
            return dict.keys.contains(code)
        }
    }
    
    let synthesizer = AVSpeechSynthesizer()
    var supportedLanguages = SupportedLanguages()
    
    
    func readAloud(_ text: String, in voice: AVSpeechSynthesisVoice) {
        if text.count > 0 {
            Task {
                let utterance = AVSpeechUtterance(string: text)
                utterance.voice = voice
                DispatchQueue.main.async {
                    self.synthesizer.speak(utterance)
                }
            }
        }
    }
    
    func getVoicesFor(translatorLanguages: [Language]) {
        Task {
            let allSystemVoices = AVSpeechSynthesisVoice.speechVoices()
            
            // remove dupliates
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
            
            for translatorLanguage in cleanLanguagesList {
                for systemVoice in allSystemVoices {
                    if systemVoice.languageCode == translatorLanguage.voiceLanguageCode {
                        if !supportedLanguages.has(systemVoice.languageCode) {
                            supportedLanguages.dict[systemVoice.languageCode] = VoiceLanguage(languageName: translatorLanguage.voiceLanguageName ?? "")
                        }
                        supportedLanguages.dict[systemVoice.languageCode]!.list.append(systemVoice)
                    }
                }
            }
            
            DispatchQueue.main.async {
                self.initDoneCallback()
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
}

