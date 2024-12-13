//
//  NeumorphicKey.swift
//  Calculator
//
//  Created by Joachim Neumann on 05.12.2024.
//

import SwiftUI


public enum VisualState {
    case up
    case center
    case down
}

public struct NeumorphicKey: ViewModifier {
    let width: CGFloat
    let height: CGFloat
    var visualState: VisualState
    
    public func body(content: Content) -> some View {
        switch visualState {
        case .up:
            content
                .softOuterShadow(offset: 0.075 * min(width, height), radius: 0.0375 * min(width, height))
        case .center:
            content
                .softOuterShadow(
                    darkShadow:  Color.clear,
                    lightShadow: Color.clear,
                    offset: 0.075 * min(width, height), radius: 0)
                .softInnerShadow(Capsule(), size: CGSize(width: width, height: height), darkShadow: Color.clear, lightShadow: Color.clear, radius: 0.125 * min(width, height))
        case .down:
            content
                .softInnerShadow(Capsule(), size: CGSize(width: width, height: height), darkShadow: Color.Neumorphic.darkShadow, lightShadow: Color.Neumorphic.lightShadow, radius: 0.125 * min(width, height))
        }
    }
}

extension View {
    public func neumorphicKey(width: CGFloat, height: CGFloat, _ visualState: VisualState) -> some View {
        self.modifier(NeumorphicKey(width: width, height: height, visualState: visualState))
    }
}
