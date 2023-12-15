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
                        Button {
                            showLanguageSelection.toggle()
                        } label: {
                            Image(viewModel.firstTranslator.language)
                                .resizable()
                                .scaledToFit()
                        }
                        .padding(1)
                        .border(.white)
                        .sheet(isPresented: $showLanguageSelection) {
                            ScrollView {
                                VStack{
                                    LanguageSelector(viewModel: viewModel)
                                    Button(action: {
                                        showLanguageSelection = false
                                    }) {
                                        Text("close")
                                            .foregroundColor(.white)
                                    }
                                }
                                .padding(20)
                                .presentationDetents([.height(140.0 + CGFloat(viewModel.translators.count) * 40.0)])
                            }
                        }
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
                    //.background(Color.yellow).opacity(0.8)
                    .padding(.horizontal, 0)
                    Spacer(minLength: 0.0)
                }
                if viewModel.secondLanguageAllowed {
                    VStack(spacing: 0.0) {
                        HStack(spacing: 30.0) {
                            Button {
                                showLanguageSelection.toggle()
                            } label: {
                                Image(viewModel.secondTranslator.language)
                                    .resizable()
                                    .scaledToFit()
                            }
                            .padding(1)
                            .border(.white)
                            .sheet(isPresented: $showLanguageSelection) {
                                        VStack{
                                            Text("Hello, I'm a modal!")
                                            Button("Dismiss") {
                                                showLanguageSelection = false
                                            }
                                        }.presentationDetents([.height(250)])
                                    }
//                            .sheet(isPresented: $showLanguageSelection) {
//                                VStack {
//                                    LanguageSelector(viewModel: viewModel)
//                                        .presentationDetents(
//                                            [.height(CGFloat(80 + 190 * viewModel.translators.count))]
//                                        )
//                                        .frame(height: .infinity)
//                                        .background(screen.backgroundColor)
//                                }
//                            }
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
    
    var infoView: some View {
        let leadingPaddingToCenterRad = 0.5 * (screen.iconsWidth - screen.plusIconSize) + 0.5 * screen.plusIconSize - 0.5 * screen.radWidth + screen.displayHorizontalPadding
        return HStack(spacing: 0.0) {
            let info = "\(viewModel.showPrecision ? "Precision: "+viewModel.precisionDescription+" digits" : "\(viewModel.rad ? "Rad" : "")")"
            Text(info)
                .foregroundColor(screen.defaultTextColor)
                .font(Font(screen.infoUiFont))
                .accessibilityIdentifier("infoText")
            Spacer()
        }
        .padding(.leading, leadingPaddingToCenterRad)
    }
    
    @ViewBuilder
    var content: some View {
        portraitView
    }
    
    var body: some View {
        NavigationView {
            //let _ = print("Calculator body isPortraitPhone", screen.isPortraitPhone)
            content
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
