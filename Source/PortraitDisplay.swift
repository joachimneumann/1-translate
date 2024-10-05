//
//  PortraitDisplay.swift
//  Calculator
//
//  Created by Joachim Neumann on 11/18/22.
//

import SwiftUI
import SwiftGmp

struct PortraitDisplay: View {
    let lr: LR
    let screen: Screen
    private let font: Font
    
    init(lr: LR, screen: Screen) {
        self.lr = lr
        self.screen = screen
        
        /// calculate possibly expanded font
        var availableDisplayWidth = screen.displayWidth
        if lr.right != nil {
            availableDisplayWidth -= screen.ePadding
        }
        let text = lr.string
        let n = CGFloat(text.count)
        let lengthOfNulls = n * screen.digitWidth
        var factor: CGFloat = 1.0
        let expandLimit = screen.displayWidth - screen.digitWidth * 0.9
        if lengthOfNulls < expandLimit {
            /// scale up
            factor = expandLimit / lengthOfNulls
            if factor > 2.0 { factor = 2.0 }
            if factor < 1.0 { factor = 1.0 }
        }
        let uiFont = Screen.appleFont(ofSize: screen.uiFontSize * factor)
        font = Font(uiFont)
    }
    
    @ViewBuilder
    var mantissa: some View {
        let toShow = lr.left
        Text(toShow)
            .kerning(screen.kerning)
            .font(font)
            .lineLimit(0)
            .foregroundColor(.white)
            .multilineTextAlignment(.trailing)
    }

    @ViewBuilder
    var exponent: some View {
        if let exponent = lr.right {
            Text(exponent)
                .kerning(screen.kerning)
                .font(font)
                .foregroundColor(.white)
                .multilineTextAlignment(.trailing)
                .lineLimit(1)
                .padding(.leading, screen.ePadding)
        }
    }
    
    var body: some View {
        // add a blue circle
        //let _ = print(display.data.left)
        HStack(alignment: .bottom, spacing: 0.0) {
            Spacer(minLength: 0.0)
            mantissa
            exponent
        }
    }
}

#Preview {
    PortraitDisplay(lr: LR("111"), screen: Screen(CGSize(width: 100, height: 100)))
        .frame(height: 300)
        .background(Color.black)
        .foregroundColor(.white)
}
