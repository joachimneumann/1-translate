//
//  TranslateMacView.swift
//  Calculator
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

struct TranslateMacView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: TranslateViewModel
    
    let model: TranslateMacViewModel = TranslateMacViewModel()
    let scrollingModel: ScrollingKeyboardViewModel
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var settingsDetent = PresentationDetent.medium
    
    init(viewModel: TranslateViewModel) {
        self.viewModel = viewModel
        scrollingModel = ScrollingKeyboardViewModel(spacing: viewModel.screen.keySpacing, keyboard: viewModel.languageSelectionKeyboard!)
    }
    
    func LeftSide() -> some View {
        VStack(spacing: 0.0) {
            Spacer(minLength: 0.0)
            NumberDisplay(display: viewModel.display)
                .frame(width: model.keyboardWidth, height: model.displayHeight)
            if viewModel.showLanguageSelector {
                ScrollingKeyboardView(model: scrollingModel)
                    .frame(width: model.keyboardWidth, height: model.keyboardHeight)
                    .transition(.opacity)
            } else {
                KeyboardView(
                    spacing: model.keySpacing,
                    keyboard: viewModel.smallKeyboard!)
                .frame(width: model.keyboardWidth, height: model.keyboardHeight)
            }
        }
    }
    
    func RightSide(uiFont: AppleFont, translationResult: TranslateResult) -> some View {
        VStack {
            TranslateDisplay(uiFont: uiFont, translationResult: translationResult)
            Spacer()
        }
    }
    var body: some View {
        GeometryReader { geometry in
            if geometry.notZero {
                ZStack {
                    VStack(spacing: 0.0) {
                        Spacer(minLength: 0.0)
                        HStack(spacing: 30.0) {
                            LeftSide()
                            Spacer(minLength: 0.0)
                        }
                    }
                    VStack(spacing: 0.0) {
                        Spacer(minLength: 0.0)
                        HStack(spacing: 0.0) {
                            Spacer(minLength: 0.0)
                            RightSide(uiFont: viewModel.screen.translationFont, translationResult: viewModel.translate_1Manager.result)
                                .frame(width: model.translationViewWidth, height: model.translationViewHeight)
                        }
                    }
                    .padding(10)
                }
                .onChange(of: viewModel.showLanguageSelector) {
                    model.setSize(geometry.size, isScrollView: viewModel.showLanguageSelector)
                }
                .onAppear() {
                    model.setSize(geometry.size, isScrollView: viewModel.showLanguageSelector)
                }
                .animation(.easeInOut(duration: 0.6), value: viewModel.showLanguageSelector)
            }
        }
        .padding(.bottom, 5)
        .padding(.leading, 5)
        .preferredColorScheme(.dark)
    }
    
}



#Preview {
    let width: CGFloat = 500
    let height: CGFloat = 350
    let screen = Screen(CGSize(width: width, height: height))
    
    NavigationStack {
        TranslateMacView(viewModel: TranslateViewModel(screen: screen))
            .frame(width: width, height: height)
    }
}

