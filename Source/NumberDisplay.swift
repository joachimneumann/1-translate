//
//  NumberDisplay.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import SwiftGmp

struct NumberDisplay: View {
    @ObservedObject var display: Display

    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            Text(display.leftContent.text)
                .font(display.leftContent.font)
                .lineLimit(1)
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .background(.green)
            if let right = display.rightContent {
                Text(right.text)
                    .font(right.font)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .multilineTextAlignment(.trailing)
                    .frame(alignment: .trailing)
                    .background(.blue)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.yellow)
    }
}

//#Preview {
//    let screen = Screen(CGSize(width: 500, height: 500))
//    NumberDisplay(R: Representation(error: "Preview", appleFont: screen.proportionalFont))
//        .frame(height: 300)
//        .padding()
//        .background(Color.black)
//        .foregroundColor(.white)
//}
