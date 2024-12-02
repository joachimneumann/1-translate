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
        ZStack {
            RoundedRectangle(cornerRadius: 20).fill(Color.Neumorphic.main).softOuterShadow(offset: 6, radius: 3)
            VStack(spacing: 0.0) {
                HStack(spacing: 0.0) {
                    if translationResult.overline == nil {
                        Spacer(minLength: 0.0)
                        Text(translationResult.displayText)
                            .font(Font(uiFont))
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing, 20)
                            .padding(.top, 20)
                    } else {
                        ZStack {
                            (Text(translationResult.overline!)
                                .baselineOffset(1.1*uiFont.pointSize)
                                .underline(true, color: .white)
                             + Text(translationResult.displayText))
                            .foregroundColor(.clear)
                            .offset(y: -1.0 * uiFont.pointSize - 0.4*uiFont.pointSize)
                            Text(translationResult.overline!)
                                .foregroundColor(.white)
                            + Text(translationResult.displayText)
                        }
                        .font(Font(uiFont))
                    }
                }
                .foregroundColor(translationResult.error ? .orange : .white)
                .minimumScaleFactor(0.1)
                Spacer(minLength: 0.0)
            }
        }
//        .padding(20)
    }
    
}


#Preview {
//    let fontsize: CGFloat = 55.0
    let viewModel = TranslateViewModel()
    let _ = viewModel.translationManager.translateThis("555555", to: .romanNumerals)
    let screen = Screen()
    ZStack {
        Color.Neumorphic.main
        TranslateDisplay(uiFont: screen.translationFont, translationResult: viewModel.translationManager.result)
            .frame(height: 300)
            .padding(30)
    }
    .preferredColorScheme(.dark)

        
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
