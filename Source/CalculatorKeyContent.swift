//
//  CalculatorKeyContent.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI
import SwiftGmp

struct CalculatorKeyContent: View {
    
    private let key: Key
    private let bgColor: Color
    
    init(key: Key, bgColor: Color) {
        self.key = key
        self.bgColor = bgColor
    }
    
    var body: some View {
        if let imageName = key.imageName {
            let borderwidth: CGFloat = 5
            let w = key.borderColor == nil ? 0 : borderwidth
            let _ = print("CalculatorKeyView Image \(imageName)")
            Image(imageName)
                .resizable()
                .frame(width: key.keySize.width-2*w, height: key.keySize.height-2*w)
                .clipShape(Capsule())
                .padding(0.5*w)
                .overlay(
                    key.borderColor.map { Capsule().stroke($0, lineWidth: w) }
                )
                .padding(0.5*w)
        } else {
            Label(symbol: key.op.getRawValue(), size: key.keySize.height, color: key.isPending ? key.sixColors.pendingTextColor : key.sixColors.textColor)
                .padding()
                .frame(width: key.keySize.width, height: key.keySize.height)
                .background(bgColor)
                .clipShape(Capsule())
        }
    }
}

#Preview {
    @Previewable @State var x: Bool = false
        let key = Key(InplaceOperation.sqrt3)
//    let key = Key(ConfigOperation.bottomLeft)
    let _ = key.imageName = "English"
    let _ = key.borderColor = .yellow
    let _ = key.keySize = CGSize(width: 100, height: 100)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        CalculatorKeyContent(key: key, bgColor: .red)
    }
}
