//
//  TranslatedDisplay.swift
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

extension View {
    func overline() -> some View {
        overlay(Overline().foregroundColor(.white))
    }
}

struct Overline: Shape {
    var edges: [Edge] = [.top]
    
    func path(in rect: CGRect) -> Path {
        edges.map { _ in
            return Path(.init(x: rect.minX, y: rect.minY+3, width: rect.width, height: 2))
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct TranslatedDisplay: View {
    let translatedString: String
    let forCopyTranslatedNumber: String
    let overline: String?
    let screen: Screen

    init(translatedString: String,
         forCopyTranslatedNumber: String,
         overline: String?,
         screen: Screen) {
        self.translatedString = translatedString
        self.forCopyTranslatedNumber = forCopyTranslatedNumber
        self.overline = overline
        self.screen = screen
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Spacer(minLength: 0.0)
                        if overline != nil {
                            Text(overline!)
                                .overline()
                                .multilineTextAlignment(.trailing)
                        }
                        Text(translatedString)
                            .multilineTextAlignment(.trailing)
                    }
                    .contextMenu {
                        Button("Copy to Clipboard") {
                            UIPasteboard.general.string = forCopyTranslatedNumber
                        }
                    }
                }
                .frame(width: geometry.size.width) // Make the scroll view full-width
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}
