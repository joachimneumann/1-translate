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
                    HStack(spacing: 0.0) {
                        Spacer(minLength: 0.0)
                        TranslateDisplay(uiFont: viewModel.screen.translationFont, translationResult: viewModel.translationManager.result)
                            .padding(.top, 15)
                            .padding(.leading, 20)
                            .padding(.trailing, 20)
                            .frame(width: model.translationViewWidth)
                    }
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
        .padding(.bottom, 10)
        .padding(.leading, 10)
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

