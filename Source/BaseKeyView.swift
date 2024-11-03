//
//  BaseKeyView.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 03.11.2024.
//

import SwiftUI
import SwiftGmp

struct BaseKeyView: View {
    var baseKey: BaseKey
    var body: some View {
        baseKey.view()
            .onLongPressGesture(minimumDuration: 0.5) {
                        //                            if key.op.isEqual(to: ClearOperation.back) {
                        //                                key.callback(Key(ClearOperation.clear))
                        //                            } else {
                        //                                /// do nothing additionally on long press
                        //                            }
                    }
                onPressingChanged: { inProgress in
                    if inProgress {
                        baseKey.down()
                    } else {
                        if baseKey.isPressed {
//                            baseKey.callback(baseKey)
                        }
                        baseKey.up()
                    }
                }
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { value in
                            if baseKey.isPressed {
                                /// If the finger moves too far away from the key
                                /// handle that like a finger up event
                                if !baseKey.toleranceRect.contains(value.location) {
                                    baseKey.up()
                                }
                            }
                        }
                )    }
}

#Preview {
    let symbol = SymbolKey(width: 100.0, height: 100.0, op: InplaceOperation.sqr)
    let image = ImageKey(width: 100.0, height: 100.0, imageName: "Deutsch", borderColor: .green, borderwidth: 5.0)
    ZStack {
        Rectangle()
            .foregroundColor(.gray)
        VStack {
            BaseKeyView(baseKey: symbol)
            BaseKeyView(baseKey: image)
        }
    }
}
