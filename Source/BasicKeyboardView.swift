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
        VStack {
            ForEach(basicKeyboard.rows) { keyRow in
                HStack {
                    ForEach(keyRow.keys) { key in
                        AnimatedKey(key: key)
                    }
                }
            }
        }
    }
}

#Preview {
    BasicKeyboardView(basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20)))
}
