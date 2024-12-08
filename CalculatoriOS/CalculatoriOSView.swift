//
//  CalculatoriOSView.swift
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import Neumorphic

struct CalculatoriOSView: View {
    let model: ViewModel
    
    var body: some View {
        //let _ = print("CalculatoriOSView body()")
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
                .ignoresSafeArea()
            VStack(spacing: 0.0) {
                Spacer()
                NumberDisplay(display: model.display)
                    .padding(.horizontal, model.keyboard.padding)
                    .padding(.bottom, model.keyboard.padding * 0.2)
                    .frame(width: model.keyboard.frame.width, height: model.keyboard.diameter * 1.5)
                HStack {
                    Spacer()
                    KeyboardView(keyboard: model.keyboard)
                        .frame(width: model.keyboard.frame.width, height: model.keyboard.frame.height)
                    Spacer()
                }
            }
        }
    }
}


#Preview("Dark") {
    CalculatoriOSView(model: ViewModel(
        width: defaultWidth,
        height: defaultHeight,
        isTranslator: false,
        isMac: false,
        isScientific: false))
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    CalculatoriOSView(model: ViewModel(
        width: defaultWidth,
        height: defaultHeight,
        isTranslator: false,
        isMac: false,
        isScientific: false))
        .preferredColorScheme(.light)
}

