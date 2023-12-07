//
//  TranslatedDisplay.swift
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

struct TranslatedDisplay: View {
    let translatedString: String
    let screen: Screen
    private let font: Font

    init(translatedString: String, screen: Screen) {
        self.translatedString = translatedString
        self.screen = screen
        let uiFont = Screen.appleFont(ofSize: screen.uiFontSize * 0.8)
        self.font = Font(uiFont)
    }
    
    var body: some View {
        //let _ = print(display.data.left)
        VStack(spacing: 0.0) {
            Spacer(minLength: 0.0)
            HStack(alignment: .bottom, spacing: 0.0) {
                Text(translatedString)
                    .font(font)
                    .multilineTextAlignment(.leading)
                Spacer(minLength: 0.0)
            }
            Spacer(minLength: 0.0)
        }
//        .background(Color.yellow)
    }
}
