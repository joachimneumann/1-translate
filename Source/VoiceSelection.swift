//
//  VoiceSelection.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/29/23.
//


import SwiftUI
import AVFoundation

struct VoiceSelection: View {
    var voices: Voices
    let uniqueVoiceLanguageCodes: [String]
    
    init(voices: Voices) {
        self.voices = voices
        self.uniqueVoiceLanguageCodes = voices.uniqueVoiceLanguageCodes
    }
    
    struct OneVoiceView: View {
        let voice: AVSpeechSynthesisVoice
        let selected: Bool
        let showVariant: Bool
        
        var body: some View {
            let name = voice.name.replacingOccurrences(of: " (Premium)", with: "").replacingOccurrences(of: " (Enhanced)", with: "")
            HStack(spacing: 0) {
                Text(name)
                    .bold()
                if showVariant { Text(" (\(voice.variantCode))") }
                Text("  \(voice.qualityString)")
                    .bold()
                    .foregroundColor(.yellow)
                Spacer()
                if selected {
                    Image(systemName: "checkmark")
                        .bold()
                        .foregroundColor(.yellow)
                }
            }
            .contentShape(Rectangle())
            .listRowBackground(selected ? Color(white: 0.18) : Color(white: 0.1))
        }
    }
    
    func hasMultipleVariants(_ list: [AVSpeechSynthesisVoice]) -> Bool {
        let variant = list.first?.variantCode ?? ""
        for voice in list {
            if voice.variantCode != variant { return true }
        }
        return false
    }
    
    var body: some View {
        VStack {
            HStack(spacing: 0) {
                Text("Add Premium or Enhanced voices in ") +
                Text("Accessibility → Spoken Content → Voices")
                    .italic()
            }
            .padding(10)
            .multilineTextAlignment(.center)
            .frame(maxWidth: .infinity)
            .background(Color(white: 0.18))
            .cornerRadius(10.0)
            .padding(.horizontal, 20)
            .onTapGesture {
                if let url = URL(string: UIApplication.openSettingsURLString) {
                    UIApplication.shared.open(url)
                }
            }
            List {
                ForEach(uniqueVoiceLanguageCodes, id: \.self) { voiceLanguageCode in
                    let name = languageName(voiceLanguageCode)
                    Section(header: Text(name)) {
                        let voicesList = voices.voicesForCode(code: voiceLanguageCode)
                        let hasMultipleVariants = hasMultipleVariants(voicesList)
                        ForEach(voicesList, id: \.self) { voice in
                            let selectedID = voices.voiceIDFor(code: voiceLanguageCode)
                            let selected = (selectedID == voice.identifier)
                            OneVoiceView(voice: voice, selected: selected, showVariant: hasMultipleVariants)
                                .onTapGesture {
                                    voices.selectVoiceID(voice.identifier, for: voiceLanguageCode)
                                }
                        }
                    }
                }
//
//                ForEach(uniqueVoiceLanguageCodes) { code in
//                    let voicesList = voices.voicesForCode(code: code)
//                    let hasMultipleVariants = hasMultipleVariants(voicesList)
//                    Section(header: Text(languageName(code))) {
//                        ForEach(voicesList, id: \.self) { voice in
//                            let selectedID = voices.voiceIDFor(code: code)
////                            OneVoiceView(voice: voice,
////                                         selected: voice.identifier == selectedID,
////                                         showVariant: hasMultipleVariants)
//                            .onTapGesture {
//                                voices.setAndRemember(code, voice)
//                            }
//                        }
//                    }
//                }
            }
            .padding(.top, 10)
        }
        .navigationTitle("Voice Selector")
    }
    func languageName(_ code: String) -> String {
        let locale: Locale = .current
        let variant = locale.localizedString(forIdentifier: code)
        if let variant = variant {
            return variant + " (" + code + ")"
        }
        return code
    }
    
}


//#Preview {
//    return VoiceSelection(viewModel: ViewModel())
//}
