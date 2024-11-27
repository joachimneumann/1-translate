//
//  CalculatorButton.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct CalculatorButton: View {
    let model: CalculatorButtonModel
    var body: some View {
        model.view
    }
}

#Preview("Dark") {
    Demo(diameter: 80)
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    Demo(diameter: 80)
        .preferredColorScheme(.light)
}

