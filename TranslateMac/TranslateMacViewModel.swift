//
//  TranslateMacViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 19.11.2024.
//

import SwiftUI
@Observable class TranslateMacViewModel {
    var keyboardHeight: CGFloat = 0.0
    var displayHeight: CGFloat = 0.0
    var keySpacing: CGFloat = 0.0
    var keyDiameter: CGFloat = 0.0
    var keyboardWidth: CGFloat = 0.0

    func setHeight(_ height: CGFloat) {
        keyboardHeight = 0.8 * height
        displayHeight = height - keyboardHeight
        keySpacing = 0.025 * keyboardHeight
        keyDiameter = 0.2 * (keyboardHeight - 4 * keySpacing)
        keyboardWidth = 4 * keyDiameter + 3 * keySpacing
    }
}
