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
            return Path(.init(x: rect.minX, y: rect.minY+5, width: rect.width, height: 2))
        }.reduce(into: Path()) { $0.addPath($1) }
    }
}

struct TranslatedDisplay: View {
    let translatedString: String
    let translatedStringTopBorder: String?
    let screen: Screen
    private let font: Font
    
    init(translatedString: String, translatedStringTopBorder: String?, screen: Screen) {
        self.translatedString = translatedString
        self.translatedStringTopBorder = translatedStringTopBorder
        self.screen = screen
        let uiFont = AppleFont.systemFont(ofSize: screen.uiFontSize * 0.7, weight: .regular)
        self.font = Font(uiFont)
    }
    
    var body: some View {
        
        //let _ = print(display.data.left)
        GeometryReader { geometry in                    // Get the geometry
            ScrollView(.vertical) {
                VStack {
                    if translatedStringTopBorder != nil {
                        HStack(alignment: .bottom, spacing: 0.0) {
                            Text(translatedStringTopBorder!)
                                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                                .topBorder()
                            Spacer(minLength: 0.0)
                        }
                    }
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
