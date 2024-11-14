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
        key.view()
            .onLongPressGesture(minimumDuration: 0.5) {
                if let symbolKey = key as? SymbolKey {
                    if symbolKey.op.isEqual(to: ClearOperation.back) {
                        symbolKey.callback(SymbolKey(ClearOperation.clear))
                    }
                }
            }
                onPressingChanged: { inProgress in
                    if inProgress {
                        key.down()
                    } else {
                        if key.isPressed {
                            key.callback(key)
                        }
                        key.up()
                    }
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if key.isPressed {
                                /// If the finger moves too far away from the key
                                /// handle that like a finger up event
                                if !key.toleranceRect.contains(value.location) {
                                    key.up()
                                }
                            }
                        }
                )    }
}

#Preview {
    let symbol1 = SymbolKey(InplaceOperation.sqr)
    let symbol3 = SymbolKey(Translate_1Operation.spacer)
    let symbol2 = SymbolKey(DigitOperation.five)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        HStack {
            KeyView(key: symbol1)
            KeyView(key: symbol2)
            KeyView(key: symbol3)
        }
    }
}
