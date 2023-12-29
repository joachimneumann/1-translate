//
//  TranslateNumbers.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

let testColors = false

struct TranslateNumbers: View {
    @StateObject private var viewModel: ViewModel = ViewModel()
    var screen: Screen
    
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var showLanguageSelection = false
    @State private var settingsDetent = PresentationDetent.medium

    @State var voiceAvailable = false
    var portraitView: some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                VStack(spacing: 0.0) {
                    HStack(spacing: 30.0) {
                        Button {
                            viewModel.voice.readAloud(viewModel.firstTranslatedNumber, in: viewModel.firstLanguage.code)
                            print("read \(viewModel.firstTranslatedNumber)")
                        } label: {
                            Image(systemName: "speaker.wave.3.fill")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(height: 25)
                        }
                        .disabled(!viewModel.firstHasVoice)
                        .padding(.leading, 0)
                        Spacer()
                        LanguageButton(language: viewModel.firstLanguage, viewModel: viewModel, screen: screen)                    }
                    .frame(height: 34.0)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                        TranslatedDisplay(
                            translatedString: viewModel.firstTranslatedNumber,
                            forCopyTranslatedNumber: viewModel.forCopyFirstTranslatedNumber,
                            translatedStringTopBorder: viewModel.firstTranslatedNumberTopBorder,
                            screen: screen)
                        .font(viewModel.firstFont)
                        .padding(.horizontal, 0)
                    Spacer(minLength: 0.0)
                }
                if viewModel.secondLanguageAllowed {
                    VStack(spacing: 0.0) {
                        HStack(spacing: 30.0) {
                            Button {
                                viewModel.voice.readAloud(viewModel.secondTranslatedNumber, in: viewModel.secondLanguage.code)
                                print("read \(viewModel.secondTranslatedNumber)")
                            } label: {
                                Image(systemName: "speaker.wave.3.fill")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(height: 25)
                            }
                            .disabled(!viewModel.secondHasVoice)
                            Spacer()
                            LanguageButton(language: viewModel.secondLanguage, viewModel: viewModel, screen: screen)
                        }
                        .frame(height: 34.0)
                        .padding(.bottom, 10)
                        .padding(.top, 20)
                        Spacer(minLength: 0.0)
                        TranslatedDisplay(
                            translatedString: viewModel.secondTranslatedNumber,
                            forCopyTranslatedNumber: viewModel.forCopySecondTranslatedNumber,
                            translatedStringTopBorder: viewModel.secondTranslatedNumberTopBorder,                            screen: screen)
                        .font(viewModel.secondFont)
                        .padding(.horizontal, 0)
                    }
                }
            }
            
            PortraitDisplay(
                display: viewModel.currentDisplay,
                screen: screen)
            .padding(.bottom, screen.portraitIPhoneDisplayBottomPadding)
            .padding(.horizontal, 0)
            NonScientificKeyboard(
                screen: screen,
                viewModel: viewModel)
        }
    }
    
    struct LanguageButton: View {
        @State var showSheet = false
        private let language: Language
        private let viewModel: ViewModel
        private let screen: Screen

        init(language: Language, viewModel: ViewModel, screen: Screen) {
            self.language = language
            self.viewModel = viewModel
            self.screen = screen
        }
        
        var body: some View {
            NavigationLink {
                LanguageSelector(viewModel: viewModel, screen: screen)
            } label: {
                Image(language.flagName)
                    .resizable()
                    .scaledToFit()
                    .padding(2)
                    .border(.white, width: 2)
            }
            .buttonStyle(TransparentButtonStyle())
            .opacity(0.9)
        }
    }
        
    var body: some View {
        NavigationStack {
            portraitView
                .padding(.bottom, screen.bottomPadding)
                .padding(.horizontal, screen.horizontalPadding)
                .preferredColorScheme(.dark)
                .onAppear() {
                    Task {
                        viewModel.initVoice()
                        await viewModel.refreshDisplay(screen: screen)
                        
                    }
                }
        }
        .accentColor(.white)
    }
}

#Preview {
    GeometryReader { geo in
        TranslateNumbers(screen: Screen(geo.size))
    }
}
