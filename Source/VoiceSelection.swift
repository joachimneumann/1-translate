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
    
    @State private var selectedVoices: [String: AVSpeechSynthesisVoice] = [:]
    
    struct OneVoiceView: View {
        let voice: AVSpeechSynthesisVoice
        let code: String
        let selected: Bool

        var body: some View {
            HStack {
                Text(voice.variantCode)
                    .bold()
                    .frame(width: 40)
                Text(voice.name + " \(voice.genderSting) \(voice.qualityString)")
                Spacer()
                if selected {
                    Image(systemName: "checkmark")
                }
            }
        }
    }
    
    var body: some View {
        let dict = viewModel.voices.voicesForLanguage
        List {
            ForEach(dict.keys.sorted(), id: \.self) { language in
                Section(header: Text(language)) {
                    ForEach(dict[language]!, id: \.self) { voice in
                        OneVoiceView(voice: voice, code: language, selected: selectedVoices[language]?.identifier == voice.identifier)
                            .onTapGesture {
                                selectedVoices[language] = voice
                            }
                    }
                }
            }
        }
        .onAppear() {
            Task {
                viewModel.initVoice()
                for (language, list) in viewModel.voices.voicesForLanguage {
                    selectedVoices[language] = list.first
                    //print(language)
                }
            }
        }
    }
}


#Preview {
    VoiceSelection(viewModel: ViewModel())
}
