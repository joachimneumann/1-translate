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
        if symbol == "KeyboardSpacer" {
            return AnyView(Spacer(minLength: 0.0))
        } else {
            return AnyView(
                GeometryReader { geometry in
                    if geometry.notZero {
                        Label(model: SymbolKeyViewModel(op: self.op, size: min(geometry.size.width, geometry.size.height), color: self.txtColor))
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .background(self.bgColor)
                            .foregroundColor(self.txtColor)
                            .clipShape(Capsule())
                    }
                }
            )
        }
    }
}

#Preview {
    let x1: SymbolKey = SymbolKey(InplaceOperation.sqrt)
    let x2: SymbolKey = SymbolKey(InplaceOperation.acos)
    let x3: SymbolKey = SymbolKey(InplaceOperation.sqr)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 0.0) {
            x1.view()
            x2.view()
            x3.view()
        }
        .padding()
    }
}
