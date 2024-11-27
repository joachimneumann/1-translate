//
//  CalculatorButtonModel.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

struct NeumorphicModifier: ViewModifier {
    var pressed: Bool
    
    func body(content: Content) -> some View {
        if pressed {
            content
//                .softInnerShadow(Circle())
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
    private var flagImage: Image? = nil
    var symbolKeyViewModel: SymbolKeyViewModel? = nil
    let diameter: CGFloat
    
    init(languageEnum: NumberTranslator.LanguageEnum, diameter: CGFloat) {
        if AppleImage(named: translationManager.flagName(languageEnum) + "Sqr") != nil {
            flagImage = Image(translationManager.flagName(languageEnum) + "Sqr")
        } else if AppleImage(named: translationManager.flagName(languageEnum)) != nil {
            flagImage = Image(translationManager.flagName(languageEnum))
        } else {
            flagImage = Image("English")
        }
        self.diameter = diameter
    }
    
    init(op: any OpProtocol, diameter: CGFloat) {
        self.diameter = diameter
        self.symbolKeyViewModel = SymbolKeyViewModel(op: op)
        super.init()
        self.symbolKeyViewModel!.newSize(CGSize(width: diameter, height: diameter))
    }
    
    var symbol: AnyView? {
        if let symbolKeyViewModel = symbolKeyViewModel {
            return AnyView(
                symbolKeyViewModel.label
                    .scaleEffect(visualPressed ? 0.98 : 1.0)
                    .brightness(visualPressed ? -0.1 : 0.0)
            )
        }
        return nil
    }
    
    var flag: AnyView? {
        if let flag = flagImage {
            let borderWidth: CGFloat = diameter * 0.125
            return AnyView(
                flag
                    .resizable()
                    .scaledToFill()
                    .brightness(visualPressed ? -0.1 : 0.0)
                    .clipShape(Circle())
                    .frame(width: diameter - 2 * borderWidth, height: diameter - 2 * borderWidth)
                    .scaleEffect(visualPressed ? 0.98 : 1.0)
            )
        }
        return nil
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
                    CalculatorButton(model: CalculatorButtonModel(op: InplaceOperation.sqrt, diameter: diameter))
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
