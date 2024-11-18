//
//  KeyView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI
import SwiftGmp

struct KeyView: View {
    var key: Key
    
    var body: some View {
            GeometryReader { geometry in
                if geometry.notZero {
                    key.view()
//                        .onLongPressGesture(minimumDuration: 0.5) {
//                            if let symbolKey = key as? SymbolKey {
//                                if symbolKey.op.isEqual(to: ClearOperation.back) {
//                                    symbolKey.callback(SymbolKey(ClearOperation.clear))
//                                }
//                            }
//                        }
                        .gesture(
                            DragGesture(minimumDistance: 0)
                                .onChanged { value in
                                    key.down(value.location)
                                }
                                .onEnded { value in
                                    key.up()
                                })
                    
//                    onPressingChanged: { inProgress in
//                        print("onPressingChanged \(inProgress)")
//                        if inProgress {
//                            key.down()
//                        } else {
//                            if key.isPressed {
//                                key.callback(key)
//                            }
//                            key.up()
//                        }
//                    }
//                    .simultaneousGesture(
//                        DragGesture(minimumDistance: 0)
//                            .onChanged { value in
//                                let tolerance: CGFloat = 0.3 * geometry.size.width
//                                let touchRect = CGRect(
//                                    x: -tolerance,
//                                    y: -tolerance,
//                                    width: geometry.size.width + 2.0 * tolerance,
//                                    height: geometry.size.height + 2.0 * tolerance)
//                                if key.isPressed {
//                                    /// If the finger moves too far away from the key
//                                    /// handle that like a finger up event
//                                    if !touchRect.contains(value.location) {
//                                        key.up()
//                                    }
//                                }
//                            }
//                    )
                }
            }
        }
}

#Preview {
    let symbol1 = SymbolKey(InplaceOperation.sqr)
    let symbol3 = SymbolKey(DigitOperation.one)
    let symbol2 = SymbolKey(DigitOperation.five)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack(spacing: 10) {
            KeyView(key: symbol1)
            KeyView(key: symbol2)
            KeyView(key: symbol3)
        }
        .frame(width: 320, height: 100)
    }
}
