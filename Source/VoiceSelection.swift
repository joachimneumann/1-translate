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
        let voiceLanguage: Voices.VoiceLanguage
        let languageCode: String
        var body: some View {
            Section(header: Text(voiceLanguage.languageName + " (" + languageCode + ")")) {
                let showVariant = voiceLanguage.list.count > 2
                ForEach(voiceLanguage.list, id: \.self) { voice in
                    let speakerGender = voice.gender.rawValue == 1 ? "male" : "female"
                    let speakerQuality = voice.quality.rawValue == 1 ? "" : (voice.quality.rawValue == 2 ? "Enhanced" : "Premium")
                    let variant = !showVariant || (voice.variantCode == "001") ? "" : ", "+voice.variantCode
                    HStack {
                        Text(voice.name + " (\(speakerGender)\(variant)) \(speakerQuality)")
                    }
                }
            }
        }
    }
    
    var body: some View {
        let dict = viewModel.voice.supportedLanguages.dict
        List {
            ForEach(Array(dict.keys), id: \.self) { key in
                LanguageSection(voiceLanguage: dict[key]!, languageCode: key)
            }
//
//
//
//            ForEach(structAData.objectsB, id: \.name) { objectB in
//                Section(header: Text(objectB.name)) {
//                    ForEach(objectB.stringList, id: \.self) { item in
//                        Text(item)
//                    }
//                }
//            }
        }
        .navigationTitle("Select Voice")
        Text("X")
    }
}

#Preview {
    VoiceSelection(viewModel: ViewModel())
}
