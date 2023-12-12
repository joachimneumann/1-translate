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
    
    var portraitView: some View {
        VStack(spacing: 0.0) {
            HStack(spacing: 30.0) {
                Button(action: {
                    viewModel.selectedTranslatorIndex = 0
                }) {
                    Image(viewModel.firstTranslator.imageName)
                        .resizable()
                        .scaledToFit()
                        .opacity(viewModel.selectedTranslatorIndex == 0 ? 1.0 : 0.5)
                }
                if viewModel.secondTranslator != nil {
                    Button(action: {
                        viewModel.selectedTranslatorIndex = 1
                    }) {
                        Image(viewModel.secondTranslator!.imageName)
                            .resizable()
                            .scaledToFit()
                            .opacity(viewModel.selectedTranslatorIndex == 1 ? 1.0 : 0.5)
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
                        .frame(height: screen.plusIconSize * 0.6)
                        .foregroundColor(Color.white)
                        .accessibilityIdentifier("settingsButton")
                }
                .buttonStyle(TransparentButtonStyle())
                .opacity(0.9)
            }
            .frame(height: 30.0)
            .padding(.bottom, 20)
            .padding(.top, 20)
            Spacer(minLength: 0.0)
            TranslatedDisplay(
                translatedString: viewModel.translatedNumber,
                screen: screen)
                .padding(.bottom, screen.portraitIPhoneDisplayBottomPadding)
                .padding(.horizontal, 0)
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
        }
    }
}

