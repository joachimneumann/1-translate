//
//  VoiceSelection.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/29/23.
//


import SwiftUI
import AVFoundation

struct VoiceSelection: View {
    var viewModel: ViewModel
    
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
        let dict = viewModel.voicesForCode
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
                ForEach(dict.keys.sorted(), id: \.self) { code in
                    let hasMultipleVariants = hasMultipleVariants(dict[code]!.list)
                    Section(header: Text(languageName(code))) {
                        ForEach(dict[code]!.list, id: \.self) { voice in
                            OneVoiceView(voice: voice,
                                         selected: viewModel.selectedVoiceDict[code] == voice,
                                         showVariant: hasMultipleVariants)
                            .onTapGesture {
                                viewModel.setAndRemember(code, voice)
                            }
                            
                        }
                    }
                }
            }
            .padding(.top, 10)
        }
        .onAppear() {
            Task {
                viewModel.initVoice()
            }
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


#Preview {
    VoiceSelection(viewModel: ViewModel())
}
