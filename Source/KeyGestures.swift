//
//  KeyGestures.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI

struct KeyGestures: ViewModifier {
    let key: KeyAnimation
    let width: CGFloat
    let height: CGFloat

    func body(content: Content) -> some View {
        content
            .simultaneousGesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        //print("XXX \(value.location)")
                        key.down(value.location, in: CGSize(width: width, height: height))
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
    func keyGestures(key: KeyAnimation, width: CGFloat, height: CGFloat) -> some View {
        self.modifier(KeyGestures(key: key, width: width, height: height))
    }
}
