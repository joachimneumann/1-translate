//
//  Key.swift
//  bg
//
//  Created by Joachim Neumann on 11/27/22.
//

import SwiftUI
import SwiftGmp

struct Key: View {
    let screen: Screen
    let symbol: String
    let keySize: CGSize
    let xOffset: CGFloat
    let keyStatusColor: Color
    let textColor: Color
    let touchDown: (Key) -> ()
    let touchUp: (Key, Screen) -> ()
    let op: OpProtocol
    
    init(_ screen: Screen,
         _ viewModel: ViewModel,
         _ op: OpProtocol) {
        self.screen = screen
        self.symbol = op.getRawValue()
        var keyHeight = screen.keySize.height
        keyHeight *= 1.5
        if symbol == "0" {
            self.keySize = CGSize(
                width: 2.0 * screen.keySize.width + screen.keySpacing,
                height: keyHeight)
            xOffset = self.keySize.width * -0.5 + screen.keySize.width * 0.5
        } else {
            self.keySize = CGSize(
                width: screen.keySize.width,
                height: keyHeight)
            xOffset = 0.0
        }
        self.keyStatusColor = viewModel.keyStatusColor[symbol] ?? .green
        self.textColor = viewModel.textColor[symbol]           ?? .green
        self.touchDown = viewModel.touchDown
        self.touchUp   = viewModel.touchUp
        self.op = op
    }
    
    var body: some View {
        //let _ = print("KeyID_"+symbol.replacing("^", with: ""))
        Label(symbol: symbol, size: keySize.height, color: textColor)
            .offset(x: xOffset)
            .foregroundColor(textColor)
            .frame(width: keySize.width, height: keySize.height)
            .background(keyStatusColor)
#if os(macOS)
            .clipShape(Rectangle())
#else
            .clipShape(Capsule())
#endif
            .simultaneousGesture(DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    touchDown(self)
                }
                .onEnded { _ in
                    touchUp(self, screen)
                })
    }
}

struct Key_Previews: PreviewProvider {
    static var previews: some View {
        let screen = Screen(CGSize(width: 1400, height: 600))
        let viewModel = ViewModel()
        VStack {
            HStack {
                Key(screen, viewModel, InplaceOperation.sqrt)
                Key(screen, viewModel, ConstantOperation.pi)
            }
            Key(screen, viewModel, ConstantOperation.pi)
        }
        .foregroundColor(.white)
    }
}
