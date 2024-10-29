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
        let _ = print("NumberDisplay body")
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            Text(display.leftContent.text)
                .frame(maxWidth: .infinity, alignment: .trailing)
//                .background(.green)
            if let rightContext = display.rightContent {
                TextView(rightContext.text, width: rightContext.width)
                    .padding(.leading, display.ePadding)
            }
        }
        .font(display.font)
        .lineLimit(1)
        .foregroundColor(.white)
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
