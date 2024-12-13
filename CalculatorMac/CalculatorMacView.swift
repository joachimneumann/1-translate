//
//  CalculatorMacView.swift
//  Calculator
//
//  Created by Joachim Neumann on 07.12.2024.
//

import SwiftUI

struct CalculatorMacView: View {
    let model: ViewModel
    var body: some View {
        ZStack {
            HStack {
                Text(model.radDeg == .rad ? "Rad" : "")
                    .font(.system(size: 12))
                    .foregroundColor(Color.Neumorphic.text)
                    .padding(.leading, 20)
                    .padding(.bottom, model.keyboard.frame.height - 100)
                Spacer()
            }
            VStack(spacing: 0.0) {
                Spacer(minLength: 0.0)
                if model.isScientific && model.isMac {
                    HStack(spacing: 0.0) {
                        Spacer(minLength: 0.0)
                        NumberDisplay(display: model.display)
                            .padding(.horizontal, model.keyboard.padding)
                            .frame(width: model.displayWidth, height: model.keyboard.diameter * 1.4)
                            .padding(.bottom, model.keyboard.diameter * 0.1)
                    }
                    //.background(.yellow)
                } else {
                    NumberDisplay(display: model.display)
                        .padding(.horizontal, model.keyboard.padding)
                        .frame(width: model.displayWidth, height: model.keyboard.diameter * 1.4)
                        .padding(.bottom, model.keyboard.diameter * 0.2)
                }
                KeyboardView(keyboard: model.keyboard)
                    .frame(width: model.keyboard.frame.width, height: model.keyboard.frame.height)
                    .padding(.bottom, model.keyboard.padding * 0.2)
            }
        }
    }
}

#Preview("Dark") {
    CalculatorMacView(model: ViewModel(
        width: 500,
        height: 400,
        isTranslator: false,
        isMac: true,
        isScientific: true))
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    CalculatorMacView(model: ViewModel(
        width: 500,
        height: 400,
        isTranslator: false,
        isMac: true,
        isScientific: true))
        .preferredColorScheme(.light)
}