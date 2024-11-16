//
//  TranslateiOSVoices.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 1/3/24.
//

import Foundation
import AVFoundation
import NumberTranslator

@Observable class TranslateiOSVoices {
    let numberTranslator: NumberTranslator
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

    init(numberTranslator: NumberTranslator) {
        self.numberTranslator = numberTranslator
    }
    
    func updateSelectedVoice(reducedIdentifier: String, for code: String) {
        UserDefaults.standard.set(reducedIdentifier, forKey: code.voiceIdentifierKey)
        refreshVoiceDict()
    }
    
    func refreshVoiceDict() {
        var uniqueVoiceLanguageCodes: [String] = []
        for l in NumberTranslator.LanguageEnum.allCases {
            if let code = numberTranslator.code(l) {
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
    
    
    func readAloud(_ text: String, in language: NumberTranslator.LanguageEnum) {
        
        /// also speak when the phone is in silent mode
        if AVAudioSession.sharedInstance().category != .playback {
            do {
                try AVAudioSession.sharedInstance().setCategory(.playback,mode: .default)
            } catch _ {
                return
                /// } catch let error {
                /// fatalError("AVAudioSession: could not set category: \(error.localizedDescription)")
            }
        }


        guard let voiceLanguageCode = numberTranslator.code(language) else { return }
        guard let (selectedID, dict) = voiceDict[voiceLanguageCode] else { return }
        guard let selectedID = selectedID else { return }
        guard let (_, voice) = dict[selectedID] else { return }

        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = voice
        TranslateiOSVoices.synthesizer.speak(utterance)
    }
}


import SwiftUI
import AVFoundation

class SpeechManager: NSObject, ObservableObject, AVSpeechSynthesizerDelegate {
    @Published var isSpeaking = false
    private let synthesizer = AVSpeechSynthesizer()

    override init() {
        super.init()
        synthesizer.delegate = self
    }

    func speak(text: String) {
        isSpeaking = true
        let utterance = AVSpeechUtterance(string: text)
        synthesizer.speak(utterance)
    }

    // Delegate Methods
    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didFinish utterance: AVSpeechUtterance) {
        isSpeaking = false
    }

    func speechSynthesizer(_ synthesizer: AVSpeechSynthesizer, didCancel utterance: AVSpeechUtterance) {
        isSpeaking = false
    }
}

struct ContentView: View {
    @StateObject private var speechManager = SpeechManager()
    @State private var textToSpeak = "Hello, world!"

    var body: some View {
        VStack {
            TextField("Enter text", text: $textToSpeak)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button(action: {
                speechManager.speak(text: textToSpeak)
            }) {
                Text(speechManager.isSpeaking ? "Speaking..." : "Speak")
            }
            .disabled(speechManager.isSpeaking)
            .padding()
        }
        .padding()
    }
}













extension String {
    fileprivate var voiceIdentifierKey: String {
        self + "_voiceIdentifier"
    }
}


extension AVSpeechSynthesisVoiceQuality {
    fileprivate var string: String {
        switch self {
        case .enhanced: return "Enhanced"
        case .premium: return "Premium"
        default: return "Default"
        }
    }
}
//    var variantCode: String {
//        String(self.language.split(separator: "-")[1])
//    }
//    fileprivate var reducedIdentifier: String {
//        self.identifier
//            .replacingOccurrences(of: ".premium", with: "")
//            .replacingOccurrences(of: ".enhanced", with: "")
//            .replacingOccurrences(of: ".compact", with: "")
//            .replacingOccurrences(of: ".eloquence", with: "")
//    }
//}


extension AVSpeechSynthesisVoice {
    fileprivate var languageCode: String {
        String(self.language.split(separator: "-")[0])
    }
    var variantCode: String {
        String(self.language.split(separator: "-")[1])
    }
    fileprivate var reducedIdentifier: String {
        self.identifier
            .replacingOccurrences(of: ".premium", with: "")
            .replacingOccurrences(of: ".enhanced", with: "")
            .replacingOccurrences(of: ".compact", with: "")
            .replacingOccurrences(of: ".eloquence", with: "")
    }
}
