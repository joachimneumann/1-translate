//
//  NonScientificKeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

struct SmallKeyboardView: View {
    @State private var navigateToConfigView = false
    
    let spacing: CGFloat
    var basicKeyboard: SmallKeyboard
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(basicKeyboard.keyMatrix, id: \.self) { row in
                HStack(spacing: spacing) {
                    ForEach(row) { key in
                        CalculatorKeyView(key: key)
                    }
                }
            }
        }
    }
}

#Preview {
    //    let smallKeyboard: SmallKeyboard = TranslatorKeyboard(keySize: CGSize(width: 80.0, height: 50.0))
    let smallKeyboard: SmallKeyboard = LanguageSelectorKeyboard(keySize: CGSize(width: 80.0, height: 50.0), translationManager: TranslationManager())
    VStack {
        Rectangle()
        SmallKeyboardView(spacing: 20, basicKeyboard: smallKeyboard)
            .background(.black)
            .padding(.bottom, 30)
    }
    .background(.black)
}
