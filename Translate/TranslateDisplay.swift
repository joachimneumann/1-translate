//
//  TranslateDisplay.swift
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI
import Neumorphic

struct TranslateDisplay: View {
    let uiFont: AppleFont
    @State private var moveGradient = true
    @ObservedObject var translationResult: TranslationResult
    
    var body: some View {
        HStack(spacing: 0.0) {
            if translationResult.overline == nil {
                Spacer(minLength: 0.0)
                Text(translationResult.displayText)
                    .foregroundColor(translationResult.error ? .orange : Color.Neumorphic.text)
                    .font(Font(uiFont))
                    .multilineTextAlignment(.trailing)
            } else {
                ZStack {
                    (Text(translationResult.overline!)
                        .baselineOffset(1.1*uiFont.pointSize)
                        .foregroundColor(Color.Neumorphic.text)
                        .underline(true, color: .white)
                     + Text(translationResult.displayText))
                    .foregroundColor(.clear)
                    .offset(y: -1.0 * uiFont.pointSize - 0.4*uiFont.pointSize)
                    Text(translationResult.overline!)
                        .foregroundColor(Color.Neumorphic.text)
                    + Text(translationResult.displayText)
                        .foregroundColor(Color.Neumorphic.text)
                }
                .font(Font(uiFont))
            }
        }
        .foregroundColor(translationResult.error ? .orange : .white)
        .minimumScaleFactor(0.1)
        .frame(maxHeight: .infinity)
    }
    
}


var translateDisplayPreview: some View {
    let viewModel = TranslateViewModel(.translator, width: defaultWidth, height: defaultHeight)
    let _ = viewModel.translationManager.translateThis("4", to: .german)
    return ZStack {
        Color.Neumorphic.main
        TranslateDisplay(uiFont: AppleFont.systemFont(ofSize: 20, weight: .light), translationResult: viewModel.translationManager.result)
            .padding(30)
    }
}

#Preview("Dark") {
    translateDisplayPreview
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    translateDisplayPreview
        .preferredColorScheme(.light)
}


//        .contextMenu {
//            Button("Copy to Clipboard") {
//                UIPasteboard.general.string = translate_1Result.copyText
//            }
//        }



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
