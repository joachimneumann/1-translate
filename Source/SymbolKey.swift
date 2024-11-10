//
//  SymbolKey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI
import SwiftGmp

@Observable class SymbolKey: Key {
    var symbol: String
    var op: any OpProtocol
    let txtColor: Color
    var bgColor: Color
    var upColor: Color
    var downColor: Color
    
    init(_ op: any OpProtocol) {
        self.symbol = op.getRawValue()
        self.op = op
        self.txtColor = KeyColor.sixColors(op: op).textColor
        self.upColor = KeyColor.sixColors(op: op).upColor
        self.downColor = KeyColor.sixColors(op: op).downColor
        self.bgColor = KeyColor.sixColors(op: op).upColor
        super.init()
    }
    
    func setColors(upColor: Color, downColor: Color) {
        self.upColor = upColor
        self.downColor = downColor
        if isPressed {
            bgColor = downColor
        } else {
            bgColor = upColor
        }
    }

    override func visualDown() {
        bgColor = downColor
    }
    override func visualUp() {
        bgColor = upColor
    }
    override func view() -> AnyView {
        if symbol == "Spacer" {
            return AnyView(Spacer())
        } else {
            return AnyView(
                Label(symbol: symbol, size: height, color: txtColor)
                    .padding()
                    .frame(width: width, height: height)
                    .background(bgColor)
                    .foregroundColor(txtColor)
                    .clipShape(Capsule())
            )
        }
    }
}

#Preview {
    @Previewable @State var x: SymbolKey = SymbolKey(InplaceOperation.sqr)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        x.view()
    }
}
