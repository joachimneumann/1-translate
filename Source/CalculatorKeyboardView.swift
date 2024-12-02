//
//  CalculatorKeyboardView.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI

struct CalculatorKeyboardView: View {
    @State private var navigateToConfigView = false
    
    var keyboard: CalculatorKeyboard
    
    init(keyboard: CalculatorKeyboard) {
        self.keyboard = keyboard
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: keyboard.keySpacing) {
                ForEach(keyboard.keyMatrix.indices, id: \.self) { rowIndex in
                    HStack(spacing: keyboard.keySpacing) {
                        ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
                            CalculatorKeyView(model: key)
                        }
                    }
                }
            }
            .frame(width: geo.size.width, height: geo.size.height)
            .onAppear() {
                print("CalculatorKeyboardView size \(geo.size)")
                keyboard.setSize(geo.size)
            }
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
                CalculatorKeyboardView(keyboard: keyboard)
                    .frame(width: 300, height: 450)
                    .padding(.top, 10)
                    .padding(.bottom, 50)
                    .background(.yellow)
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
                CalculatorKeyboardView(keyboard: keyboard)
                    .frame(width: 300, height: 450)
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
