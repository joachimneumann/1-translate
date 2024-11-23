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
    var keyWidth: CGFloat = 0.0
    var fourRows: CGFloat = 0.0
    var scrollingContentHeight: CGFloat = 0.0

    let spacing: CGFloat
    let keyboard: Keyboard

    init(spacing: CGFloat, keyboard: Keyboard) {
        print("3")
        self.spacing = spacing
        self.keyboard = keyboard
    }
    
    func newSize(_ size: CGSize) {
        fiveRows = size.height
        keyHeight = 0.2 * (fiveRows - 4 * spacing)
        fourRows = 4 * keyHeight + 3 * spacing
        scrollingContentHeight =
            CGFloat(keyboard.keyMatrix.count - 1) * keyHeight +
            CGFloat(keyboard.keyMatrix.count - 2) * spacing
        keyWidth = 0.25 * (size.width - 3 * spacing)
    }

}

