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
        GeometryReader { geometry in                    // Get the geometry
            ScrollView(.vertical) {
                VStack {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Text(translatedString)
                        Spacer(minLength: 0.0)
                    }
                }
                .font(font)
                .frame(width: geometry.size.width)      // Make the scroll view full-width
                .frame(minHeight: geometry.size.height) // Set the content’s min height to the parent
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}
