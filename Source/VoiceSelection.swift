//
//  VoiceSelection.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 12/29/23.
//

import SwiftUI
import AVFoundation

struct VoiceSelection: View {
    let viewModel: ViewModel

    struct LanguageSection : View {
        let viewModel: ViewModel
        let list: [AVSpeechSynthesisVoice]
        let voiceCode: String
        var body: some View {
            Section(header: Text(voiceCode)) {
                ForEach(list, id: \.self) { voice in
                    HStack {
                        Text(voice.variantCode)
                            .bold()
                            .frame(width: 40)
                        Text(voice.name + " \(voice.genderSting) \(voice.qualityString)")
                        Spacer()
                    }
                    .onTapGesture {
                        viewModel.voices.setVoices(voice, for: voiceCode)
                    }
                }
            }
        }
    }
    
    
    var body: some View {
        let dict = viewModel.voices.voicesForLanguage
//        let languages = Array(arrayLiteral: dict.keys)
        let languages = ["es", "de", "vi"]
        List {
            ForEach(languages, id: \.self) { language in
                LanguageSection(viewModel: viewModel, list: dict[language]!, voiceCode: language)
            }
        }
        .navigationTitle("Select Voice")
    }
}


#Preview {
    VoiceSelection(viewModel: ViewModel())
}

//struct LanguageSection : View {
//    let voicesList: [AVSpeechSynthesisVoice]
//    let languageCode: String
//    var body: some View {
//        Section(header: Text("languageCode") {
//            ForEach(voicesList, id: \.self) { voice in
//                HStack {
//                    Text(voice.name + " (\(voice.genderString) \(voice.qualityString))")
//                    Spacer()
//                }
//            }
//        }
//    }
//}
