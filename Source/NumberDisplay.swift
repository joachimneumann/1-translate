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
    let exponentLength: CGFloat
    let font: Font
    let kerning: CGFloat
    
    init(R: Representation, exponentLength: CGFloat, font: Font, kerning: CGFloat = 0.0) {
        self.R = R
        self.exponentLength = exponentLength
        self.font = font
        self.kerning = kerning
    }
    
    @ViewBuilder
    var errorText: some View {
        Text(R.error!)
            .kerning(kerning)
            .font(font)
            .lineLimit(0)
            .foregroundColor(.red)
            .frame(maxWidth: .infinity, alignment: .trailing)
//            .background(.yellow)
    }
    
    @ViewBuilder
    var mantissa: some View {
        Text(R.mantissa!)
            .kerning(kerning)
            .font(font)
            .lineLimit(0)
            .foregroundColor(.white)
            .multilineTextAlignment(.trailing)
            .frame(maxWidth: .infinity, alignment: .trailing)
//            .background(.yellow)
    }

    @ViewBuilder
    var exponent: some View {
        Text("e\(R.exponent!)")
            .kerning(kerning)
            .font(font)
//            .lineLimit(0)
            .foregroundColor(.white)
            .frame(maxWidth: exponentLength, alignment: .leading)
            .padding(.leading, 5)
//            .background(.green)
    }

    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            if R.error != nil {
                errorText
            } else {
                if R.mantissa != nil {
                    mantissa
                    if R.exponent != nil {
                        exponent
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NumberDisplay(R: Representation(mantissa: "55", exponent: 0, maxOutputLength: 10), exponentLength: 0, font: Font(Screen.appleFont(ofSize: 50, weight: .regular)))
        .frame(height: 300)
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
}
