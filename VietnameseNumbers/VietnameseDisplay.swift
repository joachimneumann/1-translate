//
//  Vietnamese.swift
//  VietnameseNumbers
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

struct VietnameseDisplay: View {
    @ObservedObject var viewModel: ViewModel
    let display: Display
    let country: Country
    let screen: Screen
    let backgroundColor: Color
    private let font: Font
    private let toShow: String
    
    init(viewModel: ViewModel, display: Display, country: Country, screen: Screen, backgroundColor: Color) {
        self.viewModel = viewModel
        self.display = display
        self.country = country
        self.screen = screen
        self.backgroundColor = backgroundColor
        let uiFont = Screen.appleFont(ofSize: screen.uiFontSize * 0.5)
        font = Font(uiFont)
        toShow = "can't translate"
    }
    
    var translator: Translator {
        switch country {
        case .Vietnam:
            Vietnamese(groupingSeparator: .comma, vietnameseThousand: .nghìn, vietnameseSecondLast: .lẻ, vietnameseCompact: false)
        default:
            English()
        }
    }
    
    
    var body: some View {
        //let _ = print(display.data.left)
        VStack(spacing: 0.0) {
            HStack(alignment: .bottom, spacing: 0.0) {
                Text(translator.toString(viewModel.currentDisplay.left) ?? "?")
                    .multilineTextAlignment(.leading)
                    .font(font)
                Spacer(minLength: 0.0)
            }
            Spacer(minLength: 0.0)
        }
    }
}
