//
//  VoiceSelection.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/29/23.
//


import SwiftUI
import AVFoundation

func hasMultipleVariants(_ list: [AVSpeechSynthesisVoice]) -> Bool {
    let variant = list.first?.variantCode ?? ""
    for voice in list {
        if voice.variantCode != variant { return true }
    }
    return false
}

struct VoiceSelection: View {
    
    var voiceDict: Voices.VoiceDict

    var callback: ((String, String) -> ())?
    
    init(voiceDict: Voices.VoiceDict, callback: ((String, String) -> ())?) {
        self.callback = callback
        self.voiceDict = voiceDict
    }
    
    struct OneVoiceView: View {
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
                ForEach(Array(voiceDict.keys), id: \.self) { code in
                    let name = languageName(code)
                    Section(header: Text(name)) {
                        ForEach(Array(voiceDict[code]!.dict.keys), id: \.self) { reducedIdentifier in
                            let (displayData, _) = voiceDict[code]!.dict[reducedIdentifier]!
                            OneVoiceView(displayData: displayData)
                                .onTapGesture {
                                    if let callback = callback {
                                        callback(reducedIdentifier, code)
                                    }
                                }
                        }
                    }
                }
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
    return VoiceSelection(voiceDict: ViewModel().languages.voices.voiceDict, callback: nil)
}
