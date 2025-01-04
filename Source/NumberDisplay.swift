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
    func TextView(_ text: String, width: CGFloat? = nil) -> some View {
        if let width = width {
            Text(text)
                .frame(width: width, alignment: .leading)
        } else {
            Text(text)
                .frame(alignment: .trailing)
        }
    }

    
    var body: some View {
        ZStack {
            let size2 = CGSize(width: 20, height: 20)
            let size = CGSize(width: 10, height: 10)
            RoundedRectangle(cornerSize: size)
                .foregroundColor(Color.Neumorphic.main)
                .softInnerShadow(RoundedRectangle(cornerSize: size), size: size2, radius: 3)
            HStack(alignment: .bottom, spacing: 0.0) {
                Spacer(minLength: 0.0)
                TextView(display.left)
                    .foregroundColor(display.isError ? .orange : Color.Neumorphic.text)
                    .font(display.font)
                if let right = display.right {
                    TextView(right, width: display.rightWidth)
                        .font(display.font)
                        .padding(.leading, display.ePadding)
                }
            }
            .padding(.horizontal, display.textPadding)
        }
    }
}

var numberDisplayPreview: some View {
    let display = Display(floatDisplayWidth: 100, font: AppleFont.systemFont(ofSize: 40), ePadding: 0.0)
    let _ = display.left = "3.14"
    return ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
        VStack(spacing: 0.0) {
            Spacer()
            NumberDisplay(display: display)
                .padding(.horizontal, 14)
            Spacer()
        }
    }
}

#Preview("Dark") {
    numberDisplayPreview
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    numberDisplayPreview
        .preferredColorScheme(.light)
}

