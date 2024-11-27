//
//  ButtonPressModifier.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct ButtonPressModifier: ViewModifier {
    let key: Key
    let diameter: CGFloat

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        key.down(value.location, in: diameter)
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
    func applyCalculatorPressGestures(key: Key, diameter: CGFloat) -> some View {
        self.modifier(ButtonPressModifier(key: key, diameter: diameter))
    }
}
