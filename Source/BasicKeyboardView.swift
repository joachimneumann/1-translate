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
                        Text(key.label)
                            .foregroundColor(key.txtColor)
                            .frame(width: key.width, height: key.height)
                            .background(key.bgColor)
                            .clipShape(Capsule())
                            .simultaneousGesture(DragGesture(minimumDistance: 0)
                                .onChanged { _ in
                                    basicKeyboard.keyDown(key)
                                }
                                .onEnded { _ in
                                    basicKeyboard.keyUp (key)
                                })
                    }
                }
            }
        }
    }
}

#Preview {
    BasicKeyboardView(basicKeyboard: BasicKeyboard(calculator: Calculator(precision: 20)))
}
