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
        VStack(spacing: 0.0) {
            Spacer(minLength: 0.0)
            if model.isScientific && model.isMac {
                HStack(spacing: 0.0) {
                    Spacer(minLength: 0.0)
                    NumberDisplay(display: model.display)
                        .padding(.horizontal, model.keyboard.padding)
                        .frame(width: model.displayWidth, height: model.keyboard.diameter * 1.4)
                        .padding(.bottom, model.keyboard.diameter * 0.2)
                }
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
