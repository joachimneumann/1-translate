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
    let text: String
    let overline: String?
    let forCopy: String
    let screen: Screen

    init(text: String,
         overline: String?,
         forCopy: String,
         screen: Screen) {
        self.text = text
        self.overline = overline
        self.forCopy = forCopy
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
                        Text(text)
                            .multilineTextAlignment(.trailing)
                    }
                    .contextMenu {
                        Button("Copy to Clipboard") {
                            UIPasteboard.general.string = forCopy
                        }
                    }
                }
                .frame(width: geometry.size.width) // Make the scroll view full-width
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}
