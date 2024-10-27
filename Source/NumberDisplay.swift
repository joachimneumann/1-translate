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
    func errorView(_ error: Display.Content) -> some View {
        Text(error.text)
            .font(Font(error.font))
            .lineLimit(0)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .trailing)
            //.background(.yellow)
    }
    
    @ViewBuilder
    func mantissaView(_ mantissa: Display.Content) -> some View {
        Text(mantissa.text)
            .font(Font(mantissa.font))
            .lineLimit(1)
            .foregroundColor(.white)
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
            //.background(.yellow)
    }

    @ViewBuilder
    func exponentView(_ exponent: Display.Content?) -> some View {
        if let exponent = exponent {
            Text(exponent.text)
                .font(Font(exponent.font))
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                .padding(.leading, 5)
                //.background(.green)
        }
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            if let error = display.error {
                errorView(error)
            } else if let number = display.number {
                mantissaView(number.mantissa)
                exponentView(number.exponent)
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
