//
//  CalculatorKeyboardView.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI

struct CalculatorKeyboardView: View {
    @State private var navigateToConfigView = false
    let size: CGSize
    @State var keyboard: CalculatorKeyboard
    
    init(size: CGSize, keyboard: CalculatorKeyboard) {
        self.size = size
        self.keyboard = keyboard
    }
    
    var body: some View {
        VStack(spacing: keyboard.keySpacing) {
            ForEach(keyboard.keyMatrix.indices, id: \.self) { rowIndex in
                HStack(spacing: keyboard.keySpacing) {
                    ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
                        CalculatorKeyView(model: key)
                    }
                }
            }
        }
        .frame(width: size.width, height: size.height)
        .onAppear() {
            keyboard.setSize(size)
        }
    }
}

#Preview("Dark") {
    let keyboard: CalculatorKeyboard = CalculatorKeyboardStandard()
    
    ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
        VStack {
            Spacer()
            HStack {
                Spacer()
                CalculatorKeyboardView(size: CGSize(width: 440.0, height: 769.6666666666667), keyboard: keyboard)
                    .background(.yellow)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                Spacer()
            }
            Spacer(minLength: 100)
        }
    }
    .background(Color.Neumorphic.main)
    .preferredColorScheme(.dark)
}

#Preview("Light") {
    let keyboard: CalculatorKeyboard = CalculatorKeyboardStandard()
    
    ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
        VStack {
            Spacer()
            HStack {
                Spacer()
                CalculatorKeyboardView(size: CGSize(width: 400, height: 450), keyboard: keyboard)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                Spacer()
            }
            Spacer(minLength: 100)
        }
    }
    .background(Color.Neumorphic.main)
    .preferredColorScheme(.light)
}
