//
//  CalculatorKey.swift
//  Calculator
//
//  Created by Joachim Neumann on 27.11.2024.
//

import SwiftUI
import SwiftGmp
import NumberTranslator

struct NeumorphicModifier: ViewModifier {
    let diameter: CGFloat
    var pressed: VisualPressedState
    
    func body(content: Content) -> some View {
        switch pressed {
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
    func neumorphic(diameter: CGFloat, _ pressed: VisualPressedState) -> some View {
        self.modifier(NeumorphicModifier(diameter: diameter, pressed: pressed))
    }
}

@Observable class CalculatorKey: Key {
    private var flagImage: Image? = nil
    var symbolKeyViewModel: SymbolKeyViewModel? = nil
    private(set) var diameter: CGFloat = 0.0
    
    init(flagName: String) {
        flagImage = Image(flagName)
    }
    
    init(op: any OpProtocol) {
        self.symbolKeyViewModel = SymbolKeyViewModel(op: op)
        super.init()
        self.symbolKeyViewModel!.setColors(textColor: Color.Neumorphic.text, upColor: .red, downColor: .red)
        self.symbolKeyViewModel!.newSize(CGSize(width: diameter, height: diameter))
    }
    
    func setDiameter(_ new: CGFloat) {
        diameter = new
        self.symbolKeyViewModel?.newSize(CGSize(width: diameter, height: diameter))
    }
    
    var flagScale: CGFloat {
        switch visualPressed {
        case .up: 1.0
        case .center: 0.997
        case .down: 0.989
        }
    }
    
    var symbolScale: CGFloat {
        switch visualPressed {
        case .up: 1.0
        case .center: 0.995
        case .down: 0.98
        }
    }

    var flagBrightness: CGFloat {
        switch visualPressed {
        case .up: 0.0
        case .center: -0.02
        case .down: -0.06
        }
    }
    
    var symbolBrightness: CGFloat {
        switch visualPressed {
        case .up: 0.0
        case .center: -0.04
        case .down: -0.2
        }
    }

    var symbol: AnyView? {
        if let symbolKeyViewModel = symbolKeyViewModel {
            return AnyView(
                symbolKeyViewModel.label
                    .scaleEffect(symbolScale)
                    .brightness(symbolBrightness)
            )
        }
        return nil
    }
    
    var flag: AnyView? {
        if let flag = flagImage {
            let borderWidth: CGFloat = diameter * 0.1//25
            return AnyView(
                flag
                    .resizable()
                    .scaledToFill()
                    .brightness(flagBrightness)
                    .clipShape(Circle())
                    .frame(width: diameter - 2 * borderWidth, height: diameter - 2 * borderWidth)
                    .scaleEffect(flagScale)
            )
        }
        return nil
    }
}

struct Demo: View {
    let flagName: String
    let m1: CalculatorKey
    let m2: CalculatorKey
    init() {
        let translationManager = TranslationManager()
        if AppleImage(named: translationManager.flagName(.english) + "Sqr") != nil {
            flagName = translationManager.flagName(.english) + "Sqr"
        } else {
            flagName = translationManager.flagName(.english)
        }
        m1 = CalculatorKey(flagName: flagName)
        m2 = CalculatorKey(op: InplaceOperation.sqrt)
    }
    
    var body: some View {
        ZStack {
            Rectangle()
                .foregroundColor(Color.Neumorphic.main)
            VStack {
                HStack(spacing: m1.diameter / 2) {
                    CalculatorKeyView(model: m1)
                    CalculatorKeyView(model: m2)
                }
                .frame(width: 200)
            }
            .background(Color.Neumorphic.main)
        }
        .onAppear() {
            m1.setDiameter(130)
            m2.setDiameter(130)
        }
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
