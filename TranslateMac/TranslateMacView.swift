//
//  TranslateMacView.swift
//  Calculator
//
//  Created by Joachim Neumann on 13.11.2024.
//

import SwiftUI

struct TranslateMacView: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: Translate_1ViewModel
    
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var settingsDetent = PresentationDetent.medium
    
    var Translate_1View: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 0.0) {
                VStack(spacing: 0.0) {
                    Spacer(minLength: 20.0)
                    NumberDisplay(display: viewModel.display)
                    if viewModel.showLanguageSelector {
                        ScrollingKeyboardView(
                            spacing: viewModel.screen.keySpacing,
                            keyboard: viewModel.selectLanguage)
                        .frame(width: viewModel.screen.calculatorWidth, height: viewModel.screen.keyboardHeight5Rows)
                        .transition(.opacity)
                    } else {
                        KeyboardView(
                            spacing: viewModel.screen.keySpacing,
                            keyboard: viewModel.keyboard)
                        .frame(width: viewModel.screen.calculatorWidth, height: viewModel.screen.keyboardHeight5Rows)
                    }
                }
                ZStack{
                    VStack(spacing: 0.0) {
                        Translate_1Display(uiFont: viewModel.screen.translationFont, translate_1Result: viewModel.translate_1Manager.result)
                            .font(Font(viewModel.screen.translationFont))
                            .background(Color(AppleColor.darkGray))
                        Spacer(minLength: 0.0)
                    }
                    if viewModel.showLanguageSelector {
                        Color.clear
                            .contentShape(Rectangle()) // Ensure the entire area is tappable
                            .onTapGesture {
                                viewModel.showLanguageSelector = false
                            }
                    }
                }
                //                .background(.green)
                // Add the transparent overlay when the keyboard is visible
            }
        }
        .animation(.easeInOut(duration: 0.6), value: viewModel.showLanguageSelector)
        //.background(.blue)
    }
    
    var body: some View {
        //        ZStack {
        Translate_1View
            .padding(.bottom, viewModel.screen.bottomPadding)
            .padding(.horizontal, viewModel.screen.horizontalPadding)
            .preferredColorScheme(.dark)
            .navigationDestination(isPresented: $viewModel.showSettings) {
                if viewModel.showSettings {
                    Translate_1SettingsView(viewModel: viewModel)
                }
            }
    }
}



#Preview {
    let width: CGFloat = 550
    let height: CGFloat = 400
    let screen = Screen(CGSize(width: width, height: height))
    
    NavigationStack {
        TranslateMacView(viewModel: Translate_1ViewModel(screen: screen))
            .frame(width: width, height: height)
    }
}

