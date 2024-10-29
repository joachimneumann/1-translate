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
    let configKeyImageName: String
    let configKeyBorderColor: Color?
    let borderwidth: CGFloat = 2
    var body: some View {
        VStack(spacing: spacing) {
            ForEach(basicKeyboard.rows) { keyRow in
                HStack(spacing: spacing) {
                    ForEach(keyRow.keys) { key in
                        if key.op.isEqual(to: ConfigOperation.config) {
                            if let borderColor = configKeyBorderColor {
                                Image(configKeyImageName)
                                    .resizable()
                                    .frame(width: key.keySize.width-borderwidth, height: key.keySize.height-borderwidth)
                                    .clipShape(Capsule())
                                    .overlay(
                                        Capsule().stroke(borderColor, lineWidth: borderwidth)
                                    )
//                                    .opacity(0.9)
                            } else {
                                Image(configKeyImageName)
                                    .resizable()
                                    .frame(width: key.keySize.width, height: key.keySize.height)
                                    .clipShape(Capsule())
//                                    .opacity(0.9)
                            }
                        } else {
                            CalculatorKeyView(key: key)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    let basicKeyboard: BasicKeyboard = BasicKeyboard(keySize: CGSize(width: 80.0, height: 50.0))
    VStack {
        Rectangle()
        BasicKeyboardView(spacing: 10, basicKeyboard: basicKeyboard, configKeyImageName: "English", configKeyBorderColor: Color(UIColor.lightGray))
            .background(.black)
            .padding(.bottom, 30)
    }
    .background(.black)
}
