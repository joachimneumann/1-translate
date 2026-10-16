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
    var pressedSurface: Color = Color.Neumorphic.pressedSurface
    var lightShadow: Color = Color.Neumorphic.lightShadow
    var darkShadow: Color = Color.Neumorphic.darkShadow
    var pressedDarkShadow: Color = Color.Neumorphic.pressedDarkShadow
    var pressedLightShadow: Color? = nil
    var outerShadowOffsetRatio: CGFloat = 0.075
    var outerShadowRadiusRatio: CGFloat = 0.0375

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
                .fill(pressedSurface)
                .opacity(pressedSurfaceOpacity)
        )
        switch visualState {
        case .up:
            surface
                .softOuterShadow(darkShadow: darkShadow, lightShadow: lightShadow, offset: outerShadowOffsetRatio * min(width, height), radius: outerShadowRadiusRatio * min(width, height))
        case .center:
            surface
                .softOuterShadow(
                    darkShadow:  Color.clear,
                    lightShadow: Color.clear,
                    offset: outerShadowOffsetRatio * min(width, height), radius: 0)
                .softInnerShadow(Capsule(), size: CGSize(width: width, height: height), darkShadow: Color.clear, lightShadow: Color.clear, radius: 0.0925 * min(width, height))
        case .down:
            surface
                .softInnerShadow(Capsule(), size: CGSize(width: width, height: height), darkShadow: pressedDarkShadow, lightShadow: pressedLightShadow ?? lightShadow, radius: 0.0925 * min(width, height))
        }
    }
}

extension View {
    public func neumorphicKey(
        width: CGFloat,
        height: CGFloat,
        _ visualState: VisualState,
        pressedSurface: Color = Color.Neumorphic.pressedSurface,
        lightShadow: Color = Color.Neumorphic.lightShadow,
        darkShadow: Color = Color.Neumorphic.darkShadow,
        pressedDarkShadow: Color = Color.Neumorphic.pressedDarkShadow,
        pressedLightShadow: Color? = nil,
        outerShadowOffsetRatio: CGFloat = 0.075,
        outerShadowRadiusRatio: CGFloat = 0.0375
    ) -> some View {
        self.modifier(NeumorphicKey(
            width: width,
            height: height,
            visualState: visualState,
            pressedSurface: pressedSurface,
            lightShadow: lightShadow,
            darkShadow: darkShadow,
            pressedDarkShadow: pressedDarkShadow,
            pressedLightShadow: pressedLightShadow,
            outerShadowOffsetRatio: outerShadowOffsetRatio,
            outerShadowRadiusRatio: outerShadowRadiusRatio
        ))
    }
}
