//
//  TranslateNumbers.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

let testColors = false

class LanguageSelectorNavigation: ObservableObject {
    @Published var showLanguageSelector: Bool = false
}

struct TranslateNumbers: View {
    @Environment(\.scenePhase) var scenePhase
    var viewModel: ViewModel
    
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    @State private var showLanguageSelection = false
    @State private var settingsDetent = PresentationDetent.medium
    @StateObject var languageSelectorNavigation = LanguageSelectorNavigation()
    
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
            //            VStack(spacing: 0.0) {
            //                OneLanguage(viewModel: viewModel,
            //                            screen: screen,
            //                            translation: viewModel._1Translation)
            //            Spacer(minLength: 10.0)
            TranslatedDisplay(translation: viewModel.translationManager.result)
                .font(Font(viewModel.screen.translationFont))
            //.background(.yellow)
            Spacer(minLength: 20.0)
            NumberDisplay(display: viewModel.display)
            BasicKeyboardView(
                spacing: viewModel.screen.keySpacing,
                basicKeyboard: viewModel.basicKeyboard,
                configKeyImageName: viewModel.translationManager.flagName, configKeyBorderColor: viewModel.translationManager.borderColor)
        }
        //.background(.blue)
    }
    
    //    struct LanguageButton: View {
    //        private let viewModel: ViewModel
    //        private let screen: Screen
    //
    //        init(viewModel: ViewModel, screen: Screen) {
    //            self.viewModel = viewModel
    //            self.screen = screen
    //        }
    //
    //        var body: some View {
    //            NavigationLink {
    //                LanguageSelector(viewModel: viewModel, screen: screen, currentLanguage: viewModel.numberTranslator.currentLanguage)
    //            } label: {
    //                Image(viewModel.numberTranslator.flagName)
    //                    .resizable()
    //                    .scaledToFit()
    //                    .padding(2)
    //                    .border(.white, width: 2)
    //            }
    //            .buttonStyle(DefaultButtonStyle())
    //            .opacity(0.9)
    //        }
    //    }
    
    var body: some View {
        ZStack {
            portraitView
                .padding(.bottom, viewModel.screen.bottomPadding)
                .padding(.horizontal, viewModel.screen.horizontalPadding)
                .preferredColorScheme(.dark)
            if languageSelectorNavigation.showLanguageSelector {
                VStack {
                    Spacer()
                    LanguageSelectorView(viewModel: viewModel)
                        .frame(height: viewModel.screen.keyboardHeight)
                        .animation(.smooth(duration: 1.0), value: languageSelectorNavigation.showLanguageSelector)
                        .background(.green)
                }
            }
        }
        .environmentObject(languageSelectorNavigation)
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
