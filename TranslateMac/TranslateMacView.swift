//
//  TranslateMacView.swift
//  Calculator
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

struct TranslateMacView: View {
    @Environment(\.scenePhase) var scenePhase
    let model: TranslateViewModel
    
//    var scrollingModel: ScrollingKeyboardViewModel
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var settingsDetent = PresentationDetent.medium
    
    init(model: TranslateViewModel) {
        self.model = model
//        scrollingModel = ScrollingKeyboardViewModel(spacing: 10, keyboard: nil)//viewModel.languageSelectionKeyboard!)
    }
    
    var body: some View {
        VStack(spacing: 0.0) {
            TranslateDisplay(
                uiFont: AppleFont.systemFont(ofSize: 20),
                translationResult: model.translationManager.result)
            .padding(.bottom, 10)
            NumberDisplay(display: model.display)
                .padding(.horizontal, model.keyboard.padding)
                .padding(.bottom, model.keyboard.padding * 0.2)
                .frame(width: model.keyboard.frame.width, height: model.keyboard.diameter * 1.2)
//            if viewModel.showLanguageSelector {
//                ScrollingKeyboardView(model: scrollingModel)
//                    .frame(width: model.keyboardWidth, height: model.keyboardHeight)
//                    .transition(.opacity)
//            } else {
            KeyboardView(keyboard: model.keyboard)
                .frame(width: model.keyboard.frame.width, height: model.keyboard.frame.height)
//            }
        }
        .animation(.easeInOut(duration: 0.6), value: model.showLanguageSelector)
//        .padding(.bottom, 10)
//        .padding(.leading, 10)
    }
    
}

var previewView: some View {
    TranslateMacView(model: TranslateViewModel(.macTranslator, width: 500, height: 350))
}

#Preview("Dark") {
    previewView
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    previewView
        .preferredColorScheme(.light)
}

