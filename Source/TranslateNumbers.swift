//
//  TranslateNumbers.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

let testColors = false

struct TranslateNumbers: View {
    @Environment(\.scenePhase) var scenePhase
    @Environment(\.showLanguageSelector) var showLanguageSelector: Binding<Bool>
    var viewModel: ViewModel
    
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var showLanguageSelection = false
    @State private var settingsDetent = PresentationDetent.medium
    
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
            TranslatedDisplay(translation: viewModel.translationManager.result)
                .font(Font(viewModel.screen.translationFont))
            //.background(.yellow)
            Spacer(minLength: 20.0)
            NumberDisplay(display: viewModel.display)

            if showLanguageSelector.wrappedValue {
                SmallKeyboardView(
                    spacing: viewModel.screen.keySpacing,
                    smallKeyboard: viewModel.languageSelectorKeyboard,
                    height: viewModel.screen.keyboardHeight4Rows
                )
                .padding(.bottom, viewModel.screen.keySpacing)
                .transition(.opacity)
                
                SmallKeyboardView(
                    spacing: viewModel.screen.keySpacing,
                    smallKeyboard: viewModel.selectedLanguageKeyboard
                )
                .transition(.opacity)
            } else {
                SmallKeyboardView(
                    spacing: viewModel.screen.keySpacing,
                    smallKeyboard: viewModel.translatorKeyboard)
            }
//
//            SmallKeyboardView(
//                spacing: viewModel.screen.keySpacing,
//                smallKeyboard: viewModel.languageSelectorKeyboard,
//                height: viewModel.screen.keyboardHeight4Rows)
//            .padding(.bottom, viewModel.screen.keySpacing)
//            
//            SmallKeyboardView(
//                spacing: viewModel.screen.keySpacing,
//                smallKeyboard: viewModel.selectedLanguageKeyboard)

        }
        .animation(.easeInOut(duration: 0.3), value: showLanguageSelector.wrappedValue)
        //.background(.blue)
    }
    
    var body: some View {
        ZStack {
            portraitView
                .padding(.bottom, viewModel.screen.bottomPadding)
                .padding(.horizontal, viewModel.screen.horizontalPadding)
                .preferredColorScheme(.dark)
        }
        .accentColor(.white)
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
