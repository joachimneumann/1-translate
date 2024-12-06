//
//  KeyboardView.swift
//  Calculator
//
//  Created by Joachim Neumann on 30.11.2024.
//

import SwiftUI

struct KeyboardView: View {
    @State private var navigateToConfigView = false
    @State var keyboard: KeyboardModel
    
    init(keyboard: KeyboardModel) {
        print("init CalculatorKeyboardView")
        self.keyboard = keyboard
    }
    
    var body: some View {
        VStack {
            ForEach(keyboard.keyMatrix.dropLast().indices, id: \.self) { rowIndex in
                HStack {
                    ForEach(keyboard.keyMatrix[rowIndex].dropLast(), id: \.id) { key in
                        KeyView(key: key)
                        Spacer(minLength: 0.0)
                    }
                    if let last = keyboard.keyMatrix[rowIndex].last {
                        KeyView(key: last)
                    }
                }
                Spacer(minLength: 0.0)
            }
            HStack {
                if let lastRow = keyboard.keyMatrix.last {
                    ForEach(lastRow.dropLast(), id: \.id) { key in
                        KeyView(key: key)
                        Spacer(minLength: 0.0)
                    }
                    if let last = lastRow.last {
                        KeyView(key: last)
                    }
                }
            }
        }
        .padding(keyboard.padding)
    }
}


#Preview("Dark") {
    let keyboard: KeyboardModel = KeyboardModel()
    let _ = keyboard.standardKeyboard()

    ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
        VStack {
            Spacer()
            HStack {
                Spacer()
                KeyboardView(keyboard: keyboard)
                    .frame(width: keyboard.frame.width, height: keyboard.frame.height)
                Spacer()
            }
        }
    }
    .background(Color.Neumorphic.main)
    .preferredColorScheme(.dark)
}

#Preview("Light") {
    let keyboard: KeyboardModel = KeyboardModel()
    let _ = keyboard.standardKeyboard()
    ZStack {
        Rectangle()
            .foregroundColor(Color.red)//Neumorphic.main)
            .ignoresSafeArea()
        VStack {
            Spacer()
            HStack {
                Spacer()
                KeyboardView(keyboard: keyboard)
                    .frame(width: keyboard.frame.width, height: keyboard.frame.height)
                    .background(Color.Neumorphic.main)
                Spacer()
            }
        }
    }
    .background(Color.Neumorphic.main)
    .preferredColorScheme(.light)
}
