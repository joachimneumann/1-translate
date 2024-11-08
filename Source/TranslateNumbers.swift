//
//  TranslateNumbers.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

let testColors = false

struct TranslateNumbers: View {
    @Environment(\.scenePhase) var scenePhase
    var viewModel: ViewModel
    
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var showLanguageSelection = false
    @State private var settingsDetent = PresentationDetent.medium
    
    @State private var navigationPath = NavigationPath()

    init(screen: Screen) {
        //        self._viewModel = StateObject(wrappedValue: ViewModel(screen: screen))
        self.viewModel = ViewModel(screen: screen)
    }
    
    struct OneLanguage: View {
        var viewModel: ViewModel
        let screen: Screen
        let translation: TranslationResult
        
        var body: some View {
            HStack(spacing: 30.0) {
                Spacer()
                //                if viewModel.persistent.offerReadingAloud {
                //                    let noVoice = (translation.spokenText == nil)
                //                    let color =  noVoice ? Color(white: 0.7) : Color(white: 0.95)
                //                    let symbolName = noVoice ? "speaker.slash.fill" : "speaker.wave.3.fill"
                //                    let symbolSize: CGFloat = noVoice ? 23.0 : 18.0
                //                    Button {
                //                        viewModel.voices.readAloud(translation.spokenText!, in: viewModel.numberTranslator.currentLanguage)
                //                    } label: {
                //                        Image(systemName: symbolName)
                //                            .resizable()
                //                            .aspectRatio(contentMode: .fit)
                //                            .foregroundColor(color)
                //                            .frame(height: symbolSize)
                //                            .padding(10)
                //                    }
                //                    .disabled(noVoice)
                //                    .padding(.trailing, 10)
                //                }
                //                LanguageButton(viewModel: viewModel, screen: screen)
            }
            .frame(height: 34.0)
            .padding(.bottom, 10)
            .padding(.top, 20)
        }
    }
    
    var portraitView: some View {
        VStack(spacing: 0.0) {
            ZStack {
                VStack(spacing: 0.0) {
                    TranslatedDisplay(uiFont: viewModel.screen.translationFont, translationResult: viewModel.translationManager.result)
                       .font(Font(viewModel.screen.translationFont))
                   Spacer(minLength: 20.0)
                   NumberDisplay(display: viewModel.display)
                }
                // Add the transparent overlay when the keyboard is visible
                if viewModel.showLanguageSelector {
                   Color.clear
                       .contentShape(Rectangle()) // Ensure the entire area is tappable
                       .onTapGesture {
                           viewModel.showLanguageSelector = false
                       }
                }
            }
            if viewModel.showLanguageSelector {
                SmallKeyboardView(
                    spacing: viewModel.screen.keySpacing,
                    smallKeyboard: viewModel.languageSelectorKeyboard,
                    height: viewModel.screen.keyboardHeight4Rows
                )
                .padding(.bottom, viewModel.screen.keySpacing)
                ZStack {
                    SmallKeyboardView(
                        spacing: viewModel.screen.keySpacing,
                        smallKeyboard: viewModel.selectedLanguageKeyboard
                    )
                    HStack {
                        VStack(alignment: .leading){
                            Text(viewModel.currentLanguageName)
                            if let englishName = viewModel.currentLanguageEnglishName {
                                Text("(\(englishName))")
                            }
                        }
                            .padding(.leading, viewModel.screen.keySize.width + viewModel.screen.keySpacing)
                        Spacer()
                    }
                }
                .transition(.opacity)
            } else {
                SmallKeyboardView(
                    spacing: viewModel.screen.keySpacing,
                    smallKeyboard: viewModel.translatorKeyboard)
            }
        }
        .animation(.easeInOut(duration: 0.6), value: viewModel.showLanguageSelector)
        //.background(.blue)
    }
    
    var body: some View {
        NavigationStack(path: $navigationPath) {
            
            ZStack {
                portraitView
                    .padding(.bottom, viewModel.screen.bottomPadding)
                    .padding(.horizontal, viewModel.screen.horizontalPadding)
                    .preferredColorScheme(.dark)
            }
            .accentColor(.white)
            .onChange(of: viewModel.navigateToSettings) { old, new in
                if new {
                    navigationPath.append("Settings")
                }
            }
            .navigationDestination(for: String.self) { destination in
                if destination == "Settings" {
                    SettingsView(viewModel: viewModel, languageEnum: viewModel.persistent.currentLanguageEnum, exampleFont: Font(viewModel.screen.infoUiFont))
                        .onDisappear {
                            viewModel.navigateToSettings = false
                        }
                }
            }
        }
//        .onChange(of: scenePhase) { oldPhase, newPhase in
//            if newPhase == .active {
//                //                            viewModel.voices.refreshVoiceDict(list: viewModel.languages.list)
//            }
//        }
    }
}


#Preview {
    TranslateNumbers(screen: Screen())
}
