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

class CalculatorButtonModel {
    let translationManager = TranslationManager()
    var image: Image? = nil
    let diameter: CGFloat
    let pressed: Bool
    init(languageEnum: NumberTranslator.LanguageEnum, diameter: CGFloat, pressed: Bool) {
        self.pressed = pressed
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
            let offset: CGFloat = diameter / 80.0 * 6.0
            let blurRadius: CGFloat = 0.5 * offset
            let borderWidth: CGFloat = 2 * offset
            return AnyView(
                ZStack {
                    Color.Neumorphic.main
                        .frame(width: diameter, height: diameter)
                        .clipShape(Circle())
                        .neumorphic(pressed: pressed)
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: diameter - 2 * borderWidth, height: diameter - 2 * borderWidth)
                }
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
                    Button(action: {}) {
                        Image("Deutsch")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    .softButtonStyle(Circle())
                    .frame(width: diameter, height: diameter)
                    CalculatorButton(model: CalculatorButtonModel(languageEnum: .vietnamese, diameter: diameter, pressed: false))
                    CalculatorButton(model: CalculatorButtonModel(languageEnum: .german, diameter: diameter, pressed: false))
                }
                .frame(width: 200, height: 100)
                HStack(spacing: diameter) {
                    Button(action: {}) {
                        Image("Deutsch")
                            .resizable()
                            .scaledToFit()
                            .clipShape(Circle())
                    }
                    .softButtonStyle(Circle())
                    .frame(width: diameter, height: diameter)
                    CalculatorButton(model: CalculatorButtonModel(languageEnum: .vietnamese, diameter: diameter, pressed: true))
                    CalculatorButton(model: CalculatorButtonModel(languageEnum: .german, diameter: diameter, pressed: true))
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
