//
//  NumberDisplay.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import SwiftGmp

struct NumberDisplay: View {
    let text: String
    let font: Font
    let kerning: CGFloat
    
    init(text: String, font: Font, kerning: CGFloat = 0.0) {
        self.text = text
        self.font = font
        self.kerning = kerning
        //let uiFont = Screen.appleFont(ofSize: screen.uiFontSize, weight: .regular)
    }
    
    @ViewBuilder
    var mantissa: some View {
        let toShow = text
        Text(toShow)
            .kerning(kerning)
            .font(font)
            .lineLimit(0)
            .foregroundColor(.white)
            .multilineTextAlignment(.trailing)
            .minimumScaleFactor(0.1)
            .frame(maxWidth: .infinity, alignment: .trailing)
            .background(.yellow)
    }
    
    var body: some View {
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            mantissa
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

#Preview {
    NumberDisplay(text: "55", font: Font(Screen.appleFont(ofSize: 50, weight: .regular)))
        .frame(height: 300)
        .padding()
        .background(Color.black)
        .foregroundColor(.white)
}
