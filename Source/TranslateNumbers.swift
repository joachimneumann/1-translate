//
//  TranslateNumbers.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

let testColors = false

struct TranslateNumbers: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: ViewModel

    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var settingsDetent = PresentationDetent.medium
    
//    init(screen: Screen) {
//        _viewModel = StateObject(wrappedValue: ViewModel(screen: screen))
//    }
    
    
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
//        ZStack {
            portraitView
                .padding(.bottom, viewModel.screen.bottomPadding)
                .padding(.horizontal, viewModel.screen.horizontalPadding)
                .preferredColorScheme(.dark)
                .navigationDestination(isPresented: $viewModel.showSettings) {
                    SettingsView(viewModel: viewModel, languageEnum: .vietnamese, exampleFont: viewModel.screen.infoUiFont)
                                    .onDisappear {
                                        viewModel.didReturnFromSettings()
                                    }
                            }
//        }
//        .onChange(of: viewModel.navigateToSettings) { old, new in
//            if new {
//                navigationPath.append("Settings")
//                print("viewModel.showLanguageSelector \(viewModel.showLanguageSelector)")
//            }
//        }
//        .navigationDestination(for: String.self) { destination in
//            if destination == "Settings" {
//                SettingsView(viewModel: viewModel, languageEnum: viewModel.persistent.currentLanguageEnum, exampleFont: viewModel.screen.infoUiFont)
//                    .onDisappear {
//                        viewModel.navigateToSettings = false
//                        print("viewModel.showLanguageSelector \(viewModel.showLanguageSelector)")
//                    }
//            }
//        }
//        .accentColor(.white)
    }
    //        .onChange(of: scenePhase) { oldPhase, newPhase in
    //            if newPhase == .active {
    //                //                            viewModel.voices.refreshVoiceDict(list: viewModel.languages.list)
    //            }
    //        }
}



#Preview {
    NavigationStack {
        TranslateNumbers(viewModel: ViewModel(screen: Screen()))
    }
}
