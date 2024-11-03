//
//  KeyPressModifier.swift
//  TranslateNumbers
//
//  Created by Joachim Neumann on 02.11.2024.
//

import SwiftUI

struct KeyPressModifier: ViewModifier {
    let key: Key
    let isPressed: Bool
    let toleranceRect: CGRect
    
    let downAction: () -> Void
    let upAction: () -> Void
    let callback: () -> Void

    func body(content: Content) -> some View {
        content
            .onLongPressGesture(minimumDuration: 0.5) {
//                if key.op.isEqual(to: ClearOperation.back) {
//                    key.callback(Key(ClearOperation.clear))
//                }
            }
            onPressingChanged: { inProgress in
                if inProgress {
                    downAction()
                } else {
                    if isPressed {
                        key.callback(key)
                    }
                    upAction()
                }
            }
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        if isPressed && !toleranceRect.contains(value.location) {
                            upAction()
                        }
                    }
            )
    }
}
