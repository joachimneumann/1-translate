//
//  ButtonPressModifier.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct ButtonPressModifier: ViewModifier {
    let key: Key
    let size: CGSize

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        key.down(value.location, in: size)
                    }
                    .onEnded { _ in
                        key.up()
                    }
            )
            .simultaneousGesture(
                LongPressGesture(minimumDuration: 0.5)
                    .onEnded { _ in
                        key.longPress()
                    }
            )
    }
}

extension View {
    func applyCalculatorPressGestures(key: Key, size: CGSize) -> some View {
        self.modifier(ButtonPressModifier(key: key, size: size))
    }
}
