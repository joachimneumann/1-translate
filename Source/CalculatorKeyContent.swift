//
//  CalculatorKeyContent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI
import SwiftGmp

struct CalculatorKeyContent: View {
    private let height: CGFloat
    private let width: CGFloat
    private let imageName: String?
    private let borderColor: Color?
    private let symbol: String?
    private let txtColor: Color?
    private let bgColor: Color?
    private let borderwidth: CGFloat

    init(width: CGFloat, height: CGFloat, symbol: String, txtColor: Color, bgColor: Color) {
        self.width = width
        self.height = height
        self.symbol = symbol
        self.txtColor = txtColor
        self.bgColor = bgColor
        self.imageName = nil
        self.borderColor = nil
        self.borderwidth = 0.0
    }
    init(width: CGFloat, height: CGFloat, imageName: String, borderColor: Color) {
        self.width = width
        self.height = height
        self.symbol = nil
        self.txtColor = nil
        self.bgColor = nil
        self.imageName = imageName
        self.borderColor = borderColor
        self.borderwidth = 5.0
    }

    var body: some View {
        if let imageName = imageName {
            let borderwidth: CGFloat = 5
            let _ = print("CalculatorKeyView Image \(imageName)")
            Image(imageName)
                .resizable()
                .frame(width: width-2*borderwidth, height: height-2*borderwidth)
                .clipShape(Capsule())
                .padding(0.5*borderwidth)
                .overlay(
                    borderColor.map { Capsule().stroke($0, lineWidth: borderwidth) }
                )
                .padding(0.5*borderwidth)
        } else if let symbol = symbol {
            Label(symbol: symbol, size: height, color: txtColor!)
                .padding()
                .frame(width: width, height: height)
                .background(bgColor)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    @Previewable @State var x: Bool = false
    let key1 = Key(InplaceOperation.sqrt3)
    let key2 = Key(ConfigOperation.bottomLeft)
    let _ = key2.imageName = "English"
    let _ = key2.borderColor = .yellow
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        VStack {
            CalculatorKeyContent(width: 100.0, height: 100.0, symbol: "sqrt3", txtColor: .white, bgColor: .red)
            CalculatorKeyContent(width: 100.0, height: 100.0, imageName: "Deutsch", borderColor: .green)
        }
    }
}
