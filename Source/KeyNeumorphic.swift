//
//  KeyNeumorphic.swift
//  Calculator
//
//  Created by Joachim Neumann on 05.12.2024.
//

import SwiftUI

struct KeyNeumorphic: ViewModifier {
    let diameter: CGFloat
    var visualState: VisualState
    
    func body(content: Content) -> some View {
        switch visualState {
        case .up:
            content
                .softOuterShadow(offset: 0.075 * diameter, radius: 0.0375 * diameter)
        case .center:
            content
                .softOuterShadow(
                    darkShadow:  Color.clear,
                    lightShadow: Color.clear,
                    offset: 0.075 * diameter, radius: 0)
                .softInnerShadow(Circle(), size: CGSize(width: diameter, height: diameter), darkShadow: Color.clear, lightShadow: Color.clear, radius: 0.125 * diameter)
        case .down:
            content
                .softInnerShadow(Circle(), size: CGSize(width: diameter, height: diameter), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, radius: 0.125 * diameter)
        }
    }
}

extension View {
    func neumorphic(diameter: CGFloat, _ visualState: VisualState) -> some View {
        self.modifier(KeyNeumorphic(diameter: diameter, visualState: visualState))
    }
}
