//
//  NumberDisplay.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import SwiftGmp

struct NumberDisplay: View {
    let R: Representation
    
    @ViewBuilder
    func errorView(_ error: Content) -> some View {
        Text(error.text)
            .kerning(R.kerning)
            .font(Font(error.uiFont))
            .lineLimit(0)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(.yellow)
    }
    
    @ViewBuilder
    func mantissaView(_ mantissa: Content) -> some View {
        Text(mantissa.text)
            .kerning(R.kerning)
            .font(Font(mantissa.uiFont))
            .lineLimit(1)
            .foregroundColor(.white)
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(.yellow)
    }

    @ViewBuilder
    func exponentView(_ exponent: Content?) -> some View {
        if let exponent = exponent {
            Text(exponent.text)
                .kerning(R.kerning)
                .font(Font(exponent.uiFont))
                .lineLimit(1)
                .foregroundColor(.white)
                .frame(alignment: .leading)
                .padding(.leading, 5)
                .background(.green)
        }
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            if let error = R.error {
                errorView(error)
            } else if let number = R.number {
                mantissaView(number.mantissa)
                exponentView(number.exponent)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    let screen = Screen(CGSize(width: 500, height: 500))
    NumberDisplay(R: Representation(error: "Preview", uiFont: screen.proportionalFont))
        .frame(height: 300)
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
}
