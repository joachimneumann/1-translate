//
//  KeyboardView.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI

struct KeyboardView: View {
    @State private var navigateToConfigView = false
    @State var keyboard: KeyboardModel
    
    init(keyboard: KeyboardModel) {
        self.keyboard = keyboard
    }
    
    var body: some View {
        VStack(spacing: keyboard.spacing) {
            ForEach(keyboard.keyMatrix.indices, id: \.self) { rowIndex in
                HStack(spacing: keyboard.spacing) {
                    ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
                        KeyView(key: key)
                            .frame(width: key.width, height: key.height)
                    }
                }
            }
        }
        .padding(keyboard.padding)
    }
}

var keyboardPreview: some View {
    let keyboard: KeyboardModel = KeyboardModel()
    let _ = keyboard.scientificKeyboard(width: 550, height: 300)

    return ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
            .ignoresSafeArea()
        VStack {
            Spacer()
            HStack {
                Spacer()
                KeyboardView(keyboard: keyboard)
                    .frame(width: keyboard.keyboardFrame.width, height: keyboard.keyboardFrame.height)
                Spacer()
            }
        }
    }
}

#Preview("Dark") {
    keyboardPreview
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    keyboardPreview
        .preferredColorScheme(.light)
}
