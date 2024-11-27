//
//  CalculatorButtonModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI
import NumberTranslator

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
        let offset: CGFloat = diameter / 80.0 * 6.0
        let blurRadius: CGFloat = 0.5 * offset
        let borderWidth: CGFloat = 2 * offset
//        .frame(width: diameter - 2 * model.borderWidth, height: diameter - 2 * model.borderWidth)
//        .frame(width: geometry.size.width, height: geometry.size.height)
//        .clipShape(Capsule())
//        .padding(model.padding)
//        .brightness(isPressed ? 0.2 : 0.0)
//        .overlay(
//            Capsule()
//                .stroke(model.borderColor, lineWidth: model.borderWidth)
//        )
//        .padding(model.padding)

        let _ = print(diameter)
        if let image = image {
            return AnyView(
                ZStack {
                    if pressed {
                        Color.Neumorphic.main
                            .frame(width: diameter, height: diameter)
                            .clipShape(Circle())
                            .softInnerShadow(Circle())
                    } else {
                        Color.Neumorphic.main
                            .frame(width: diameter, height: diameter)
                            .clipShape(Circle())
                            .shadow(color: Color.Neumorphic.darkShadow, radius: blurRadius, x: offset, y: offset)
                            .shadow(color: Color.Neumorphic.lightShadow, radius: blurRadius, x: -offset, y: -offset)
                    }
                    image
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: diameter - 2 * borderWidth, height: diameter - 2 * borderWidth)
                }
//                    .softInnerShadow(Circle())
            )
        }
        return AnyView(EmptyView())
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
