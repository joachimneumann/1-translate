//
//  KeyGestures.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct KeyGestures: ViewModifier {
    let key: KeyAnimation
    let diameter: CGFloat

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        //print("XXX \(value.location)")
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
    func keyGestures(key: KeyAnimation, diameter: CGFloat) -> some View {
        self.modifier(KeyGestures(key: key, diameter: diameter))
    }
}
