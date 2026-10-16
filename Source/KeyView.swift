//
//  KeyView.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI
import Neumorphic

struct KeyView: View {
    let key: KeyModel

    private var surface: some View {
#if CALCULATOR_IOS
        let colors = key.symbolKey.flatMap { CalculatorPalette.colors(for: $0.op) }
        return (colors?.fill.color ?? Color.Neumorphic.main)
            .frame(width: key.width, height: key.height)
            .clipShape(Capsule())
            .neumorphicKey(
                width: key.width,
                height: key.height,
                key.visualState,
                pressedSurface: colors?.pressedFill.color ?? Color.Neumorphic.pressedSurface,
                lightShadow: colors?.lightShadow.color ?? Color.Neumorphic.lightShadow,
                darkShadow: colors?.darkShadow.color ?? Color.Neumorphic.darkShadow,
                pressedDarkShadow: colors?.pressedDarkShadow.color ?? Color.Neumorphic.pressedDarkShadow,
                pressedLightShadow: colors?.pressedLightShadow.color,
                outerShadowOffsetRatio: colors?.outerShadowOffsetRatio ?? CalculatorPalette.defaultOuterShadowOffsetRatio,
                outerShadowRadiusRatio: colors?.outerShadowRadiusRatio ?? CalculatorPalette.defaultOuterShadowRadiusRatio
            )
#else
        return Color.Neumorphic.main
            .frame(width: key.width, height: key.height)
            .clipShape(Capsule())
            .neumorphicKey(width: key.width, height: key.height, key.visualState)
#endif
    }

    var body: some View {
        ZStack {
            surface
            key.view.opacity(key.isEnabled ? 1 : 0.35)
        }
        .id(key.visualResetID)
        .keyGestures(key: key, width: key.width, height: key.height)
        .disabled(!key.isEnabled)
        .allowsHitTesting(key.isEnabled)
    }
}

#Preview("Dark") {
    Demo()
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    Demo()
        .preferredColorScheme(.light)
}
