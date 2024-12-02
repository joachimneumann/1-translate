//
//  CalculatorKeyView.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct CalculatorKeyView: View {
    let model: CalculatorKey
    var body: some View {
        ZStack {
            Color.Neumorphic.main
                .frame(width: model.diameter, height: model.diameter)
                .clipShape(Circle())
                .neumorphic(diameter: model.diameter, model.visualPressed)
            if let flag = model.flag {
                flag
            }
            if let symbol = model.symbol {
                symbol
            }
        }
        .applyCalculatorPressGestures(key: model, diameter: model.diameter)
    }
}

#Preview("Dark") {
    Demo()
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    Demo()
        .preferredColorScheme(.light)
}

