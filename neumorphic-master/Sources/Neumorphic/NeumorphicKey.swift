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

    private var pressedSurfaceOpacity: Double {
        switch visualState {
        case .up: 0.0
        case .center: 0.25
        case .down: 0.5
        }
    }
    
    public func body(content: Content) -> some View {
        let surface = content.overlay(
            Capsule()
                .fill(Color.Neumorphic.pressedSurface)
                .opacity(pressedSurfaceOpacity)
        )
        switch visualState {
        case .up:
            surface
                .softOuterShadow(offset: 0.075 * min(width, height), radius: 0.0375 * min(width, height))
        case .center:
            surface
                .softOuterShadow(
                    darkShadow:  Color.clear,
                    lightShadow: Color.clear,
                    offset: 0.075 * min(width, height), radius: 0)
                .softInnerShadow(Capsule(), size: CGSize(width: width, height: height), darkShadow: Color.clear, lightShadow: Color.clear, radius: 0.0925 * min(width, height))
        case .down:
            surface
                .softInnerShadow(Capsule(), size: CGSize(width: width, height: height), darkShadow: Color.Neumorphic.pressedDarkShadow, lightShadow: Color.Neumorphic.lightShadow, radius: 0.0925 * min(width, height))
        }
    }
}

extension View {
    public func neumorphicKey(width: CGFloat, height: CGFloat, _ visualState: VisualState) -> some View {
        self.modifier(NeumorphicKey(width: width, height: height, visualState: visualState))
    }
}
