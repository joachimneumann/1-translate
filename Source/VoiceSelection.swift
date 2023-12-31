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
            let name = voice.name.replacingOccurrences(of: " (Premium)", with: "").replacingOccurrences(of: " (Enhanced)", with: "")
            HStack {
                Text(voice.variantCode)
                    .bold()
                    .frame(width: 40)
                Text(name)
                Text(" \(voice.genderSting)")
                Text(" \(voice.qualityString)")
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

    var body: some View {
        let dict = viewModel.voicesForCode
        List {
            ForEach(dict.keys.sorted(), id: \.self) { code in
                Section(header: Text(languageName(code))) {
                    ForEach(dict[code]!.list, id: \.self) { voice in
                        OneVoiceView(voice: voice, selected: viewModel.selectedVoiceDict[code] == voice)
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
