//
//  SymbolKey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI
import SwiftGmp

@Observable class SymbolKey: Key {
    var model: SymbolKeyViewModel
    var bgColor: Color
    
    init(_ op: any OpProtocol) {
        self.model = SymbolKeyViewModel(op: op)
        self.bgColor = KeyColor.sixColors(op: op).upColor
        super.init()
    }
    
    func setColors(textColor: Color, upColor: Color, downColor: Color) {
        model.setColors(textColor: textColor, upColor: upColor, downColor: downColor)
//        bgColor = model.bgColor(isPressed: isPressed)
    }

//    override func visualDown1() {
//        bgColor = model.bgColor(isPressed: isPressed)
//        scale = 0.97
//    }
//    override func visualUp() {
//        bgColor = model.bgColor(isPressed: isPressed)
//        scale = 1.0
//    }
    
    override func view() -> AnyView {
        if model.symbol == "KeyboardSpacer" {
            return AnyView(Spacer(minLength: 0.0))
        } else {
            return AnyView(
                GeometryReader { geometry in
                    if geometry.notZero {
                        self.model.label
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(self.bgColor)
                            .clipShape(Capsule())
                            .onAppear {
                                self.model.newSize(geometry.size)
                            }
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
                .padding()
            x2.view()
                .padding()
            x3.view()
                .padding()
        }
        .padding()
    }
    .frame(height: 200)
}
