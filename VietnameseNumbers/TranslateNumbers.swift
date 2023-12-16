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

    var portraitView: some View {
        VStack(spacing: 0.0) {
            VStack(spacing: 0.0) {
                VStack(spacing: 0.0) {
                    HStack(spacing: 30.0) {
                        LanguageButton(language: viewModel.firstTranslator.language, viewModel: viewModel)
                        Spacer()
                        NavigationLink {
                            Settings(viewModel: viewModel, screen: screen, font: Font(screen.infoUiFont))
                        } label: {
                            Image(systemName: "switch.2")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .font(Font.title.weight(.thin))
                                .frame(height: screen.plusIconSize * 0.8)
                                .foregroundColor(Color.white)
                        }
                        .buttonStyle(TransparentButtonStyle())
                        .opacity(0.9)
                    }
                    .frame(height: 30.0)
                    .padding(.bottom, 10)
                    .padding(.top, 20)
                    TranslatedDisplay(
                        translatedString: viewModel.firstTranslatedNumber,
                        screen: screen)
                    .padding(.horizontal, 0)
                    Spacer(minLength: 0.0)
                }
                if viewModel.secondLanguageAllowed {
                    VStack(spacing: 0.0) {
                        HStack(spacing: 30.0) {
                            LanguageButton(language: viewModel.secondTranslator.language, viewModel: viewModel)
                            Spacer()
                        }
                        .frame(height: 30.0)
                        .padding(.bottom, 10)
                        .padding(.top, 20)
                        Spacer(minLength: 0.0)
                        TranslatedDisplay(
                            translatedString: viewModel.secondTranslatedNumber,
                            screen: screen)
                        .padding(.horizontal, 0)
                    }
                }
            }
            
            PortraitDisplay(
                display: viewModel.currentDisplay,
                screen: screen,
                backgroundColor: screen.backgroundColor)
            .padding(.bottom, screen.portraitIPhoneDisplayBottomPadding)
            .padding(.horizontal, 0)
            NonScientificKeyboard(
                screen: screen,
                viewModel: viewModel)
        }
    }
    
    struct LanguageButton: View {
        @State var showSheet = false
        private let language: String
        private let viewModel: ViewModel

        init(language: String, viewModel: ViewModel) {
            self.language = language
            self.viewModel = viewModel
        }
        
        var body: some View {
            Button {
                showSheet.toggle()
            } label: {
                Image(language)
                    .resizable()
                    .scaledToFit()
            }
            .padding(1)
            .border(.white)
            .sheet(isPresented: $showSheet) {
                ScrollView {
                    VStack{
                        LanguageSelector(viewModel: viewModel)
                        Button(action: {
                            showSheet = false
                        }) {
                            Text("Close")
                                .foregroundColor(.white)
                                .padding(.top, 10)
                        }
                    }
                    .padding(20)
                    .presentationDetents([.height(140.0 + CGFloat(viewModel.translators.count) * 40.0)])
                }
                .background(Color(red: 0.15, green: 0.15, blue: 0.15))
            }
        }
    }
        
    var body: some View {
        NavigationView {
            portraitView
                .padding(.bottom, screen.bottomPadding)
                .padding(.horizontal, screen.horizontalPadding)
                .preferredColorScheme(.dark)
                .onAppear() {
                    Task {
                        await viewModel.refreshDisplay(screen: screen)
                    }
                }
                .onChange(of: screen) { newScreen in /// e.g., rotation
                    Task {
                        await viewModel.refreshDisplay(screen: newScreen)
                    }
                }
                .background(screen.backgroundColor)
        }
    }
}

#Preview {
    GeometryReader { geo in
        TranslateNumbers(screen: Screen(geo.size))
    }
}
