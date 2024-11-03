//
//  SymbolKey.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI
import SwiftGmp

@Observable class SymbolKey: BaseKey {
    let symbol: String
    let txtColor: Color
    var bgColor: Color
    private let upColor: Color
    private let downColor: Color
    
    init(width: CGFloat, height: CGFloat, op: any OpProtocol) {
        self.symbol = op.getRawValue()
        self.txtColor = KeyColor.sixColors(op: op).textColor
        self.upColor = KeyColor.sixColors(op: op).upColor
        self.downColor = KeyColor.sixColors(op: op).downColor
        self.bgColor = upColor
        super.init(width: width, height: height)
    }

    override func visualDown() {
        bgColor = downColor
    }
    override func visualUp() {
        bgColor = upColor
    }
    override func view() -> AnyView {
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

#Preview {
    @Previewable @State var x: SymbolKey = SymbolKey(width: 100.0, height: 100.0, op: InplaceOperation.sqr)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        x.view()
    }
}
