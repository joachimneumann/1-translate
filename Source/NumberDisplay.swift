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
        ZStack {
            let size2 = CGSize(width: 30, height: 30)
            let size = CGSize(width: 20, height: 20)
            RoundedRectangle(cornerSize: size)
                .foregroundColor(Color.Neumorphic.main)
                .softInnerShadow(RoundedRectangle(cornerSize: size), size: size2, radius: 3)
                .frame(height: 100)
            HStack(alignment: .bottom, spacing: 0.0) {
                Spacer(minLength: 0.0)
                Text(display.left)
                    .foregroundColor(Color.Neumorphic.text)
                    .font(display.font)
                    .padding(.trailing, 10)
            }
        }
        
//        HStack(alignment: .bottom, spacing: 0.0) {
//            Spacer(minLength: 0.0)
//            Text(display.left)
//                .frame(maxWidth: .infinity, alignment: .trailing)
//                .background(.green)
//            if let right = display.right {
//                TextView(right, width: display.rightWidth)
//                    .padding(.leading, display.ePadding)
//            }
//        }
//        .font(display.font)
//        .lineLimit(1)
//        .foregroundColor(display.isError ? .orange : .white)
//        .frame(maxWidth: .infinity)//, maxHeight: .infinity)
//        .softInnerShadow(Rectangle(), size: CGSize(width: 10, height: 10), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, radius: 0.125 * 10)
//        .background(.yellow)
    }
}

var numberDisplayPreview: some View {
    let display = Display(floatDisplayWidth: 100, font: AppleFont.systemFont(ofSize: 40), ePadding: 0.0)
    let _ = display.left = "3.14"
    return ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
            .ignoresSafeArea()
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

