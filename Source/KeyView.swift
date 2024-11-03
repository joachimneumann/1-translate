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
                        //                            if key.op.isEqual(to: ClearOperation.back) {
                        //                                key.callback(Key(ClearOperation.clear))
                        //                            } else {
                        //                                /// do nothing additionally on long press
                        //                            }
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
    let symbol = SymbolKey(InplaceOperation.sqr)
    let image = FlagKey(flagname: "Deutsch")
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        VStack {
            KeyView(key: symbol)
            KeyView(key: image)
        }
    }
}
