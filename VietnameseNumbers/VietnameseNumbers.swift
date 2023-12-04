//
//  Calculator.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI

let testColors = false

struct VietnameseNumbers: View {
    @StateObject private var viewModel: ViewModel = ViewModel()

    var screen: Screen
    @State var scrollViewHasScrolled = false
    @State var scrollViewID = UUID()
    @State var isZoomed: Bool = false
    
    var portraitView: some View {
        VStack(spacing: 0.0) {
            Spacer(minLength: 0.0)
            Vietnamese(
                display: viewModel.currentDisplay,
                screen: screen,
                backgroundColor: screen.backgroundColor)
                .padding(.bottom, screen.portraitIPhoneDisplayBottomPadding)
                .padding(.horizontal, screen.displayHorizontalPadding)
            PortraitDisplay(
                display: viewModel.currentDisplay,
                screen: screen,
                backgroundColor: screen.backgroundColor)
                .padding(.bottom, screen.portraitIPhoneDisplayBottomPadding)
                .padding(.horizontal, screen.displayHorizontalPadding)
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

