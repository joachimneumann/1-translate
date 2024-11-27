//
//  CalculatorButtonModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI
import NumberTranslator

struct NeumorphicModifier: ViewModifier {
    var pressed: Bool

    func body(content: Content) -> some View {
        if pressed {
            content
                .softInnerShadow(Circle())
        } else {
            content
                .softOuterShadow()
        }
    }
}

extension View {
    func neumorphic(pressed: Bool) -> some View {
        self.modifier(NeumorphicModifier(pressed: pressed))
    }
}

@Observable class CalculatorButtonModel: Key {
    let translationManager = TranslationManager()
    var image: Image? = nil
    let diameter: CGFloat
    
    init(languageEnum: NumberTranslator.LanguageEnum, diameter: CGFloat) {
        if AppleImage(named: translationManager.flagName(languageEnum) + "Sqr") != nil {
            image = Image(translationManager.flagName(languageEnum) + "Sqr")
        } else if AppleImage(named: translationManager.flagName(languageEnum)) != nil {
            image = Image(translationManager.flagName(languageEnum))
        } else {
            image = Image("English")
        }
        self.diameter = diameter
    }
    
    var view: some View {
        if let image = image {
            let borderWidth: CGFloat = diameter * 0.125
            return AnyView(
                ZStack {
                    Color.Neumorphic.main
                        .frame(width: diameter, height: diameter)
                        .clipShape(Circle())
                        .neumorphic(pressed: visualPressed)
                    image
                        .resizable()
                        .scaledToFill()
                        .brightness(visualPressed ? -0.1 : 0.0)
                        .clipShape(Circle())
                        .frame(width: diameter - 2 * borderWidth, height: diameter - 2 * borderWidth)
                        .scaleEffect(visualPressed ? 0.98 : 1.0)
                }
                    .applyCalculatorPressGestures(key: self, diameter: diameter)
            )
        } else {
            return AnyView(EmptyView())
        }
    }
}

struct Demo: View {
    let diameter: CGFloat
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
            VStack {
                HStack(spacing: diameter) {
                    CalculatorButton(model: CalculatorButtonModel(languageEnum: .vietnamese, diameter: diameter))
                    CalculatorButton(model: CalculatorButtonModel(languageEnum: .german, diameter: diameter))
                }
                .frame(width: 200, height: 100)
            }
            .background(Color.Neumorphic.main)
        }
    }
}

#Preview("Dark") {
    Demo(diameter: 60)
        .preferredColorScheme(.dark)
}

#Preview("Light") {
    Demo(diameter: 60)
        .preferredColorScheme(.light)
}
