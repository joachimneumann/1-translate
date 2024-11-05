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
            Text(display.left)
                .frame(maxWidth: .infinity, alignment: .trailing)
//                .background(.green)
            if let right = display.right {
                TextView(right, width: display.rightWidth)
                    .padding(.leading, display.ePadding)
            }
        }
        .font(display.font)
        .lineLimit(1)
        .foregroundColor(display.isError ? .orange : .white)
        .frame(maxWidth: .infinity)//, maxHeight: .infinity)
//        .background(.yellow)
    }
}

#Preview {
    let display = Display(floatDisplayWidth: 100, font: AppleFont.systemFont(ofSize: 40), ePadding: 0.0)
    let _ = display.left = "3.14"
    NumberDisplay(display: display)
        .frame(height: 300)
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
}
