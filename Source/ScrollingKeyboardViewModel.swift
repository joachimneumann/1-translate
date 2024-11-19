//
//  ScrollingKeyboardViewModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 19.11.2024.
//


import SwiftUI
@Observable class ScrollingKeyboardViewModel {
#if TRANSLATE_MAC
    let backgroundColor = Color(red: 52/255, green: 54.0 / 255.0, blue: 56.0 / 255.0, opacity: 1.0)
#else
    let backgroundColor = Color.black
#endif
    
    var fiveRows: CGFloat = 0.0
    var keyHeight: CGFloat = 0.0
    var fourRows: CGFloat = 0.0
    var scrollingKeysheight: CGFloat = 0.0

    let spacing: CGFloat
    let keyboard: Keyboard
    let scrolling: Bool

    init(spacing: CGFloat, keyboard: Keyboard) {
        self.spacing = spacing
        self.keyboard = keyboard
        scrolling = keyboard.keyMatrix.count > 4
    }
    
    func newHeight(_ height: CGFloat) {
        fiveRows = height
        keyHeight = 0.2 * (fiveRows - 4 * spacing)
        fourRows = 4 * keyHeight + 3 * spacing
        scrollingKeysheight =
            CGFloat(keyboard.keyMatrix.count - 1) * keyHeight +
            CGFloat(keyboard.keyMatrix.count - 2) * spacing
    }

}

