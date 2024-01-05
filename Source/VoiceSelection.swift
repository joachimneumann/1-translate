//
//  VoiceSelection.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/29/23.
//


import SwiftUI
import AVFoundation

private func hasMultipleVariants(_ list: [AVSpeechSynthesisVoice]) -> Bool {
    let variant = list.first?.variantCode ?? ""
    for voice in list {
        if voice.variantCode != variant { return true }
    }
    return false
}

struct VoiceSelection: View {
    private var voiceDict: Voices.VoiceDict
    private var callback: ((String, String) -> ())?
    
    init(voiceDict: Voices.VoiceDict, callback: ((String, String) -> ())?) {
        self.callback = callback
        self.voiceDict = voiceDict
    }
    
    private func languageName(_ code: String) -> String {
        let locale: Locale = .current
        let variant = locale.localizedString(forIdentifier: code)
        if let variant = variant {
            return variant + " (" + code + ")"
        }
        return code
    }
    
    private struct VoiceView: View {
        let displayData: Voices.VoiceDisplayData
        
        var body: some View {
            HStack(spacing: 0) {
                Text(displayData.name)
                    .bold()
                if displayData.variant != nil {
                    Text(" " + displayData.variant!)
                }
                if displayData.quality != nil {
                    Text(" " + displayData.quality!)
                        .bold()
                        .foregroundColor(.yellow)
                }
                Spacer()
                if displayData.selected {
                    Image(systemName: "checkmark")
                        .bold()
                        .foregroundColor(.yellow)
                }
            }
            .contentShape(Rectangle())
            .listRowBackground(displayData.selected ? Color(white: 0.18) : Color(white: 0.1))
        }
    }
    
    private struct VoiceListView: View {
        let quality: AVSpeechSynthesisVoiceQuality
        let code: String
        let voiceDict: Voices.VoiceDict
        let callback: ((String, String) -> ())?
        
        var body: some View {
            ForEach(Array(voiceDict[code]!.dict.keys).sorted(), id: \.self) { reducedIdentifier in
                let (displayData, voice) = voiceDict[code]!.dict[reducedIdentifier]!
                if voice.quality == quality {
                    VoiceView(displayData: displayData)
                        .onTapGesture {
                            if let callback = callback {
                                callback(reducedIdentifier, code)
                            }
                        }
                }
            }
        }
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
                ForEach(Array(voiceDict.keys.sorted()), id: \.self) { code in
                    let name = languageName(code)
                    Section(header: Text(name)) {
                        VoiceListView(quality: .premium, code: code, voiceDict: voiceDict, callback: callback)
                        VoiceListView(quality: .enhanced, code: code, voiceDict: voiceDict, callback: callback)
                        VoiceListView(quality: .default, code: code, voiceDict: voiceDict, callback: callback)
                    }
                }
            }
            .padding(.top, 10)
        }
        .navigationTitle("Voice Selector")
    }
}

extension AVSpeechSynthesisVoiceQuality {
    var string: String? {
        switch self {
        case .premium: "Premium"
        case .enhanced: "Enhanced"
        default: nil
            
        }
    }
}

#Preview {
    return VoiceSelection(voiceDict: ViewModel().voices.voiceDict, callback: nil)
}
