//
//  BasicKeyboardView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 16.10.24.
//

import SwiftUI
import SwiftGmp

struct BasicKeyboardView: View {
    let spacing: CGFloat
    var basicKeyboard: BasicKeyboard
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(basicKeyboard.rows) { keyRow in
                HStack(spacing: spacing) {
                    ForEach(keyRow.keys) { key in
                        CalculatorKeyView(key: key)
                    }
                }
            }
        }
    }
}

//#Preview {
//    var res: String
//    BasicKeyboardView(
//        basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20),
//        result: $res,
//        spacing: 10,
//        keySize: CGSize(width: 60, height: 60)))
//}
