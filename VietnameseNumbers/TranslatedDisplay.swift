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
        let uiFont = AppleFont.systemFont(ofSize: screen.uiFontSize * 0.7, weight: .regular)
        self.font = Font(uiFont)
    }
    
    var body: some View {
        //let _ = print(display.data.left)
        GeometryReader { geometry in                    // Get the geometry
            ScrollView(.vertical) {
                VStack {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Text(translatedString)
                            .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                        Spacer(minLength: 0.0)
                    }
                }
                .frame(width: geometry.size.width)      // Make the scroll view full-width
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}
