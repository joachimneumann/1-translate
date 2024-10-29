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
    @ObservedObject var translationResult: TranslationResult
    
    init(translation: TranslationResult) {
        self.translationResult = translation
    }

    
    var body: some View {
        let _ = print("TranslatedDisplay body")
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            if translationResult.overline != nil {
                Text(translationResult.overline!)
                    .overline()
                    .multilineTextAlignment(.trailing)
            }
            Text(translationResult.displayText)
                .multilineTextAlignment(.trailing)
        }
        .contextMenu {
            Button("Copy to Clipboard") {
                UIPasteboard.general.string = translationResult.copyText
            }
        }
        .minimumScaleFactor(0.1)
    }
}


#Preview {
    return TranslatedDisplay(translation: TranslationResult(displayText: "hello", overline: nil, spokenText: nil))
}
