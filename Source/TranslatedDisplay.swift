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
    let translation: Translation
    let screen: Screen

    init(translation: Translation,
         screen: Screen) {
        self.translation = translation
        self.screen = screen
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        Spacer(minLength: 0.0)
                        if translation.overline != nil {
                            Text(translation.overline!)
                                .overline()
                                .multilineTextAlignment(.trailing)
                        }
                        Text(translation.displayText)
                            .multilineTextAlignment(.trailing)
                    }
                    .contextMenu {
                        Button("Copy to Clipboard") {
                            UIPasteboard.general.string = translation.copyText
                        }
                    }
                }
                .frame(width: geometry.size.width) // Make the scroll view full-width
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}
