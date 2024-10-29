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
    @State private var moveGradient = true
    @ObservedObject var translationResult: TranslationResult
    
    init(translation: TranslationResult) {
        self.translationResult = translation
    }
    
    
    var body: some View {
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
//        let screenWidth: CGFloat = 300.0// Screen.main.bounds.size.width
//        Rectangle()
//            .overlay {
//                LinearGradient(colors: [.white, .orange, .white], startPoint: .trailing, endPoint: .leading)
//                    .frame(width: 150)
//                    .offset(x: moveGradient ? -screenWidth/2 : screenWidth/2)
//            }
//            .animation(.linear(duration: 2).repeatForever(autoreverses: false), value: moveGradient)
//            .mask {
//                Text("Slide to power off")
//                    .foregroundColor(.white)
//                    .font(.largeTitle)
//            }
//            .onAppear {
//                self.moveGradient.toggle()
//            }
//            .foregroundColor(.white)
    }

}


#Preview {
    return TranslatedDisplay(translation: TranslationResult(displayText: "hello", overline: nil, spokenText: nil))
        .background (.yellow)

}
