//
//  TranslatedDisplay.swift
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

extension View {
    func topBorder() -> some View {
        overlay(TopBorder().foregroundColor(.white))
    }
}

struct TopBorder: Shape {
    var edges: [Edge] = [.top]
    
    func path(in rect: CGRect) -> Path {
        edges.map { _ in
            return Path(.init(x: rect.minX, y: rect.minY+3, width: rect.width, height: 2))
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct TranslatedDisplay: View {
    let translatedString: String
    let translatedStringTopBorder: String?
    let screen: Screen
    let rightToLeft: Bool

    init(translatedString: String, translatedStringTopBorder: String?, screen: Screen, rightToLeft: Bool) {
        self.translatedString = translatedString
        self.translatedStringTopBorder = translatedStringTopBorder
        self.screen = screen
        self.rightToLeft = rightToLeft
    }
    
    var body: some View {
        GeometryReader { geometry in
            ScrollView(.vertical) {
                VStack {
                    HStack(alignment: .bottom, spacing: 0.0) {
                        if rightToLeft {
                            Spacer(minLength: 0.0)
                        }
                        if translatedStringTopBorder != nil {
                            Text(translatedStringTopBorder!)
                                .topBorder()
                        }
                        Text(translatedString)
                            .textSelection(.enabled)
                        if !rightToLeft {
                            Spacer(minLength: 0.0)
                        }
                    }
                }
                .frame(width: geometry.size.width)      // Make the scroll view full-width
            }
            .scrollBounceBehavior(.basedOnSize)
        }
    }
}
