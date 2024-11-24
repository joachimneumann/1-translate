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
    var translationViewWidth: CGFloat = 0.0
    var translationViewHeight: CGFloat = 0.0

    func setSize(_ size: CGSize, isScrollView: Bool) {
        keyboardHeight = 0.8 * size.height
        displayHeight = size.height - keyboardHeight
        keySpacing = 0.025 * keyboardHeight
        keyDiameter = 0.2 * (keyboardHeight - 4 * keySpacing)
        keyboardWidth = 4 * keyDiameter + 3 * keySpacing
        translationViewWidth = size.width - 16 - keyboardWidth - 40
        print("translationViewWidth \(translationViewWidth)")
        translationViewHeight = keyboardHeight
        if isScrollView {
            keyboardWidth += 16 // for the scrollview indicator
        }
    }
}
