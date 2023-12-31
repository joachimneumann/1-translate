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
    @State var status = "xx"
    var body: some View {
        let dict = viewModel.voices.voicesForCode
        List {
            Text(status)
            ForEach(dict.keys.sorted(), id: \.self) { code in
                Section(header: Text(code)) {
                    ForEach(dict[code]!, id: \.self) { voice in
                        OneVoiceView(voice: voice, selected: viewModel.voices.selectedVoiceDict[code] == voice)
                            .onTapGesture {
                                status = code + " " + voice.identifier
                                viewModel.voices.selectedVoiceDict[code] = voice
                                viewModel.voices.setVoiceIfCodeMatches(allLanguages: viewModel.languages.list, code: code, voice: voice)
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
    }
}


#Preview {
    VoiceSelection(viewModel: ViewModel())
}
