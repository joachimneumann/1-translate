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

    @ViewBuilder
    func TextView(_ text: String, width: CGFloat?) -> some View {
        if let width = width {
            Text(text)
                .frame(width: width, alignment: .leading)
        } else {
            Text(text)
                .frame(alignment: .trailing)
        }
    }

    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            Text(display.leftContent.text)
                .font(display.leftContent.font)
                .lineLimit(1)
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .frame(maxWidth: .infinity, alignment: .trailing)
//                .background(.green)
            if let rightContext = display.rightContent {
                TextView(rightContext.text, width: rightContext.width)
                    .font(rightContext.font)
                    .lineLimit(1)
                    .foregroundColor(.white)
                    .padding(.leading, display.ePadding)
            }
        }
        .frame(maxWidth: .infinity)//, maxHeight: .infinity)
//        .background(.yellow)
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
