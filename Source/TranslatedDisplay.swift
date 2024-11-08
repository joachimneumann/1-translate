//
//  TranslatedDisplay.swift
//
//  Created by Joachim Neumann on 12/4/23.
//

import SwiftUI

struct TranslatedDisplay: View {
    let uiFont: UIFont
    @State private var moveGradient = true
    @ObservedObject var translationResult: TranslationResult
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            if translationResult.overline == nil {
                Text(translationResult.displayText)
                    .font(Font(uiFont))
            } else {
                ZStack {
                    (Text(translationResult.overline!)
                        .baselineOffset(uiFont.pointSize)
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
    let fontsize: CGFloat = 60.0
    TranslatedDisplay(uiFont: UIFont.systemFont(ofSize: fontsize), translationResult: TranslationResult(displayText: "DCCCdlfgjksdlfkjgdflkjLXXl", overline: "VIlggksdII", spokenText: nil))
        .padding()
        .padding(.top, fontsize)
        .background (.black)
    
}
