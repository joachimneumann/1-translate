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
    private let code: String
    private let languageName: String
    private var voiceDict: Voices.VoiceDict
    private var callback: ((String, String) -> ())?
    
    init(code: String, voiceDict: Voices.VoiceDict, callback: ((String, String) -> ())?) {
        self.code = code
        self.voiceDict = voiceDict
        self.callback = callback
        
        let locale: Locale = .current
        let variant = locale.localizedString(forIdentifier: code)
        if let variant = variant {
            languageName = variant + " (" + code + ")"
        } else {
            languageName = code
        }
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
            List {
                Section(header: Text("Voice for " + languageName)) {
                    VoiceListView(quality: .premium, code: code, voiceDict: voiceDict, callback: callback)
                    VoiceListView(quality: .enhanced, code: code, voiceDict: voiceDict, callback: callback)
                    VoiceListView(quality: .default, code: code, voiceDict: voiceDict, callback: callback)
                }
            }
            .padding(.top, 20)

            HStack(spacing: 0) {
                Text("Go to Settings to add Premium or Enhanced voices in ") +
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
        }
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
    return VoiceSelection(code: "en", voiceDict: ViewModel().voices.voiceDict, callback: nil)
}
