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
    @State private var xx: String = "XX"
    
    var body: some View {
        let dict = viewModel.voices.voicesForLanguage
        List {
            Text(xx)
                .onTapGesture {
                    xx = "XX4"
                }
            ForEach(dict.keys.sorted(), id: \.self) { language in
                Section(header: Text(language)) {
                    ForEach(dict[language]!, id: \.self) { voice in
                        HStack {
                            Text(voice.variantCode)
                                .bold()
                                .frame(width: 40)
                            Text(voice.name + " \(voice.genderSting) \(voice.qualityString)")
                            Spacer()
                            Image(systemName: selectedVoices[language]?.identifier == voice.identifier ? "checkmark" : "")
                        }
                        .id(voice.identifier)
                        .onTapGesture {
                            select(section: language, item: voice)
                        }
                    }
                }
            }
        }
        .onAppear() {
            Task {
                viewModel.voices.getVoices(for: viewModel.languages.list)
                DispatchQueue.main.async {
                    xx = "xx2"
                }
            }
        }
    }
    
    private func select(section: String, item: AVSpeechSynthesisVoice) {
        if let currentSelection = selectedVoices[section] {
            // Deselect the current selection
            if currentSelection.identifier == item.identifier {
                selectedVoices[section] = nil
            } else {
                // Change selection to the new item
                selectedVoices[section] = item
            }
        } else {
            // No current selection, select the new item
            selectedVoices[section] = item
        }
    }
}

/*
 import SwiftUI
 import AVFoundation
 
 
 struct VoiceSelection: View {
 let viewModel: ViewModel
 
 struct LanguageSection : View {
 @State private var selectedItems: [String: AVSpeechSynthesisVoice] = [:]
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
 .id(voice.identifier)
 .onTapGesture {
 selectItem(section: voiceCode, item: voice)
 }
 }
 }
 }
 private func selectItem(section: String, item: AVSpeechSynthesisVoice) {
 if let currentSelection = selectedItems[section.id] {
 // Deselect the current selection
 if currentSelection.id == item.id {
 selectedItems[section.id] = nil
 } else {
 // Change selection to the new item
 selectedItems[section.id] = item
 }
 } else {
 // No current selection, select the new item
 selectedItems[section.id] = item
 }
 }
 }
 
 
 var body: some View {
 let dict = viewModel.voices.voicesForLanguage
 List {
 ForEach(dict.keys.sorted(), id: \.self) { language in
 LanguageSection(viewModel: viewModel, list: dict[language]!, voiceCode: language)
 }
 }
 .navigationTitle("Select Voice")
 }
 }
 */

#Preview {
    VoiceSelection(viewModel: ViewModel())
}
