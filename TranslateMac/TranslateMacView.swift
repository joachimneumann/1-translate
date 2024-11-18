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
    
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var settingsDetent = PresentationDetent.medium

    func LeftSide(
        keyboardWidth: CGFloat,
        keyboardHeight: CGFloat,
        keySpacing: CGFloat,
        displayHeight: CGFloat) -> some View {
            VStack(spacing: 0.0) {
                Spacer(minLength: 0.0)
                NumberDisplay(display: viewModel.display)
                    .frame(width: keyboardWidth, height: displayHeight)
                    .background(.yellow)
                if viewModel.showLanguageSelector {
                    ScrollingKeyboardView(
                        spacing: keySpacing,
                        keyboard: viewModel.selectLanguage)
                    .frame(width: keyboardWidth, height: keyboardHeight)
                    .transition(.opacity)
                } else {
                    KeyboardView(
                        spacing: keySpacing,
                        keyboard: viewModel.keyboard)
                    .frame(width: keyboardWidth, height: keyboardHeight)
                }
            }
        }

    var Translate_1View: some View {
        GeometryReader { geometry in
            if geometry.notZero {
                let keyboardHeight = 0.8 * geometry.size.height
                let displayHeight = geometry.size.height - keyboardHeight
                let keySpacing = 0.025 * keyboardHeight
                let keyDiameter = 0.2 * (keyboardHeight - 4 * keySpacing)
                let keyboardWidth = 4 * keyDiameter + 3 * keySpacing
                VStack(spacing: 0.0) {
//                    HStack(spacing: 0.0) {
                    LeftSide(
                        keyboardWidth: keyboardWidth,
                        keyboardHeight: keyboardHeight,
                        keySpacing: keySpacing,
                        displayHeight: displayHeight
                    )
                        
//                        ZStack{
//                            VStack(spacing: 0.0) {
//                                TranslateDisplay(uiFont: viewModel.screen.translationFont, translate_1Result: viewModel.translate_1Manager.result)
//                                    .font(Font(viewModel.screen.translationFont))
//                                    .background(Color(AppleColor.darkGray))
//                                Spacer(minLength: 0.0)
//                            }
//                            if viewModel.showLanguageSelector {
//                                Color.clear
//                                    .contentShape(Rectangle()) // Ensure the entire area is tappable
//                                    .onTapGesture {
//                                        viewModel.showLanguageSelector = false
//                                    }
//                            }
//                        }
//                    }
                }
                .animation(.easeInOut(duration: 0.6), value: viewModel.showLanguageSelector)
            }
        }
        .padding(.bottom, 5)
        .padding(.leading, 5)
    }
    
    var body: some View {
        Translate_1View
//            .padding(.bottom, viewModel.screen.bottomPadding)
//            .padding(.horizontal, viewModel.screen.horizontalPadding)
            .preferredColorScheme(.dark)
    }
}



#Preview {
    let width: CGFloat = 650
    let height: CGFloat = 350
    let screen = Screen(CGSize(width: width, height: height))
    
    NavigationStack {
        TranslateMacView(viewModel: TranslateViewModel(screen: screen))
            .frame(width: width, height: height)
    }
}

