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
//        .frame(width: size.width, height: size.height)
//        .onAppear() {
//            keyboard.setSize(size)
//        }
    }
}


//ForEach(keyboard.keyMatrix.dropLast().indices, id: \.self) { rowIndex in
//    HStack(spacing: spacing) {
//        ForEach(keyboard.keyMatrix[rowIndex], id: \.id) { key in
//            KeyView(key: key)
//        }
//    }
//    Spacer(minLength: 0.0)
//}


#Preview("Dark") {
    let keyboard: KeyboardModel = KeyboardModel()
    
    ZStack {
        Rectangle()
            .foregroundColor(Color.Neumorphic.main)
        VStack {
            Spacer()
            HStack {
                Spacer()
                KeyboardView(keyboard: keyboard)
//                    .background(.yellow)
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
    let w: CGFloat = 300
    let h: CGFloat = 600
    let keyboard: KeyboardModel = KeyboardModel()
    let _ = keyboard.standardKeyboard(width: w, height: h)
    ZStack {
        Rectangle()
            .foregroundColor(Color.red)//Neumorphic.main)
        VStack {
            Spacer()
            HStack {
                Spacer()
                KeyboardView(keyboard: keyboard)
                    .frame(width: keyboard.actualSize.width, height: keyboard.actualSize.height)
                    .padding(keyboard.padding)
                    .background(Color.Neumorphic.main)
                Spacer()
            }
            Spacer(minLength: 100)
        }
    }
    .background(Color.Neumorphic.main)
    .preferredColorScheme(.light)
}
