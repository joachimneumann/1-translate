//
//  TranslateDisplay.swift
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

struct TranslateDisplay: View {
    let uiFont: AppleFont
    @State private var moveGradient = true
    @ObservedObject var translationResult: TranslateResult
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            if translationResult.overline == nil {
                Text(translationResult.displayText)
                    .font(Font(uiFont))
//                    .multilineTextAlignment(.trailing)
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
//        .contextMenu {
//            Button("Copy to Clipboard") {
//                UIPasteboard.general.string = translate_1Result.copyText
//            }
//        }
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
    let fontsize: CGFloat = 55.0
    let viewModel = TranslateViewModel()
    let _ = viewModel.translate_1Manager.translateThis("5555", to: .polish)

    TranslateDisplay(uiFont: AppleFont.systemFont(ofSize: fontsize), translationResult: viewModel.translate_1Manager.result)
        .padding()
        .padding(.top, fontsize)
        .background (.black)
    
}
