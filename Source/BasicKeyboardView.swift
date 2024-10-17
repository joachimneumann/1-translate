//
//  BasicKeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

struct BasicKeyboardView: View {
    var basicKeyboard: BasicKeyboard
    var body: some View {
        VStack(spacing: basicKeyboard.spacing) {
            ForEach(basicKeyboard.rows) { keyRow in
                HStack(spacing: basicKeyboard.spacing) {
                    ForEach(keyRow.keys) { key in
                        CalculatorKeyView(key: key)
                    }
                }
            }
        }
    }
}

#Preview {
    BasicKeyboardView(
        basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20),
        spacing: 10,
        keySize: CGSize(width: 60, height: 60)))
}
