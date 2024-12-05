//
//  ButtonPressModifier.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct CalculatorPressGestures: ViewModifier {
    let key: KeyModel
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
    func applyCalculatorPressGestures(key: KeyModel, diameter: CGFloat) -> some View {
        self.modifier(CalculatorPressGestures(key: key, diameter: diameter))
    }
}
