//
//  VoiceSelection.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/29/23.
//


import SwiftUI
import AVFoundation

struct VoiceSelection: View {
    @ObservedObject var viewModel: ViewModel
    
    struct OneVoiceView: View {
        let voice: AVSpeechSynthesisVoice
        let selected: Bool
        let showVariant: Bool

        var body: some View {
            let name = voice.name.replacingOccurrences(of: " (Premium)", with: "").replacingOccurrences(of: " (Enhanced)", with: "")
            HStack(spacing: 0) {
                Text(name)
                    .bold()
                if showVariant { Text(" \(voice.variantCode),") }
                Text(" \(voice.genderSting)")
                Text("  \(voice.qualityString)")
                    .bold()
                    .foregroundColor(.yellow)
                Spacer()
                if selected {
                    Image(systemName: "checkmark")
                }
            }
            .contentShape(Rectangle())
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
        List {
            Text("Note: to add Premium or Enhanced voices, search for \"Spoken Content\" in the iOS settings app.")
                .onTapGesture {
                    if let url = URL(string: UIApplication.openSettingsURLString) {
                        UIApplication.shared.open(url)
                    }
                }
            ForEach(dict.keys.sorted(), id: \.self) { code in
                let hasMultipleVariants = hasMultipleVariants(dict[code]!.list)
                Section(header: Text(languageName(code))) {
                    ForEach(dict[code]!.list, id: \.self) { voice in
                        OneVoiceView(voice: voice, 
                                     selected: viewModel.selectedVoiceDict[code] == voice,
                                     showVariant: hasMultipleVariants)
                            .onTapGesture {
                                DispatchQueue.main.async {
                                    viewModel.selectedVoiceDict[code] = voice
                                    viewModel.setVoiceIfCodeMatches(allLanguages: viewModel.languages.list, code: code, voice: voice)
                                }
                            }
                    }
                }
            }
        }
        .onAppear() {
            Task {
                viewModel.initVoice()
            }
        }
        .navigationTitle("Select Voices")
    }
    func languageName(_ code: String) -> String {
        let XX: Locale = .current
        let XXX = XX.localizedString(forIdentifier: code)
        if let XXX = XXX {
            return XXX + " (" + code + ")"
        }
        return code
    }

}


#Preview {
    VoiceSelection(viewModel: ViewModel())
}
