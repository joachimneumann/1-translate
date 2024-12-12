//
//  TranslateiOSView.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import Neumorphic

struct TranslateiOSView: View {
    let model: TranslateViewModel

    init(model: TranslateViewModel) {
        self.model = model
    }
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
                .ignoresSafeArea()
            VStack(spacing: 0.0) {
                TranslateDisplay(uiFont: AppleFont.systemFont(ofSize: ceil(model.keyboard.diameter * 0.4), weight: .light), translationResult: model.translationManager.result)
                    //.background(.orange)
                    .padding(.horizontal, model.keyboard.padding)
                    .padding(.bottom, model.keyboard.padding * 0.2)
                    .frame(width: model.keyboard.frame.width)
                    //.background(.yellow)
                NumberDisplay(display: model.display)
                    .padding(.horizontal, model.keyboard.padding)
                    .padding(.bottom, model.keyboard.padding * 0.2)
                    .frame(width: model.keyboard.frame.width, height: model.keyboard.diameter * 1.2)
                    //.background(Color.yellow)
                HStack {
                    Spacer()
                    if model.showLanguageSelector {
//                        ScrollingKeyboardView(model: scrollingModel)
//                            .transition(.opacity)
                    } else {
                        KeyboardView(keyboard: model.keyboard)
                            .frame(width: model.keyboard.frame.width, height: model.keyboard.frame.height)
                    }
                    Spacer()
                }
            }
        }
    }
}

//struct TranslateiOSViewOLD: View {
//    @Environment(\.scenePhase) var scenePhase
//    @ObservedObject var viewModel: TranslateViewModel
//    let scrollingModel: ScrollingKeyboardViewModel
//    @State var scrollViewID = UUID()
//    @State var isZoomed: Bool = false
//    @State private var settingsDetent = PresentationDetent.medium
//    let calculatorKeyboardStandard = CalculatorStandardKeyboardViewModel()
//    init(viewModel: TranslateViewModel) {
//        let _ = print("xxx1")
//        self.viewModel = viewModel
//        scrollingModel = ScrollingKeyboardViewModel(spacing: 10, keyboard: viewModel.languageSelectionKeyboard!)
//    }
    
//    var TranslateiOSView: some View {
//                VStack(spacing: 100.0) {
//                    let _ = print("xxx2")
//                    Spacer(minLength: 0.0)
//                    ZStack {
//                        VStack(spacing: 0.0) {
//                            Spacer(minLength: 20.0)
//                            //                    TranslateDisplay(uiFont: viewModel.screen.translationFont, translationResult: viewModel.translationManager.result)
//                            //                        .font(Font(viewModel.screen.translationFont))
//                            Spacer(minLength: 20.0)
//                            NumberDisplay(display: viewModel.display)
//                        }
//                        // Add the transparent overlay when the keyboard is visible
//                        if viewModel.showLanguageSelector {
//                            Color.clear
//                                .contentShape(Rectangle()) // Ensure the entire area is tappable
//                                .onTapGesture {
//                                    viewModel.showLanguageSelector = false
//                                }
//                        }
//                    }
//                    if viewModel.showLanguageSelector {
//                        ScrollingKeyboardView(model: scrollingModel)
//                            .transition(.opacity)
//                    } else {
//                        let screenSize = UIScreen.main.bounds
//                        let screenWidth = screenSize.width
//                        let screenHeight = screenSize.height
//
//                        let _ = print("TranslateiOSView \(screenSize)")
//                        let sideMargin = screenWidth * 0.1
//                        let calculatorSize = CGSize(width: screenWidth - 2 * sideMargin, height: screenHeight * 0.8)
//                        CalculatorKeyboardView(size: calculatorSize, keyboard: calculatorKeyboardStandard)
//                            .frame(width: calculatorSize.width, height: calculatorSize.height)
                            //.background(.yellow)
//                            .padding(.horizontal, sideMargin)
//                    }
//                }
//                .animation(.easeInOut(duration: 0.6), value: viewModel.showLanguageSelector)
//                //.background(.blue)
//                .padding(.bottom, 100)
//    }
    
//    var body: some View {
//        ZStack {
//        Text("X")
//        TranslateiOSView
//            .background(Color.Neumorphic.main)
//let _ = print("xxx3")
//                .padding(.bottom, viewModel.screen.bottomPadding)
//                .padding(.horizontal, viewModel.screen.horizontalPadding)
//                .preferredColorScheme(.dark)
//                .navigationDestination(isPresented: $viewModel.showSettings) {
//                    if viewModel.showSettings {
//                        TranslateiOSSettingsView(viewModel: viewModel)
//                    }
//                }
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
//    }
    //        .onChange(of: scenePhase) { oldPhase, newPhase in
    //            if newPhase == .active {
    //                //                            viewModel.voices.refreshVoiceDict(list: viewModel.languages.list)
    //            }
    //        }
//}




#Preview("Dark") {
    TranslateiOSView(model: TranslateViewModel(width: defaultWidth, height: defaultHeight))
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    TranslateiOSView(model: TranslateViewModel(width: defaultWidth, height: defaultHeight))
        .preferredColorScheme(.light)
}

