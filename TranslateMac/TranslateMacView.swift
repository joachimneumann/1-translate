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
            HStack {
                VStack(spacing: 0.0) {
                    Spacer(minLength: 20.0)
                    NumberDisplay(display: viewModel.display)
                    if viewModel.showLanguageSelector {
                        KeyboardView(
                            spacing: viewModel.screen.keySpacing,
                            keyboard: viewModel.selectLanguage,
                            height: viewModel.screen.keyboardHeight4Rows
                        )
                        .transition(.opacity)
                    } else {
                        KeyboardView(
                            spacing: viewModel.screen.keySpacing,
                            keyboard: viewModel.keyboard)
                    }
                }
                ZStack{
                    VStack(spacing: 0.0) {
                        Translate_1Display(uiFont: viewModel.screen.translationFont, translate_1Result: viewModel.translate_1Manager.result)
                            .font(Font(viewModel.screen.translationFont))
                        //                            .background(.yellow)
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
    let width: CGFloat = 350.0
    let height: CGFloat = 322.0
    let screen = Screen(CGSize(width: width, height: height))
    
    NavigationStack {
        TranslateMacView(viewModel: Translate_1ViewModel(screen: screen))
            .frame(width: width, height: height)
    }
}

