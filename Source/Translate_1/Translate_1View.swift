//
//  Translate_1View.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

let testColors = false

struct Translate_1View: View {
    @Environment(\.scenePhase) var scenePhase
    @ObservedObject var viewModel: ViewModel

    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var settingsDetent = PresentationDetent.medium
    
//    init(screen: Screen) {
//        _viewModel = StateObject(wrappedValue: ViewModel(screen: screen))
//    }
    
    var Translate_1View: some View {
        VStack(spacing: 0.0) {
            ZStack {
                VStack(spacing: 0.0) {
                    Translate_1Display(uiFont: viewModel.screen.translationFont, translate_1Result: viewModel.translate_1Manager.result)
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
                    smallKeyboard: viewModel.translate_1LanguageSelectorKeyboard,
                    height: viewModel.screen.keyboardHeight4Rows
                )
                .padding(.bottom, viewModel.screen.keySpacing)
                ZStack {
                    SmallKeyboardView(
                        spacing: viewModel.screen.keySpacing,
                        smallKeyboard: viewModel.translate_1SelectedLanguagekeyboard
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
                    smallKeyboard: viewModel.translate_1Keyboard)
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
                            .onDisappear {
                                viewModel.didReturnFromSettings()
                            }
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
        Translate_1View(viewModel: ViewModel(screen: Screen()))
    }
}